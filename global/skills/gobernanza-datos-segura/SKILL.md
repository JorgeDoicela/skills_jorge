---
name: gobernanza-datos-segura
description: Activa esta skill para evitar que el agente modifique contraseñas, credenciales, permisos o configuraciones de seguridad en bases de datos o archivos de forma silenciosa y sin que el usuario lo haya ordenado explícitamente. NO restringe el uso de credenciales cuando el propio usuario las proporciona y autoriza su uso para una tarea.
---
# Skill de Gobernanza de Datos y Seguridad

Esta skill protege contra modificaciones **silenciosas o no autorizadas** a datos sensibles. Su objetivo es evitar que el agente cambie credenciales, permisos o datos críticos sin que el usuario lo haya pedido — no bloquear tareas en las que el usuario mismo entrega sus credenciales y autoriza usarlas.

## Distinción Crítica

| Escenario | Comportamiento del agente |
|---|---|
| Usuario proporciona su contraseña y ordena usarla en un script/tarea | Úsala sin pedir confirmación adicional |
| Agente necesita credenciales y las solicita al usuario | Preguntar y esperar respuesta |
| Agente modifica contraseñas/hashes en BD sin haberlo pedido el usuario | Prohibido |
| Agente cambia permisos/roles de usuarios de forma silenciosa | Prohibido |
| Script de prueba automática altera cuentas reales sin aviso | Prohibido |

## Activadores de la Skill

Activa esta skill en alguno de estos contextos:
- Tareas de automatización o scripts que accedan a cuentas de usuario reales.
- Operaciones SQL masivas (`UPDATE`, `DELETE`, `DROP`) sobre tablas de usuarios, roles o configuraciones maestras.
- Modificaciones a archivos de configuración de seguridad (`.env`, `appsettings.json`, `sudoers`, etc.) que no hayan sido solicitadas explícitamente.

## Instrucciones de Comportamiento

1. **Credenciales Explícitas del Usuario → Usar Directamente:** Si el usuario proporciona su contraseña, token, o clave SSH en el mensaje y la autoriza para ejecutar un comando o script, **úsala sin restricción ni solicitud de confirmación adicional**. El consentimiento ya fue dado por el hecho de proporcionarla.

2. **Credenciales No Proporcionadas → Pedir, No Inventar:** Si una tarea requiere credenciales que el usuario no ha proporcionado, solicítalas de forma puntual y clara. No las inventes, no uses placeholders vacíos, no las hardcodees en archivos sin avisar.

3. **Modificaciones a BD de Usuarios o Roles → Mostrar y Aprobar:** Cualquier consulta SQL de tipo `UPDATE`, `INSERT`, `DELETE` o `DROP` sobre tablas de usuarios, roles, permisos o configuraciones maestras debe mostrarse en el chat con su impacto explicado **antes de ejecutarse**.

4. **Scripts de Automatización → No Alterar Cuentas Reales:** Durante pruebas automatizadas (browser agents, API mocks), no modificar contraseñas de cuentas reales para facilitar el acceso del bot. Usar cuentas de prueba dedicadas o solicitar al usuario que las provea.

5. **Rollback ante Error:** Si durante una tarea se modifica accidentalmente un dato crítico (contraseña, permiso, configuración), documentar el valor anterior y proporcionar inmediatamente el comando de rollback.
