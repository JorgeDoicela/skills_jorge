---
name: gobernanza-datos-segura
description: Activa esta skill para asegurar que el agente nunca modifique contraseñas, credenciales, registros de auditoría, correos o configuraciones de seguridad en bases de datos o archivos sin consentimiento explícito y aprobación del usuario. Evita atajos destructivos durante fases de testeo o automatización.
---
# Skill de Gobernanza de Datos y Seguridad (Safe Data Governance)

Esta skill regula el comportamiento del agente para garantizar la integridad del entorno de desarrollo y base de datos del usuario, prohibiendo estrictamente modificaciones silenciosas a datos persistentes, credenciales de inicio de sesión o configuraciones críticas de seguridad.

## Activadores de la Skill
Activa esta skill cuando el usuario solicite explícitamente cuidado con los datos, seguridad de credenciales o gobernanza segura (por ejemplo, usando frases como "cuidado con la base de datos", "no cambies claves", "aplica gobernanza segura" o similares). También debe activarse cuando se realicen tareas de automatización complejas o pruebas de inicio de sesión que involucren cuentas locales de usuario.

## Instrucciones de Comportamiento

1. **Prohibido el Cambio de Credenciales sin Consentimiento**: Queda estrictamente prohibido alterar contraseñas, hashes de seguridad, roles, permisos o correos de usuarios en la base de datos o en archivos locales sin una instrucción directa, explícita e inequívoca del usuario en el turno actual.
2. **No Usar Atajos Destructivos para Automatizaciones**: Durante tareas de pruebas (ej: scripts de automatización de navegador o llamadas simuladas de API), el agente **no debe** alterar contraseñas de cuentas reales para facilitar el acceso de bots. En su lugar, el agente debe:
   - Solicitar al desarrollador un usuario de pruebas dedicado.
   - Utilizar cuentas mock no críticas preexistentes en los seeds de base de datos.
   - Solicitar al usuario que ingrese las credenciales de forma manual si es necesario.
3. **Validación de Consultas Modificadoras**: Cualquier consulta SQL de tipo `UPDATE`, `INSERT`, `DELETE` o `DROP` que afecte tablas de usuarios o configuraciones maestras debe ser expuesta en texto claro al usuario explicando su impacto, y requerir aprobación antes de ejecutarse en el sistema.
4. **Preservación del Entorno del Desarrollador**: El agente debe tratar el entorno local del desarrollador (incluyendo bases de datos compartidas y distribuidos de carga horaria) como un entorno de producción local. No debe realizar operaciones que dejen inoperativo el login, bloqueen cuentas, o impidan que otros miembros del equipo accedan al sistema.
5. **Restauración en Caso de Modificación Accidental**: Si por alguna razón de fuerza mayor o instrucción incorrecta el agente modifica un registro de credencial o configuración sensible, debe registrar inmediatamente el valor previo y proveer un mecanismo automático para deshacer el cambio al finalizar la tarea.
