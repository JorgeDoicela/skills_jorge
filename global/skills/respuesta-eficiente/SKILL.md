---
name: respuesta-eficiente
description: Activa esta skill cuando el usuario pida respuestas directas, limite la búsqueda de archivos, pida evitar análisis del código, o use frases restrictivas como "Solo busca el archivo X", "Ve al grano", "No revises archivos", "No hagas análisis profundo" o "No ejecutes comandos". Evita búsquedas innecesarias de archivos para optimizar tokens.
---
# Skill de Respuestas Eficientes y Restricción de Búsquedas

Esta skill regula el comportamiento del agente para evitar el consumo innecesario de tokens y prevenir búsquedas exhaustivas de archivos en el proyecto cuando el usuario solicita respuestas directas, rápidas o limitadas en alcance.

## Activadores de la Skill
Activa esta skill inmediatamente cuando el usuario incluya instrucciones de restricción o frases similares en su solicitud:
- "Solo busca el archivo X y no investigues más" (o cualquier orden que limite la búsqueda a un archivo/ruta específico).
- "Ve al grano y no busques en el código/proyecto" (o solicitudes de respuestas basadas solo en conocimiento interno).
- "No hagas análisis profundo, solo responde con [lo que necesites]".
- "No revises archivos ni uses herramientas, solo explécame...".
- "Ve directo al grano sin hacer diagnósticos ni búsquedas".
- "No ejecutes comandos ni consultes la base de datos, indícame los pasos a seguir".
- "No hagas dotnet run" o cualquier orden que limite la ejecución del backend o inicio de servicios.
- Cualquier instrucción explícitamente de "no buscar", "ir al grano", "responder rápido" o "limitar alcance".

## Instrucciones de Comportamiento

1. **Búsquedas y Apertura de Archivos Eficientes:**
   - Si la ruta del archivo a editar o analizar es conocida o deducible, abre directamente el archivo usando `view_file` en lugar de realizar búsquedas globales redundantes (`grep_search` o `list_dir`).
   - Si el usuario especifica un archivo o ruta concreta (ej. "solo busca el archivo X"), la búsqueda DEBE limitarse única y exclusivamente a ese archivo.
   - **Análisis Seguro Acotado:** Al realizar modificaciones de código, puedes leer brevemente archivos de interfaces, firmas o tipos relacionados si es estrictamente necesario para evitar errores de compilación o linter. Evita abrir otros archivos de forma preventiva para "entender el contexto general".
2. **Evitar Uso de Herramientas Innecesarias:** Si el usuario solicita una respuesta directa, teórica o de pasos a seguir (ej. "no busques", "solo explícame"), no debes utilizar herramientas como `list_dir`, `grep_search`, `view_file` ni `run_command`. Responde de inmediato utilizando tu conocimiento interno.
3. **Planes de Acción Ágiles:** No inicies planes de implementación complejos ni generes artefactos de planeación (`implementation_plan.md` o `task.md`) para tareas simples, a menos que sea un cambio estructural masivo o el usuario lo solicite explícitamente. Para tareas sencillas, edita directamente; para refactorizaciones complejas, acuerda una ruta de acción breve con el desarrollador en el chat.
4. **Respuestas Concisas y Sin Código Redundante:** Ve directo al grano en tus respuestas y explica brevemente el razonamiento técnico. **Queda estrictamente prohibido duplicar o re-escribir bloques de código completos o modificados en tu respuesta de chat** si estos ya se muestran en los diffs de las herramientas de edición.
5. **No Ejecutar ni Proponer Servicios Redundantes:**
   - Si el usuario indica no ejecutar comandos ni consultar bases de datos, describe los pasos a seguir en texto plano.
   - Evita proponer o lanzar comandos interactivos repetitivos de inicio de servicios (como `dotnet run` o `npm run dev`) si ya se encuentran activos en segundo plano, previniendo duplicaciones de procesos o bloqueos.
6. **Delegación y Diagnóstico Compartido (Ahorro de Tokens):** Si necesitas validar logs, el estado de un servicio local, la base de datos o probar el navegador, prefiere **pedirle directamente al usuario que lo revise o ejecute la acción**. Proporciónale una guía paso a paso sumamente clara y concisa en texto plano con los comandos específicos a verificar.
7. **Formular Hipótesis Directas (Evitar Cascada):** En lugar de analizar archivos en cadena buscando una explicación a un error, formula una hipótesis simple y consúltala/valídala con el desarrollador en el chat antes de continuar abriendo archivos.
8. **Restricción de Subagentes del Navegador:** Queda prohibido lanzar subagentes de navegador (`browser_subagent`) a menos que el usuario lo solicite de forma explícita, ya que consumen una gran cantidad de tokens. Prefiere delegar las validaciones visuales o de navegación web al usuario.
