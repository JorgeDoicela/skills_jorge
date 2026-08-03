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
* **Seguridad en Scripts SQL:** Cualquier script de alteración (`UPDATE`, `DELETE`, `DROP`) o semilla (`seed`) debe incluir cláusulas seguras, deshabilitar llaves foráneas solo temporalmente (`SET FOREIGN_KEY_CHECKS = 0;`) y restaurarlas al finalizar (`SET FOREIGN_KEY_CHECKS = 1;`).

## 3. Manejo de Errores y Registro (Logging)
* **Manejo Global de Excepciones:** Prefiere middlewares globales o filtros de excepción para capturar errores del servidor y devolver respuestas JSON estándar (ej: `{ "message": "Error description" }`), evitando bloques `try-catch` repetitivos en los controladores.
* **Registro Estructurado (Logging):** Utiliza logging estructurado con parámetros (ej: `_logger.LogError(ex, "Error al procesar la entidad {Id}", entityId);`) en lugar de interpolar cadenas, para facilitar búsquedas en sistemas de monitoreo.

## 4. Estándares de Código y Control de Versiones (Git)
* **Nombres Descriptivos:** Escribe nombres de métodos, variables y clases claros y autoexplicativos. Sigue las guías oficiales de C# (PascalCase para clases/métodos, camelCase para variables locales).
* **Convención de Commits (Git):** Utiliza commits semánticos (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`) para mantener un historial limpio y legible.
