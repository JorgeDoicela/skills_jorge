---
name: desarrollo-backend
description: Activa esta skill para tareas de desarrollo backend, controladores de API en C#, arquitectura limpia, base de datos, consultas EF Core, DTOs o lógica del lado del servidor.
---
# Directrices Globales de Desarrollo Backend e Ingeniería de Software

Esta habilidad define los estándares profesionales para el desarrollo del lado del servidor y bases de datos en todos los proyectos de software.

## 1. Arquitectura Limpia y Estructura
* **Separación de Responsabilidades:** Mantén los controladores del API delgados. Su función principal es recibir peticiones, validar parámetros básicos, y retornar códigos de estado HTTP correctos.
* **Capa de Servicios/Aplicación:** Coloca toda la lógica de negocio pesada, algoritmos y reglas del sistema en servicios dedicados o gestores de comandos de aplicación.

## 2. Bases de Datos y Modelado (EF Core y SQL)
* **Consultas Eficientes:**
  - Incluye siempre de forma explícita las propiedades navegacionales utilizando `.Include()` y `.ThenInclude()` al consultar datos relacionales para evitar colecciones nulas o consultas N+1.
  - Utiliza `.AsNoTracking()` para todas las consultas de solo lectura (read-only) para optimizar memoria.
* **Integridad y Convenciones de Base de Datos:**
  - Nombres de tablas y columnas consistentes (ej. PascalCase en C#, snake_case o CamelCase según el motor de base de datos).
  - Diseña siempre con llaves foráneas e índices en columnas de búsqueda frecuente para mejorar el rendimiento de consultas.
* **Seguridad en Scripts SQL:** Cualquier script de alteración (`UPDATE`, `DELETE`, `DROP`) o semilla (`seed`) debe incluir cláusulas seguras, deshabilitar llaves foráneas solo temporalmente (`SET FOREIGN_KEY_CHECKS = 0;`) y restaurarlas al finalizar (`SET FOREIGN_KEY_CHECKS = 1;`).

## 3. Manejo de Errores y Registro (Logging)
* **Manejo Global de Excepciones:** Prefiere middlewares globales o filtros de excepción para capturar errores del servidor y devolver respuestas JSON estándar (ej: `{ "message": "Error description" }`), evitando bloques `try-catch` repetitivos en los controladores.
* **Registro Estructurado (Logging):** Utiliza logging estructurado con parámetros (ej: `_logger.LogError(ex, "Error al procesar la entidad {Id}", entityId);`) en lugar de interpolar cadenas (`$"{Id}"`), para facilitar búsquedas en sistemas de monitoreo.

## 4. Estándares de Código y Control de Versiones (Git)
* **Nombres Descriptivos:** Escribe nombres de métodos, variables y clases claros y autoexplicativos. Sigue las guías oficiales de C# (PascalCase para clases/métodos, camelCase para variables locales).
* **Convención de Commits (Git):** Utiliza commits semánticos (`feat:`, `fix:`, `refactor:`, `chore:`, `docs:`) para mantener un historial limpio y legible.
