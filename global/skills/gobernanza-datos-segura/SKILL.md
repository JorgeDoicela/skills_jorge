---
name: gobernanza-datos-segura
description: Activa esta skill para asegurar que el agente nunca modifique contraseñas, credenciales, registros de auditoría, correos o configuraciones de seguridad en bases de datos o archivos sin consentimiento explícito y aprobación del usuario. Evita atajos destructivos durante fases de testeo o automatización.
---
# Skill de Gobernanza de Datos y Seguridad (Safe Data Governance)

Esta skill regula el comportamiento del agente para garantizar la integridad del entorno de desarrollo y la base de datos del usuario, prohibiendo estrictamente modificaciones silenciosas a datos persistentes, credenciales de inicio de sesión o configuraciones críticas de seguridad.

## Activadores de la Skill
Activa esta skill cuando el usuario solicite explícitamente cuidado con los datos, seguridad de credenciales o gobernanza segura (por ejemplo, usando frases como "cuidado con la base de datos", "no cambies claves", "aplica gobernanza segura" o similares). También debe activarse cuando se realicen tareas de automatización complejas o pruebas de inicio de sesión que involucren cuentas de usuario.

## Instrucciones de Comportamiento

1. **Gestión de Credenciales Segura y Consentimiento:** Queda estrictamente prohibido alterar contraseñas, hashes de seguridad, roles, permisos o correos de usuarios en la base de datos o en archivos locales sin una instrucción directa, explícita e inequívoca del usuario en el turno actual. Se permite, sin embargo, la creación y provisión automática de perfiles de desarrollo o cuentas de prueba locales y mock (que no afecten los entornos de producción o base de datos de sistemas externos) para agilizar las fases de depuración y testeo.
2. **Uso de Datos Mock y Evitar Atajos Destructivos:** Durante tareas de pruebas (ej: scripts de automatización de navegador o llamadas simuladas de API), el agente no debe alterar contraseñas de cuentas reales para facilitar el acceso de bots. En su lugar, debe:
   - Solicitar al desarrollador un usuario de pruebas dedicado.
   - Utilizar cuentas mock o usuarios falsos locales de pruebas preexistentes en los seeds de desarrollo.
   - Solicitar al usuario que ingrese las credenciales de forma manual si es necesario.
3. **Control y Transparencia en Consultas SQL Modificadoras:** Cualquier consulta SQL de tipo `UPDATE`, `INSERT`, `DELETE` o `DROP` que afecte tablas de usuarios, configuraciones maestras, o realice modificaciones masivas, debe ser expuesta claramente en el chat explicando su impacto, y requerir aprobación antes de ejecutarse en el sistema.
4. **Preservación del Entorno del Desarrollador:** Trata la base de datos de desarrollo y el entorno local con respeto técnico (como si fuera un entorno de producción local). No realices operaciones que dejen inoperativo el login, bloqueen cuentas, o impidan que otros miembros del equipo accedan al sistema.
5. **Mecanismo de Rollback y Registro de Cambios:** Ante modificaciones accidentales en credenciales de desarrollo o configuraciones sensibles, registra inmediatamente el valor previo y provee comandos, scripts SQL o instrucciones de rollback inmediatos para deshacer el cambio al finalizar la tarea.
