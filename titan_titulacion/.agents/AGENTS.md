# Reglas del Proyecto (Titulación ISTPET)

Este archivo define el stack tecnológico, arquitectura y estándares de ingeniería exclusivos del sistema **Titulación ISTPET** (Gestión de Procesos de Grado y Titulación del ISTPET). Las reglas globales aplican automáticamente.

---

## 1. Stack Tecnológico y Arquitectura

* **Backend:** ASP.NET Core (.NET 8/9), C#, Entity Framework Core, MySQL.
  - Arquitectura: Clean Architecture en 4 capas concéntricas (`Domain`, `Application`, `Infrastructure`, `Api`).
  - Patrones: CQRS / Handlers por caso de uso (*One Handler per File*), Primary Constructors, DTOs inmutables con `record`, File-scoped Namespaces.
  - Concurrencia e I/O: Operaciones de persistencia 100% `async/await` con propagación de `CancellationToken`.
  - Seguridad: Autenticación JWT, contraseñas con BCrypt, RBAC por roles académicos.
* **Frontend:** React, Vite, TypeScript.
  - UI/UX: Sistema institucional de Titulación ISTPET, tipado estricto (cero `any`).

---

## 2. Reglas Cardinales de Ingeniería

1. **Cero Parches y Causa Raíz:** Resolver siempre el origen arquitectónico. Prohibido añadir código defensivo para tapar entidades mal mapeadas o contratos defectuosos.
2. **Controladores Delgados:** Controladores HTTP entre 30 y 80 líneas que solo validan y delegan a los handlers de aplicación.
3. **Persistencia Eficiente:** Consultas de lectura con `.AsNoTracking()`, carga explícita de relaciones requeridas con `.Include()` / `.ThenInclude()` y transaccionalidad atómica.
4. **Cero Emojis y Cero Lenguaje Inflado** en código, respuestas y documentación.

---

## 3. Orquestación y Activación de Skills (Titulación ISTPET)

* **Tareas de Backend (C#, .NET 8, EF Core, MySQL, APIs, CQRS):**
  1. Activar skill global `desarrollo-backend`.
  2. Activar skill local `titulacion-backend`.
* **Tareas de Frontend (UI, React, TypeScript):**
  1. Activar skill global `desarrollo-frontend`.
  2. Activar skill local `titulacion-frontend`.
* **Tareas de Diseño y Estilos:**
  1. Activar skill global `desarrollo-frontend`.
  2. Activar skill local `titulacion-ui-design`.
* **Tareas de Documentación:** Activar skill global `documentacion`.
