---
name: desarrollo-backend
description: Activa esta skill para tareas de desarrollo backend, controladores de API en C#, arquitectura limpia, base de datos, consultas EF Core, DTOs o lógica del lado del servidor.
---
# Directrices Globales de Desarrollo Backend e Ingeniería de Software

Esta habilidad define los estándares profesionales para el desarrollo del lado del servidor y bases de datos en todos los proyectos de software.

## 1. Arquitectura Limpia y Estructura
* **Separación de Responsabilidades:** Los controladores ASP.NET Core deben ser intermediarios HTTP ultradelgados. Su función principal es recibir peticiones, validar parámetros y retornar códigos de estado HTTP correctos. Toda la lógica de negocio pesada, algoritmos y reglas del sistema se delegan a la capa de servicios o manejadores específicos.
* **Inyección de Dependencias Limpia:** Utiliza siempre abstracciones (interfaces) para inyectar servicios. Registra correctamente los alcances de vida (transient, scoped, singleton) en el contenedor de servicios de la API.
* **Robustez y DTOs:** Valida de forma defensiva los datos de entrada a nivel de DTOs antes de interactuar con el motor de persistencia, retornando respuestas HTTP semánticas.

## 2. Bases de Datos y Modelado (EF Core y SQL)
* **Consultas Eficientes:**
  - Incluye siempre de forma explícita las propiedades y colecciones navegacionales utilizando `.Include()` y `.ThenInclude()` al consultar datos relacionales para evitar colecciones nulas o consultas N+1.
  - Utiliza `.AsNoTracking()` para todas las consultas de solo lectura (read-only) para optimizar memoria.
* **Gobernanza y Convenciones de Base de Datos:**
  - **Tablas del Módulo de Negocio (Escritura):** Al crear nuevas tablas de base de datos o migraciones locales del dominio del proyecto, mantén la convención de nomenclaturas (como prefijos de módulo o snake_case) e integridad de llaves foráneas e índices de forma rigurosa y uniforme.
  - **Tablas Institucionales Externas (Solo Lectura):** Identifica y clasifica los esquemas de bases de datos compartidos o sistemas externos legados. Estos registros deben consultarse de forma estrictamente de **solo lectura**, previniendo operaciones de escritura accidentales.
* **Seguridad en Scripts SQL:** Cualquier script de alteración (`UPDATE`, `DELETE`, `DROP`) o semilla (`seed`) debe incluir cláusulas `WHERE` seguras y explícitas. Si se requiere deshabilitar restricciones de integridad temporalmente (ej: llaves foráneas), hazlo solo en el bloque necesario y restáuralas inmediatamente al finalizar.

## 3. Manejo de Errores y Registro (Logging)
* **Manejo Global de Excepciones:** Prefiere middlewares globales o filtros de excepción para capturar errores del servidor y devolver respuestas JSON estándar (ej: `{ "message": "Error description" }`), evitando bloques `try-catch` repetitivos en los controladores.
* **Registro Estructurado (Logging):** Utiliza logging estructurado con parámetros (ej: `_logger.LogError(ex, "Error al procesar la entidad {Id}", entityId);`) en lugar de interpolar cadenas, para facilitar búsquedas en sistemas de monitoreo.

## 4. Estándares de Código y Control de Versiones (Git)
* **Nombres Descriptivos:** Escribe nombres de métodos, variables y clases claros y autoexplicativos. Sigue las guías oficiales de C# (PascalCase para clases/métodos, camelCase para variables locales).
* **Convención de Commits (Git):** Utiliza commits semánticos (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`) para mantener un historial limpio y legible.

## 5. Arquitectura y Diseño de Sistema (Experto)
* **Principios SOLID:** Aplica SOLID como criterio de diseño en toda clase, servicio o módulo nuevo. Detecta proactivamente violaciones (clases con múltiples responsabilidades, dependencias directas en vez de abstracciones) y propón el refactor correcto antes de continuar añadiendo funcionalidad.
* **Patrones de Diseño:** Identifica y aplica el patrón apropiado según el contexto: Repository para abstraer acceso a datos, Factory para creación compleja de objetos, Strategy para comportamientos intercambiables, CQRS cuando leer y escribir tienen necesidades muy distintas. No apliques patrones por moda — solo cuando resuelven un problema real.
* **Diseño de APIs REST:** Las APIs deben ser intuitivas, consistentes y autoexplicativas. Usa sustantivos en plural para recursos (`/api/proyectos`), verbos HTTP semánticos (GET/POST/PUT/PATCH/DELETE) y códigos de estado precisos (201 Created, 204 No Content, 422 Unprocessable Entity). Una API bien diseñada no requiere documentación extensa para entenderse.
* **Cohesión y Acoplamiento:** Diseña módulos con alta cohesión interna y bajo acoplamiento entre sí. Si un cambio en un módulo obliga a modificar múltiples otros no relacionados, es una señal de diseño incorrecto que debe corregirse, no ignorarse.
* **Escalabilidad y Extensibilidad:** Considera desde el diseño inicial cómo crecerá el sistema. Prefiere estructuras que permitan añadir funcionalidad sin modificar lo existente (Open/Closed Principle). Si el diseño actual no lo permite, señálalo y propón la refactorización necesaria.
