---
name: medico-infra
description: Guía técnica de infraestructura, contenedores Docker multi-stage, K3s, Envoy Gateway, Harbor y manifiestos de despliegue para el Departamento Médico ISTPET.
---

# Skill: Infraestructura, Contenedores & Despliegue K3s (ISTPET)

Esta skill documenta la topología de despliegue, configuración de contenedores, enrutamiento con Envoy Gateway y gestión de variables para el sistema del Departamento Médico ISTPET.

---

## 1. Topología del Entorno de Infraestructura

El despliegue institucional se basa en una arquitectura de micro-servicios contenerizados sobre Kubernetes ligero:

* **Orquestador:** K3s v1.28+ en servidores institucionales.
* **Ingress / Gateway:** Envoy Gateway implementando la API estándar `Gateway.networking.k8s.io` (v1 `HTTPRoute`).
* **Registro de Imágenes:** Harbor institucional con escaneo de vulnerabilidades Trivy.
* **Construcción en CI/CD:** Kaniko (permite generar imágenes OCI dentro de pods sin socket `docker.sock` privilegiado).
* **Base de Datos:** Instancia MySQL 8.0 gestionada y respaldada en la red interna del instituto.

---

## 2. Dockerfiles Multi-Stage (Optimización y Seguridad)

Ambos proyectos utilizan compilación por etapas (Multi-Stage Builds) sobre distribuciones Alpine para minimizar superficie de ataque y peso de imagen:

### 2.1. Backend (`departamento_medico_istpet/Dockerfile`)
* **Etapa 1 (Build):** `mcr.microsoft.com/dotnet/sdk:8.0-alpine`
  * Restaura paquetes NuGet usando cachés de capas.
  * Compila en perfil Release con optimizaciones de producción.
* **Etapa 2 (Runtime):** `mcr.microsoft.com/dotnet/aspnet:8.0-alpine`
  * Ejecuta bajo usuario no privilegiado (`appuser` / UID 10001).
  * Soporte de modo invariante de globalización (`DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1`).
  * Puerto expuesto: 8080 (mapeado internamente).

### 2.2. Frontend (`departamento_medico_istpet-front/Dockerfile`)
* **Etapa 1 (Build):** `node:22-alpine`
  * Ejecuta `npm ci` respetando `package-lock.json`.
  * Compila el bundle de cliente y servidor SSR (`npm run build`).
* **Etapa 2 (Runtime):** `node:22-alpine`
  * Modo de ejecución: Servidor Express SSR (`dist/sistema-medico-front/server/server.mjs`).
  * Usuario no root (`node`).
  * Puerto expuesto: 4000.

---

## 3. Manifiestos de Kubernetes (`deploy/k8s/`)

Tanto backend como frontend cuentan con sus manifiestos declarativos sincronizados:

### 3.1. `deployment.yaml`
* **Liveness Probe:**
  * Backend: `GET /health/live` (puerto 8080). No toca la base de datos para prevenir ciclos CrashLoopBackOff ante latencia externa.
  * Frontend: `GET /` o check de proceso Node.js.
* **Readiness Probe:**
  * Backend: `GET /health/ready` (valida conectividad real a MySQL).
* **Gestión de Recursos:** Límites (`limits`) y peticiones (`requests`) de CPU y Memoria estandarizados.
* **Inyección de Secretos:**
  ```yaml
  env:
    - name: ConnectionStrings__DepartamentoMedico
      valueFrom:
        secretKeyRef:
          name: departamento-medico-secrets
          key: mysql-connection-string
    - name: ConnectionStrings__Sigafi
      valueFrom:
        secretKeyRef:
          name: departamento-medico-secrets
          key: sigafi-connection-string
  ```

### 3.2. `service.yaml`
* Servicio tipo `ClusterIP` que expone el puerto del pod internamente dentro del namespace institucional `departamento-medico`.

### 3.3. `httproute.yaml`
* Conecta el servicio `ClusterIP` con el `Gateway` institucional de Envoy:
  * Reglas de path prefix (ej. `/api` hacia el backend, `/` hacia el frontend SSR).
  * Encabezados CORS y terminación TLS centralizada en el Gateway.

---

## 4. Estrategia de Migraciones en Kubernetes

* **Prohibido en Producción:** Ejecutar `contexto.Database.EnsureCreatedAsync()` o migrar en el arranque del Pod de la API (múltiples réplicas en paralelo provocarían bloqueos y condiciones de carrera en MySQL).
* **Procedimiento Institucional:**
  1. Generar la migración localmente:
     ```powershell
     dotnet ef migrations add <Nombre> `
       -p src/Istpet.DepartamentoMedico.Infrastructure `
       -s src/Istpet.DepartamentoMedico.WebApi
     ```
  2. Generar el script SQL idempotente:
     ```powershell
     dotnet ef migrations script --idempotent -o deploy/sql/migracion.sql
     ```
  3. Ejecutar la migración mediante un `Job` de Kubernetes antes de actualizar el `Deployment` de la API.

---

## 5. Matriz de Entornos: Local vs. Kubernetes K3s

| Parámetro | Desarrollo Local | Producción (K3s) |
| :--- | :--- | :--- |
| **URL Backend** | `http://localhost:5000` | Inyectada por Envoy Gateway (`/api`) |
| **URL Frontend** | `http://localhost:4200` | Dominio institucional con HTTPS |
| **Cadenas de Conexión** | `dotnet user-secrets` o `appsettings.Local.json` | K8s Secret `departamento-medico-secrets` |
| **OAuth Redirect** | `http://localhost:4200/redirigir` | `https://medico.istpet.edu.ec/redirigir` |
| **Esquema BD** | `EnsureCreatedAsync()` inicial | Migraciones versionadas en K8s Job |
