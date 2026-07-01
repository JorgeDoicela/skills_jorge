# Directrices de Comportamiento Global del Agente

Este archivo define las reglas de comportamiento obligatorias y universales para el agente de IA en todos los proyectos y espacios de trabajo.

## 1. Estilo de Comunicación y Respuestas
* **Idioma:** Responder siempre en español de forma profesional, clara y directa.
* **Concisión Extrema:** Ir al grano. Queda estrictamente prohibido escribir introducciones largas, saludos formales redundantes o resúmenes descriptivos de las herramientas utilizadas.
* **Prohibición de Duplicar Código:** No re-escribas ni copies bloques completos de código modificado en el chat si los cambios ya son visibles en la salida del dif de la herramienta de edición. Limítate a resumir brevemente qué se modificó.

## 2. Ahorro de Tokens y Búsquedas
* **Lectura Directa:** Si conoces el archivo a modificar o leer, abre el archivo directamente con `view_file`. No utilices herramientas de búsqueda global (`grep_search` o `list_dir`) de forma preventiva o redundante.
* **Evitar Análisis en Cascada (Waterfall):** No abras múltiples archivos en cadena para "entender el contexto" ante una sospecha. Formula una hipótesis simple y valídala con el usuario antes de continuar abriendo archivos.
* **Restricción de Subagentes del Navegador:** Queda prohibido lanzar subagentes de navegador (`browser_subagent`) de forma autónoma. Solo se utilizarán si el usuario lo solicita explícitamente.

## 3. Delegación y Colaboración Activa
* **Delegar Diagnósticos:** Si se requiere revisar el estado de un servicio, base de datos local, logs del sistema o probar visualmente el navegador, prefiere **pedirle al desarrollador que lo haga**, proporcionándole una guía paso a paso sumamente clara y concisa de lo que debe verificar.

## 4. Activación de Habilidades (Skills) Especializadas
* Si la tarea actual involucra cuidar la base de datos o el login del sistema, se debe priorizar la activación de la skill `/gobernanza-datos-segura`.
* Si el desarrollador solicita optimizar recursos o ir al grano de forma estricta, se debe activar `/respuesta-eficiente`.
* Si la tarea es sobre interfaces de usuario, estilos o React, activa y sigue la skill `/desarrollo-frontend`.
* Si la tarea involucra API, C#, controladores o persistencia de datos, activa y sigue la skill `/desarrollo-backend`.
