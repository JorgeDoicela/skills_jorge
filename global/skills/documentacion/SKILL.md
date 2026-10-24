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
6. **Separación Estricta entre `README.md` (Raíz) e Índice Técnico (`docs/00-indice-general.md`):**
   - El archivo `README.md` de la raíz del repositorio y el índice de documentación técnica (`docs/00-indice-general.md`) son dos entidades independientes con propósitos y audiencias desacopladas:
     - **`README.md` (Raíz):** Es la carta de presentación técnica, onboarding para desarrolladores y guía rápida operativa (Quickstart) del proyecto. Contiene la visión general, requisitos, instalación básica, comandos principales y un puntero de enlace a la documentación técnica.
     - **`docs/00-indice-general.md`:** Es el catálogo maestro exhaustivo de la biblioteca documental Docs-as-Code. Centraliza el mapa completo de módulos (`01-...`, `02-...`, etc.) y describe la función de cada documento técnico interno.
   - **Prohibición de READMEs internos:** Queda terminantemente prohibido crear o mantener archivos nombrados `README.md` dentro del directorio `docs/` o de sus subcarpetas. El índice dentro de `docs/` debe nombrarse obligatoriamente `00-indice-general.md` (o `00-index.md` en proyectos en inglés).
7. **Portabilidad Absoluta y Rutas Relativas Dinámicas:**
   - Queda estrictamente prohibido utilizar rutas absolutas locales del sistema de archivos (ej. `/home/...`, `C:\...`, `/tmp/...`) o enlaces de protocolo absoluto local como `file:///...` en la documentación técnica, diagramas o hipervínculos markdown.
   - Toda referencia interdocumental, enlace a código fuente, script o imagen debe formularse obligatoriamente mediante **rutas relativas dinámicas** (`./`, `../`, `../../`), calculadas dinámicamente según la posición del archivo emisor y el archivo receptor.
   - Esta regla asegura que la documentación sea 100% portable y funcional entre distintos sistemas operativos (Linux, Windows, macOS), navegable en plataformas Git remotas (GitHub, GitLab) y compatible con visores Markdown locales y generadores de sitios estáticos.
8. **Libertad Total de Expansión y Cero Límites Artificiales de Tamaño:**
   - El agente tiene plena autonomía y libertad para crear **nuevas carpetas temáticas** (`07-...`, `08-...`, etc.), subdirectorios anidados y **tantos archivos específicos como sean necesarios** para cubrir la totalidad del sistema.
   - **No existen límites de tamaño para los archivos:** Queda prohibido recortar, resumir de forma vaga u omitir detalles técnicos por temor a que un archivo sea muy largo o extenso. Si un componente, API o base de datos requiere 1,000 o más líneas para explicar exhaustivamente tablas de campos, flujos de datos, validaciones y diagramas Mermaid, debe documentarse a fondo con el máximo nivel de detalle profesional.
9. **Frontera Estricta de la Documentación (Prohibido Tocar Skills):**
   - El alcance de esta habilidad se limita única y exclusivamente al código fuente del sistema y al directorio de documentación técnica del proyecto (`docs/`, dosieres técnicos, guías y el `README.md` raíz).
   - Queda terminantemente prohibido crear, modificar, actualizar o refactorizar archivos de skills o directrices del agente (`.agents/skills/`, `.gemini/skills/`, etc.). Las skills son directrices maestras estables de solo consulta y no forman parte de la documentación viva del proyecto.

---

## 2. Metodología: Taxonomía Jerárquica Numérica Adaptable

La documentación debe organizarse en una carpeta dedicada del repositorio (por defecto `docs/`, `docs/documentacion/` o la convención establecida en el proyecto) utilizando **indexación prefijada de dos dígitos (`01-`, `02-`, `03-...`)**, encabezada siempre por su catálogo maestro `00-indice-general.md`.

```
docs/
├── 00-indice-general.md             <-- Catálogo maestro de toda la biblioteca documental
├── 01-arquitectura/
│   ├── 01-vision-general.md
│   └── 02-diagramas-c4.md
├── 02-backend-servicios/
│   ├── 01-especificacion-api.md
│   └── 02-casos-de-uso.md
└── ...
```

### Por qué esta estructura:
* **Orden Secuencial Lógico:** Garantiza que exploradores de archivos (VS Code, terminal, GitHub, Obsidian) ordenen los temas por secuencia lógica de lectura y no por orden alfabético arbitrario.
* **Compatibilidad Nativa:** Es el estándar directo que interpretan los generadores de sitios estáticos técnicos (Docusaurus, VitePress, MkDocs, GitBook).
* **Desacoplamiento y Modularidad:** Cada archivo es una unidad autocontenida que aborda un único dominio o componente, evitando archivos monolíticos inmanejables.

### Adaptabilidad Universal al Tipo de Proyecto:
La estructura de carpetas NO es estática ni fija; debe diseñarse y adaptarse según la naturaleza real del proyecto:

* **Para Proyectos Fullstack / Monorepos:**
  - `docs/00-indice-general.md`
  - `01-arquitectura/` (Visión macro, diagramas C4, patrones, fronteras de dominio)
  - `02-backend-servicios/` (APIs, controladores, casos de uso, autenticación)
  - `03-base-de-datos/` (Esquema relacional/NoSQL, diccionario de datos, migraciones)
  - `04-frontend-web/` (Rutas, componentes de UI, gestión de estado, contratos de cliente)
  - `05-despliegue-y-operaciones/` (Variables de entorno, CI/CD, infraestructura, observabilidad)

* **Para Proyectos de Solo Backend / APIs / Microservicios:**
  - `docs/00-indice-general.md`
  - `01-arquitectura-y-diseno/` (Clean/Hexagonal, modelo de dominio, eventos)
  - `02-especificacion-api/` (Contratos OpenAPI/REST, gRPC, códigos HTTP, roles)
  - `03-persistencia-y-datos/` (Modelado, transaccionalidad, migraciones, índices)
  - `04-seguridad-y-auth/` (Políticas de tokens, RBAC, encriptación)
  - `05-infraestructura-y-despliegue/` (Docker, variables, logging, métricas)

* **Para Proyectos de Solo Frontend / Aplicaciones Móviles:**
  - `docs/00-indice-general.md`
  - `01-arquitectura-spa/` (Enrutamiento, módulos, ciclo de vida)
  - `02-sistema-de-diseno/` (Design tokens, tipografía, paletas, accesibilidad)
  - `03-catalogo-componentes/` (Componentes reutilizables, layouts, shells)
  - `04-servicios-y-estado/` (Fachadas HTTP, normalización, websockets/caché)
  - `05-compilacion-y-entorno/` (Bundler, testing, variables de entorno)

* **Para Proyectos de Infraestructura / DevOps / IaC:**
  - `docs/00-indice-general.md`
  - `01-topologia-de-red/` (VPCs, subnets, zonas de disponibilidad, firewalls)
  - `02-modulos-iac/` (Terraform/Ansible, parámetros de entrada, salidas)
  - `03-clusters-y-servicios/` (Kubernetes, contenedores, orquestación)
  - `04-seguridad-y-politicas/` (Hardening, gestión de secretos, accesos SSH)
  - `05-monitoreo-y-runbooks/` (Alertas, procedimientos de recuperación ante desastres)

* **Para Herramientas CLI / Automatización / Librerías:**
  - `docs/00-indice-general.md`
  - `01-arquitectura-y-diseno/` (Estructura de módulos, motor central, CLI parsing)
  - `02-referencia-comandos/` (Subcomandos, argumentos, banderas, códigos de salida)
  - `03-configuracion-y-entorno/` (Variables de entorno, archivos de configuración, plugins)
  - `04-flujos-y-ciclo-de-vida/` (Procesamiento paso a paso, validaciones, pipelines)
  - `05-pruebas-y-calidad/` (Suites de pruebas, fixtures, cobertura)

---

## 3. Comandos de Una Sola Palabra (Disparo Rápido)

Cuando el usuario invoque la skill o use una palabra clave corta en su mensaje, ejecuta la acción con máxima precisión técnica:

| Comando | Acción del Agente |
|---|---|
| `documentar` | Audita el código del proyecto, identifica componentes, APIs o arquitecturas sin documentar y genera los documentos `.md` modulares respetando la estructura numérica y actualizando el índice `00-indice-general.md`. |
| `sincronizar-docs` / `actualizar-docs` | Revisa los últimos cambios realizados en el código fuente (controladores, tablas, componentes, interfaces) y actualiza quirúrgicamente los `.md` afectados y el índice en el mismo turno. |
| `estructura-docs` | Diseña o refactoriza el mapa de carpetas y archivos numéricos (`01-...`, `02-...`) adaptado estrictamente al stack y alcance del proyecto actual, presentando la propuesta al usuario. |
| `auditar-docs` | Compara la documentación existente contra el código fuente real para detectar desfases técnicos, endpoints obsoletos, variables descontinuadas, rutas estáticas inválidas o lenguaje inflado que deba depurarse. |

---

## 4. Criterios de Aplicación: ¿Cuándo SÍ vs. Cuándo NO Documentar?

### Cuándo SÍ es Obligatorio Actualizar:
* **Base de Datos:** Nuevas tablas, columnas, relaciones, modificaciones de restricciones o scripts de migración.
* **Backend y APIs:** Nuevos endpoints, rutas, cambios en DTOs de entrada/salida, códigos de error HTTP, cambios en flujos de autenticación o reglas de negocio críticas.
* **Frontend:** Creación o cambio de rutas en el router, adición de componentes de página/sección principales, cambios en fachadas de servicio o sistemas de diseño.
* **Infraestructura y CLI:** Nuevas variables de entorno requeridas, scripts de despliegue, nuevos comandos/banderas, cambios en puertos o dependencias de sistema.

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

---

## 6. Estándar Canónico y Parámetros Obligatorios del `README.md` de la Raíz

El archivo `README.md` ubicado en la raíz del repositorio constituye la puerta de entrada técnica y operativa para cualquier desarrollador que clona o audita el proyecto. Debe ser conciso, autocontenido y libre de lenguaje inflado, estructurado obligatoriamente bajo los siguientes parámetros y secciones:

1. **Identificación y Propósito Fáctico (`# <Nombre del Proyecto>`):**
   - Título formal del sistema o herramienta.
   - Párrafo descriptivo fáctico (1 a 2 párrafos concisos) que especifique el objetivo del proyecto, problema técnico que resuelve y su rol dentro de la arquitectura general. Sin eslóganes comerciales ni emojis.
2. **Requisitos Previos y Compatibilidad de Entorno:**
   - Versiones mínimas requeridas de lenguajes o runtimes (ej. Python >= 3.10, Node.js >= 20, .NET 8).
   - Dependencias de sistema operativo o herramientas auxiliares (Docker, Make, Git, LibreOffice, etc.).
3. **Inicio Rápido (Quickstart / Configuración en 3 Pasos):**
   - Comandos exactos y reproducibles para:
     - Clonar el repositorio.
     - Configurar variables de entorno mediante plantilla (`cp .env.example .env`), prohibiendo escribir credenciales reales en el documento.
     - Instalar dependencias del proyecto (ej. entorno virtual, gestor de paquetes).
4. **Comandos Principales y Ciclo de Vida del Software:**
   - Tabla o lista de comandos exactos para ejecutar:
     - Servidor de desarrollo / Ejecución de CLI.
     - Suite de pruebas automatizadas (`test`).
     - Construcción o empaquetado de producción (`build`).
     - Análisis estático o linter (`lint`).
5. **Estructura Macro del Directorio:**
   - Bloque de árbol esquemático (`tree`) que represente los directorios principales de primer nivel (`src/`, `docs/`, `tests/`, etc.) con una breve glosa de responsabilidad técnica por cada carpeta.
6. **Puntero a Documentación Técnica Detallada (Docs-as-Code):**
   - Enlace relativo dinámico explícito hacia el catálogo documental técnico: `[Documentación Técnica Completa](docs/00-indice-general.md)`.
   - Breve enumeración de los módulos cubiertos en `docs/` para guiar al lector hacia arquitectura, APIs, datos o guías avanzadas.
7. **Seguridad de Secretos y Licencia:**
   - Declaración expresa sobre el manejo seguro de credenciales (recordatorio de no versionar `.env`) y términos de licencia o propiedad intelectual aplicables.

---

## 7. Reglas para Resolución Dinámica de Rutas Relativas

Para asegurar la portabilidad multiplataforma y evitar enlaces rotos, toda referencia entre documentos, código y recursos debe obedecer las siguientes reglas de enlace relativo dinámico:

1. **Desde `README.md` (Raíz) hacia la Documentación:**
   - Al índice general: `[Documentación](docs/00-indice-general.md)`
   - A un módulo específico: `[Arquitectura](docs/01-arquitectura/01-vision-general.md)`
2. **Desde `docs/00-indice-general.md` hacia Submódulos:**
   - A un archivo dentro de un submódulo: `[Visión General](01-arquitectura/01-vision-general.md)` o `./01-arquitectura/01-vision-general.md`
   - Al README de la raíz: `[Volver al README](../README.md)`
3. **Entre Módulos Hermanos dentro de `docs/`:**
   - Desde un archivo dentro de `docs/01-arquitectura/` hacia un archivo en `docs/02-backend/`: `[Ver API](../02-backend/01-especificacion.md)`
4. **Desde Documentos hacia el Código Fuente:**
   - Desde un archivo en `docs/01-arquitectura/` hacia un script en `src/`: `[Módulo Core](../../src/core.py)`
5. **Prohibición de Rutas Absolutas:**
   - Queda estrictamente vetado el uso de prefijos absolutos del sistema de archivos como `/home/...`, `/var/...`, `C:\...`, o esquemas `file:///...`. Todo enlace debe ser navegable tanto en local como en plataformas remotas (GitHub/GitLab) y visores Markdown.
