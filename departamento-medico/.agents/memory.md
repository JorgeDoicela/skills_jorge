# Memoria de Proyecto: Departamento Médico ISTPET

## 1. Contexto General y Estructura Multi-Repositorio

El espacio de trabajo alberga dos repositorios independientes con control de versiones Git separado:

* **Backend (`departamento_medico_istpet`):** API REST desarrollada en .NET 8 con Clean Architecture pura, Entity Framework Core (MySQL Pomelo, 39 tablas) e integración de consulta con el sistema institucional Sigafi.
* **Frontend (`departamento_medico_istpet-front`):** Portal web desarrollado en Angular 22 con Server-Side Rendering (SSR sobre Node 22 / Express 5), autenticación Microsoft Entra ID (Azure AD MSAL), sistema de diseño Fluent 2 y pruebas con Vitest.
* **Entorno de Agente Local (`.agents/`):** Ubicado exclusivamente en la raíz del espacio de trabajo. No forma parte de los repositorios Git de los submódulos para no alterar el flujo de trabajo del equipo.

---

## 2. Mapa de Skills Locales Disponibles

En `.agents/skills/` se encuentra el suite técnico modular del proyecto:

1. **`departamento-medico` (`.agents/skills/departamento-medico/SKILL.md`):** Hub maestro de orquestación fullstack, reglas de aislamiento y matriz de correspondencia de módulos clínicos.
2. **`medico-backend` (`.agents/skills/medico-backend/SKILL.md`):** Clean Architecture .NET 8, inventario de las 39 tablas MySQL, casos de uso, Pomelo EF Core, integración Sigafi y WebApi.
3. **`medico-frontend` (`.agents/skills/medico-frontend/SKILL.md`):** Angular 22 SSR, páginas clínicas (`atencion-v2`, `fichas-medicas`, `seguimiento-dm`, `validacion-certificados`), MSAL Entra ID, biblioteca de componentes shared y tokens Fluent 2.
4. **`medico-gitflow` (`.agents/skills/medico-gitflow/SKILL.md`):** Flujo de trabajo institucional de GitLab ISTPET (Issues, ramas regex, commits 10-72 car., plantilla de MR con `Closes #ID` y los 6 linters CI/CD).
5. **`medico-infra` (`.agents/skills/medico-infra/SKILL.md`):** Infraestructura en K3s, Envoy Gateway (`HTTPRoute`), Harbor, Kaniko, Dockerfile multi-stage en Alpine y estrategia de migraciones por Job.

---

## 3. Decisiones Arquitectónicas Consolidadas

### Backend (.NET 8 - Clean Architecture)
* **Capas del Proyecto:**
  * `Domain`: Entidades médicas (`Atenciones`, `FichasMedicas`, `Seguimientos`, `Validaciones`, `Estudiantes`, `Cursos`), Value Objects (Glasgow, Signos Vitales, Cédula con validador ecuatoriano). Sin dependencias externas y lenguaje ubicuo en español.
  * `Application`: Casos de uso atómicos (`Atenciones`, `Catalogos`, `FichasMedicas`, `Seguimientos`, `Validaciones`), DTOs inmutables con `sealed record`, Primary Constructors y Result Pattern funcional (`Resultado<T>`).
  * `Infrastructure`: Acceso a datos con `DepartamentoMedicoDbContext` (MySQL 8.0 / Pomelo EF Core), mapeo Fluent API, consultas proyectadas con `.Select()`, `.AsNoTracking()` en lecturas, adaptador de solo lectura a Sigafi y `IUnidadDeTrabajo`.
  * `WebApi`: Punto de composición, controladores delgados, endpoints de salud (`/health/live`, `/health/ready`), Swagger UI (`/swagger`) y middleware RFC 7807 `ProblemDetails`.
* **Políticas de Calidad y Cero Parches:** `<Nullable>enable</Nullable>`, C# Latest, compilación determinista en Release. Prohibido enmascarar excepciones o consultar con `ToList()` prematuro.
* **Persistencia:** 39 tablas categorizadas entre operacionales (`Estudiantes`, `MFICH_*`, `MATE_*`, `MSEG_*`, `MVAL_*`, `MADA_*`) y catálogos maestros (`MAME_*`, `MTAD_*`, CIE-10).

### Frontend (Angular 22 - SSR & Fluent 2)
* **Arquitectura:** Componentes Standalone, `ChangeDetectionStrategy.OnPush` en el 100% de componentes, reactividad con Angular Signals (`signal`, `computed`), inyección moderna con `inject()`, SSR con `@angular/ssr` sobre Express 5.
* **Tipado Estricto:** Cero `any`, interfaces espejadas con los DTOs de backend (`*.models.ts`).
* **Módulos Clínicos:**
  * `acceso`: Flujo de autenticación MSAL con Entra ID.
  * `inicio`: Dashboard institucional y métricas de atención.
  * `atencion-v1`: Ficha de Atención Médica V1 — Urgencias y Trauma. Mantiene estrictamente las 4 tarjetas del diseño clínico original (Datos generales del evento/paciente con consulta SIGAFI, Interrogatorio y cinemática, Evaluación Glasgow y constantes vitales, Procedimientos/insumos y destino de derivación), conectadas 100% a la base de datos relacional MySQL (`MFIC_FICHAS`, `MFIA_FICHA_ATEN`, `MFCO_FICH_CONST`, `MGLA_ESCALA_GLASGOW`, `MENT_ENTREGA_PACIENTE`). Cero datos quemados: constantes y datos del evento inician limpios para atención real; persistencia completa y bidireccional de `LugarEvento`, `TipoEvento`, receptor y hora de entrega; soporte de carga de fichas existentes mediante query param (`?id=`); cierre y firma médica colegiada HU-12 con inmutabilidad RN-11 y exportación nativa a PDF.
  * `atencion-v2`: Atención médica general HCU-form.002 (Signos vitales, IMC automático, CIE-10, revisión de órganos y cierre en Sección K).
  * `fichas-medicas`: Ficha médica estudiantil HU-MED-001 (antecedentes de 8 tipos, examen físico).
  * `seguimiento-dm`: Seguimiento longitudinal y adaptaciones curriculares institucionales.
  * `validacion-certificados`: Recepción y dictamen de certificados de reposo médico.
  * `redireccion`: Procesamiento de callback OAuth en `/redirigir`.
* **Diseño Institucional:** Microsoft Fluent 2 con colores ISTPET Navy (`#1B2A4A`), Gold (`#C59B27`) y semáforo clínico (`#107C41` éxito/normal, `#D83B01` alerta, `#C42B1C` crítico/urgencia).
* **Testing:** Vitest con `@vitest/coverage-v8` y `jsdom`.

---

## 4. Convenciones de GitFlow y Aislamiento del Workspace

1. **Aislamiento de Archivos de IA:**
   * La carpeta `.agents/` y cualquier artefacto de IA reside exclusivamente en la raíz general `departamento_medico`.
   * Prohibido trasladar o commitear archivos de agente dentro de los repositorios individuales (`departamento_medico_istpet` o `departamento_medico_istpet-front`).
2. **Ciclo Institucional GitFlow ISTPET:**
   * **Issue:** Creado previamente en GitLab con plantilla obligatoria, asignado a uno mismo, con Milestone activo y 4 labels requeridas (`type::*`, `priority::*`, `workflow::ready-to-dev`, `workflow::in-review`).
   * **Rama:** Creada SIEMPRE desde `develop` limpio (NUNCA desde `main`) bajo patrón regex `<tipo>/<id-issue>-<slug>`.
   * **Commits:** Asunto en tiempo presente de entre 10 y 72 caracteres con formato `tipo(alcance): asunto`.
   * **Merge Request:** Apunta OBLIGATORIAMENTE a `develop` (solo `release/x.y` y `hotfix/*` van a `main`). 5 secciones obligatorias (`### Qué cambia`, `### Issue` con `Closes #ID`, `### Cómo probar`, `### Notas para el revisor`, `### Checklist`).
   * **Pipeline CI/CD:** 6 linters institucionales (`gitflow:rama`, `gitflow:commits`, `gitflow:issue`, `gitflow:metadatos`, `gitflow:plantilla`, `gitflow:secretos`), seguidos de stages `test` y `build`.

---

## 5. Puertos y Servicios Locales

* **Backend WebApi:** `http://localhost:5000` (Swagger en `http://localhost:5000/swagger`).
* **Frontend Angular:** `http://localhost:4200` (Callback OAuth en `http://localhost:4200/redirigir`).
* **Comandos de Ejecución:**
  * Backend: `dotnet run --project src/Istpet.DepartamentoMedico.WebApi`
  * Frontend: `npm run start`
