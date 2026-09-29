# Memoria del Proyecto — Titulación ISTPET

Este archivo almacena el contexto operativo, decisiones arquitectónicas consolidadas y lecciones aprendidas exclusivas del sistema Titulación ISTPET.

---

## 1. Decisiones Arquitectónicas Consolidadas

* **Backend (.NET 8/9 C#):**
  - Clean Architecture en 4 capas concéntricas (`Domain`, `Application`, `Infrastructure`, `Api`).
  - Patrón CQRS / Handlers por caso de uso (*One Handler per File*).
  - Persistencia con Entity Framework Core sobre MySQL.
  - I/O no bloqueante con `async/await` y `CancellationToken` obligatorio.
* **Frontend:**
  - React con Vite y TypeScript, componentes modulares y tipado estricto.
* **Seguridad:**
  - JWT, hashing con BCrypt, RBAC estricto.
* **Estándar:**
  - Cero emojis y cero lenguaje publicitario o inflado.

---

## 2. Historial de Decisiones y Lecciones Aprendidas

* *(El agente registrará aquí automáticamente las decisiones técnicas tomadas durante futuras sesiones)*.
