---
name: departamento-medico
description: Hub maestro de orquestación fullstack, estándares de arquitectura senior sin parches y aislamiento bi-repo para el Departamento Médico ISTPET.
---

# Skill Maestra: Departamento Médico ISTPET (Orquestación Senior Bi-Repo)

Esta skill es el punto de entrada principal para el desarrollo y auditoría técnica del sistema del Departamento Médico ISTPET. Establece el estándar senior permanente (+10 años en producción), la regla de causa raíz y la orquestación bi-repositorio sin parches.

---

## 1. Mandato Senior: Causa Raíz y Cero Parches

* **Estado Base Permanente:** El desarrollo en este proyecto se rige por principios de alta cohesión, bajo acoplamiento, tipado estricto y diseño robusto.
* **Prohibiciones Terminantes:**
  * Prohibido el uso de `any` o casts forzados (`as any`) en el frontend TypeScript.
  * Prohibido enmascarar excepciones con bloques `try-catch` vacíos o retornos de listas vacías sin justificación.
  * Prohibido realizar consultas completas en memoria (`AsEnumerable()` / `ToList()`) para evitar configurar índices o relaciones en base de datos.
  * Prohibido eludir validaciones de negocio en el frontend o en el backend.
* **Diagnóstico antes de Código:** Identificar y erradicar siempre el origen del problema. Nunca tapar síntomas.

---

## 2. Mapa de Skills Técnicas Especializadas

| Skill | Ámbito / Módulo | Propósito y Estándares |
| :--- | :--- | :--- |
| **`medico-backend`** | `departamento_medico_istpet` | Clean Architecture pura en .NET 8, C# Latest, `<Nullable>enable</Nullable>`, Result Pattern funcional, Primary Constructors, Comandos `sealed record`, 39 tablas MySQL Pomelo, consultas `IQueryable` eficientes, integración Sigafi, ProblemDetails RFC 7807 y HealthChecks. |
| **`medico-frontend`** | `departamento_medico_istpet-front` | Angular 22 SSR sobre Express 5 y Node 22, componentes Standalone con `ChangeDetectionStrategy.OnPush`, reactividad con Angular Signals (`signal`, `computed`), inyección moderna con `inject()`, DTOs espejados con cero `any`, diseño Fluent 2 (Navy & Gold, semáforo clínico) y pruebas con Vitest. |
| **`medico-gitflow`** | Control de versiones y CI/CD | Manual operativo de 6 pasos de GitLab ISTPET (Issues con 4 labels y Milestone, ramas regex `<tipo>/<id-issue>-<slug>`, commits convencionales de 10 a 72 caracteres, MRs con `Closes #ID`, matriz de 6 linters institucionales y cheatsheet en PowerShell). |
| **`medico-infra`** | Despliegue y Contenedores | Infraestructura sobre K3s, Envoy Gateway (`HTTPRoute`), Harbor, Kaniko, Dockerfile multi-stage en Alpine sin root y estrategia de migraciones por Kubernetes Job. |

---

## 3. Matriz de Correspondencia de Módulos Clínicos

| Módulo Clínico | Backend (.NET 8 Clean Arch) | Frontend (Angular 22 SSR) | Tablas Relevantes (MySQL) |
| :--- | :--- | :--- | :--- |
| **Fichas Médicas Estudiantiles** | `Domain/FichasMedicas`, `CasosDeUso/FichasMedicas`, `FichasMedicasController.cs` | `src/app/pages/fichas-medicas/` | `MFICH_FICHA_MEDICA`, `MAME_ANTECE_MED`, `MAND_ANTECE_DET`, `MREV_REVISION_O` |
| **Atención Urgencias & Trauma (V2)** | `Domain/Atenciones`, `CasosDeUso/Atenciones`, `AtencionesV2Controller.cs` | `src/app/pages/atencion-v2/` | `MFIC_FICHAS`, `MFIA_FICHA_ATEN`, `MCON_CONSTAN_VI`, `MGLA_ESCALA_GLASGOW`, `MTRA_TRAUMA`, `MMAT_MATERIAL` |
| **Atención Ambulatoria (V1)** | `Domain/Atenciones`, `AtencionesController.cs` | `src/app/pages/atencion-v1/` | `MFIC_FICHAS`, `MFIA_FICHA_ATEN` |
| **Seguimiento Clínico DM** | `Domain/Seguimientos`, `CasosDeUso/Seguimientos`, `SeguimientosController.cs` | `src/app/pages/seguimiento-dm/` | `MSEG_SEGUIMIENTO`, `MADA_ADAPTA`, `MTAD_TIPO_ADAPTACION` |
| **Validación de Certificados** | `Domain/Validaciones`, `CasosDeUso/Validaciones`, `ValidacionesController.cs` | `src/app/pages/validacion-certificados/` | `MVAL_VALIDACION` |
| **Padrón Estudiantil LOPDP** | `Domain/Estudiantes`, `CasosDeUso/RegistrarEstudiante`, `EstudiantesController.cs` | Integración transversal en todos los módulos | `Estudiantes` (cédula única, índice LOPDP) y lectura a `Sigafi` |

---

## 4. Regla de Aislamiento de Git en el Workspace

* Toda configuración de agente ([`.agents/`](file:///c:/Users/DESARROLLADOR/Desktop/Proyectos/departamento_medico/.agents), memoria, skills) reside **estrictamente en la raíz del workspace**.
* **Queda prohibido** añadir o copiar archivos de tooling personal dentro de los repositorios `departamento_medico_istpet` o `departamento_medico_istpet-front`.
* Los commits en los repositorios de los compañeros deben contener única y exclusivamente código fuente de la aplicación, pruebas o manifiestos estándar del proyecto.
