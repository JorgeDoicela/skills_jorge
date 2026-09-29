---
name: documentacion
description: Activa esta skill para crear, estructurar, sincronizar y mantener documentación técnica profesional Docs-as-Code bajo taxonomía jerárquica numérica (01-, 02-...) adaptable a cualquier tipo de proyecto (backend, frontend, fullstack, CLI, infra/DevOps, librerías), con tono técnico sobrio, riguroso, fáctico, sin lenguaje marketero y sin emojis.
---
# Directrices Universales de Documentación Técnica Modular — Docs-as-Code

Esta habilidad define los estándares profesionales para concebir, estructurar, sincronizar y mantener la documentación técnica de cualquier proyecto de software, infraestructura o sistema. Rige bajo los paradigmas de **Docs-as-Code**, **Taxonomía Jerárquica Numérica** y **Dosier Técnico Modular**.

---

## 1. Principios Fundamentales y Reglas Inviolables

1. **Inmutabilidad del Principio Cero Emojis:**
   - Queda terminantemente prohibido el uso de emojis en cualquier archivo de documentación técnica, tablas, alertas, diagramas o índices.
   - La redacción debe ser sobria, académica, formal y de nivel senior de ingeniería de software.
2. **Cero Lenguaje Marketero o Inflado:**
   - Prohibido utilizar adjetivos grandilocuentes, comerciales o vacíos (*"la solución definitiva"*, *"arquitectura enterprise de clase mundial"*, *"el sistema más avanzado"*, *"diseño revolucionario y ultra-robusto"*).
   - Toda descripción debe ser **estrictamente fáctica, técnica, verificable y descriptiva**. Se describe qué hace el sistema, cómo interactúan sus partes, qué restricciones tiene y por qué se tomaron las decisiones técnicas, sin vender humo.
3. **Actualización Oportuna y en el Mismo Turno (Sincronización Viva):**
   - La documentación técnica no debe rezagarse respecto al código fuente. Cuando se implementen cambios sustanciales (nuevos endpoints, métodos de servicio, esquemas de base de datos, rutas de interfaz, componentes clave o flujos de negocio), el agente debe actualizar de manera inmediata y precisa los documentos correspondientes antes de dar por concluida la tarea.
4. **Veracidad Absoluta y Cero Especulaciones Futuras:**
   - La documentación debe reflejar con exactitud matemática y técnica la realidad operativa del código existente. Prohibido documentar funcionalidades hipotéticas, supuestos o código planificado como si estuviera implementado.
5. **Precisión Quirúrgica (Mínima Modificación):**
   - Ante tareas menores o adiciones puntuales, prohibido reescribir archivos enteros innecesariamente. Actualiza única y exclusivamente los párrafos, tablas, esquemas o diagramas estrictamente impactados por el cambio para preservar el historial y optimizar tokens.
6. **Mantenimiento del Índice Central:**
   - Siempre que se agregue, renombre o elimine un archivo `.md`, se debe actualizar el índice principal de la carpeta de documentación (`README.md` dentro del directorio documental) y reflejar cualquier impacto mayor en el `README.md` raíz del proyecto.
7. **Libertad Total de Expansión y Cero Límites Artificiales de Tamaño:**
   - El agente tiene plena autonomía y libertad para crear **nuevas carpetas temáticas** (`07-...`, `08-...`, etc.), subdirectorios anidados y **tantos archivos específicos como sean necesarios** para cubrir la totalidad del sistema.
   - **No existen límites de tamaño para los archivos:** Queda prohibido recortar, resumir de forma vaga u omitir detalles técnicos por temor a que un archivo sea muy largo o extenso. Si un componente, API o base de datos requiere 1,000 o más líneas para explicar exhaustivamente tablas de campos, flujos de datos, validaciones y diagramas Mermaid, debe documentarse a fondo con el máximo nivel de detalle profesional.

---

## 2. Metodología: Taxonomía Jerárquica Numérica Adaptable

La documentación debe organizarse en una carpeta dedicada del repositorio (por defecto `docs/`, `docs/documentacion/` o la convención establecida en el proyecto) utilizando **indexación prefijada de dos dígitos (`01-`, `02-`, `03-...`)**.

### Por qué esta estructura:
* **Orden Secuencial Lógico:** Garantiza que exploradores de archivos (VS Code, terminal, GitHub, Obsidian) ordenen los temas por secuencia lógica de lectura y no por orden alfabético arbitrario.
* **Compatibilidad Nativa:** Es el estándar directo que interpretan los generadores de sitios estáticos técnicos (Docusaurus, VitePress, MkDocs, GitBook).
* **Desacoplamiento y Modularidad:** Cada archivo es una unidad autocontenida que aborda un único dominio o componente, evitando archivos monolíticos inmanejables.

### Adaptabilidad Universal al Tipo de Proyecto:
La estructura de carpetas NO es estática ni fija; debe diseñarse y adaptarse según la naturaleza real del proyecto:

* **Para Proyectos Fullstack / Monorepos:**
  - `01-arquitectura/` (Visión macro, diagramas C4, patrones, fronteras de dominio)
  - `02-backend-servicios/` (APIs, controladores, casos de uso, autenticación)
  - `03-base-de-datos/` (Esquema relacional/NoSQL, diccionario de datos, migraciones)
  - `04-frontend-web/` (Rutas, componentes de UI, gestión de estado, contratos de cliente)
  - `05-despliegue-y-operaciones/` (Variables de entorno, CI/CD, infraestructura, observabilidad)

* **Para Proyectos de Solo Backend / APIs / Microservicios:**
  - `01-arquitectura-y-diseno/` (Clean/Hexagonal, modelo de dominio, eventos)
  - `02-especificacion-api/` (Contratos OpenAPI/REST, gRPC, códigos HTTP, roles)
  - `03-persistencia-y-datos/` (Modelado, transaccionalidad, migraciones, índices)
  - `04-seguridad-y-auth/` (Políticas de tokens, RBAC, encriptación)
  - `05-infraestructura-y-despliegue/` (Docker, variables, logging, métricas)

* **Para Proyectos de Solo Frontend / Aplicaciones Móviles:**
  - `01-arquitectura-spa/` (Enrutamiento, módulos, ciclo de vida)
  - `02-sistema-de-diseno/` (Design tokens, tipografía, paletas, accesibilidad)
  - `03-catalogo-componentes/` (Componentes reutilizables, layouts, shells)
  - `04-servicios-y-estado/` (Fachadas HTTP, normalización, websockets/caché)
  - `05-compilacion-y-entorno/` (Bundler, testing, variables de entorno)

* **Para Proyectos de Infraestructura / DevOps / IaC:**
  - `01-topologia-de-red/` (VPCs, subnets, zonas de disponibilidad, firewalls)
  - `02-modulos-iac/` (Terraform/Ansible, parámetros de entrada, salidas)
  - `03-clusters-y-servicios/` (Kubernetes, contenedores, orquestación)
  - `04-seguridad-y-politicas/` (Hardening, gestión de secretos, accesos SSH)
  - `05-monitoreo-y-runbooks/` (Alertas, procedimientos de recuperación ante desastres)

---

## 3. Comandos de Una Sola Palabra (Disparo Rápido)

Cuando el usuario invoque la skill o use una palabra clave corta en su mensaje, ejecuta la acción con máxima precisión técnica:

| Comando | Acción del Agente |
|---|---|
| `documentar` | Audita el código del proyecto, identifica componentes, APIs o arquitecturas sin documentar y genera los documentos `.md` modulares respetando la estructura numérica. |
| `sincronizar-docs` / `actualizar-docs` | Revisa los últimos cambios realizados en el código fuente (controladores, tablas, componentes, interfaces) y actualiza quirúrgicamente los `.md` afectados en el mismo turno. |
| `estructura-docs` | Diseña o refactoriza el mapa de carpetas y archivos numéricos (`01-...`, `02-...`) adaptado estrictamente al stack y alcance del proyecto actual, presentando la propuesta al usuario. |
| `auditar-docs` | Compara la documentación existente contra el código fuente real para detectar desfases técnicos, endpoints obsoletos, variables descontinuadas o lenguaje inflado que deba depurarse. |

---

## 4. Criterios de Aplicación: ¿Cuándo SÍ vs. Cuándo NO Documentar?

### Cuándo SÍ es Obligatorio Actualizar:
* **Base de Datos:** Nuevas tablas, columnas, relaciones, modificaciones de restricciones o scripts de migración.
* **Backend y APIs:** Nuevos endpoints, rutas, cambios en DTOs de entrada/salida, códigos de error HTTP, cambios en flujos de autenticación o reglas de negocio críticas.
* **Frontend:** Creación o cambio de rutas en el router, adición de componentes de página/sección principales, cambios en fachadas de servicio o sistemas de diseño.
* **Infraestructura:** Nuevas variables de entorno requeridas, scripts de despliegue, cambios en puertos o dependencias de sistema.

### Cuándo NO se Debe Modificar la Documentación (Evitar Ruido):
* Refactorizaciones internas privadas que no alteren contratos externos ni la arquitectura del módulo.
* Corrección de bugs menores de lógica interna que no modifiquen el comportamiento funcional esperado.
* Formateo de código, corrección de espaciados o ajustes menores de linter.
* Actualizaciones rutinarias de dependencias menores que no introduzcan breaking changes.

---

## 5. Estándares de Redacción y Elementos Visuales Técnicos

1. **Tablas Exhaustivas de Especificación:**
   - **APIs:** Método HTTP, ruta, permisos/roles, parámetros de consulta, payload JSON de entrada, respuestas exitosas y errores posibles con códigos de estado.
   - **Base de Datos:** Nombre de tabla, columna, tipo de dato, nulos permitidos, llaves primarias/foráneas, índices y políticas de borrado.
   - **Configuración:** Variable de entorno, tipo, valor por defecto, descripción técnica y si es obligatoria.
2. **Diagramas Técnicos:**
   - Usar diagramas Mermaid (`flowchart`, `sequenceDiagram`, `erDiagram`, `classDiagram`) para clarificar flujos complejos, handshakes, interacciones cliente-servidor y modelos entidad-relación.
3. **Callouts Técnicos Estándar (Sin Emojis):**
   - `> [!NOTE]` Para contexto, aclaraciones de diseño o detalles de compatibilidad.
   - `> [!IMPORTANT]` Para reglas arquitectónicas críticas, invariantes de negocio o dependencias estrictas.
   - `> [!WARNING]` Para restricciones operacionales, limitaciones conocidas o comportamientos sutiles.
   - `> [!CAUTION]` Para operaciones destructivas, riesgos de consistencia de datos o políticas de seguridad.
