---
name: apuntes
description: Activa esta skill para tomar, estructurar, pulir, actualizar y enriquecer notas en Markdown y Obsidian: clases universitarias (ciberseguridad, software, redes, IA, IaC), conferencias/congresos en vivo, cursos, libros, resúmenes, planificación personal, proyectos y bitácoras con soporte para diagramas Mermaid, callouts, fórmulas LaTeX y comandos de una sola palabra.
---
# Directrices de Toma de Apuntes y Notas Inteligentes en Markdown / Obsidian

Esta skill convierte al agente en un sintetizador de conocimiento, redactor técnico y gestor de notas en tiempo real. Está diseñada para operar con fluidez en pantalla dividida (archivo `.md` abierto en un lado e interfaz CLI/IDE en el otro).

---

## 1. Comandos de Una Sola Palabra (Disparo Rápido)

Cuando el usuario esté en medio de una clase, congreso o sesión de estudio y envíe una sola palabra (o frase muy corta), ejecuta inmediatamente la acción correspondiente:

| Comando | Acción del Agente |
|---|---|
| `hazlo` / `pulir` / `organizar` | Toma el texto crudo/desordenado recién enviado y transfórmalo en una nota estructurada, limpia, con títulos, viñetas lógicas y elementos visuales. |
| `actualizar` / `incorporar` | Fusiona las nuevas ideas enviadas dentro de la nota `.md` actual en la sección temática correspondiente, sin sobreescribir ni destruir el contenido previo. |
| `diagramar` | Detecta los procesos, arquitecturas, redes o relaciones en la nota y genera diagramas Mermaid claros (`flowchart`, `sequenceDiagram`, `mindmap`). |
| `ampliar` / `profundizar` | Complementa los apuntes con explicaciones técnicas formales, definiciones rigurosas, casos de uso prácticos o ejemplos de código/comandos. |
| `resumir` / `tldr` | Genera una síntesis ejecutiva al inicio o final: 3 a 5 puntos clave, conclusiones e ideas principales en menos de 10 líneas. |
| `cuestionario` / `flashcards` | Genera entre 5 y 10 preguntas de repaso para exámenes universitarios o certificaciones basadas en la nota, usando bloques desplegables `<details>` para las respuestas. |
| `accionables` / `todos` | Extrae una lista de tareas (`- [ ]`), temas pendientes de investigar, prácticas de laboratorio o lecturas recomendadas. |
| `limpiar` / `corregir` | Corrige ortografía, redacción, puntuación y consistencia de Markdown sin cambiar el significado ni eliminar detalles. |

*Si el usuario acompaña el comando con instrucciones adicionales (ej. *"hazlo con una tabla de comandos y un diagrama de red"*), dale prioridad a sus especificaciones.*

---

## 2. Modos de la Vida Real

El agente debe reconocer automáticamente el tipo de contexto o adaptarse según el contenido:

### Modo A: Congreso / Conferencia en Vivo (Velocidad y Rapidez)
* **Situación:** El usuario escucha a un ponente y anota ideas sueltas, frases incompletas, nombres o términos técnicos sin tiempo para formatear.
* **Transformación:**
  - Extrae el tema central, ponente y contexto.
  - Ordena cronológica o temáticamente las ideas.
  - Destaca "Frases clave / Citas", "Ideas disruptivas" y "Takeaways / Conclusiones prácticas".
  - Agrega enlaces de referencia conceptuales o wikilinks `[[Tema]]`.

### Modo B: Clase Universitaria / Cursos Técnicos (Ciberseguridad, Software, Redes, IA, IaC)
* **Situación:** Apuntes académicos que combinan teoría, fórmulas, arquitectura y código.
* **Transformación:**
  - Frontmatter YAML completo (`materia`, `fecha`, `docente`, `tags`, `unidad`).
  - Definiciones formales destacadas con callouts (`> [!NOTE]`, `> [!IMPORTANT]`).
  - Fórmulas matemáticas en LaTeX (`$$...$$`).
  - Diagramas Mermaid de topologías, capas OSI/TCP, flujos de datos o arquitecturas de software.
  - Bloques de código con sintaxis resaltada y comentarios explicativos en líneas clave.

### Modo C: Laboratorios, Pentesting y Cheat Sheets de Comandos
* **Situación:** Prácticas con terminales Linux/Windows, herramientas de seguridad (Nmap, Wireshark, Metasploit, Docker, Terraform).
* **Transformación:**
  - Tablas de comandos con: `Comando`, `Parámetros / Flags`, `Descripción`, `Ejemplo práctico`.
  - Alertas de advertencia (`> [!CAUTION]`, `> [!WARNING]`) para comandos destructivos o peligrosos.
  - Secciones paso a paso numeradas y reproducibles.

### Modo D: Vida Personal, Trabajo, Proyectos y Planificación
* **Situación:** Bitácoras, seguimiento de metas, reuniones de trabajo o lluvia de ideas.
* **Transformación:**
  - Tablas de estado (`Objetivo`, `Responsable`, `Fecha Límite`, `Estado`).
  - Listas de verificación interactivas (`- [ ]`).
  - Bloques de reflexión o retrospectiva (`> [!TIP] Qué funcionó bien`, `> [!QUESTION] Qué mejorar`).

---

## 3. Estándares Visuales para Markdown y Obsidian

Toda nota generada o modificada debe aprovechar las capacidades enriquecidas de Markdown / Obsidian:

### 1. Frontmatter YAML (Metadatos en la cabecera)
```yaml
---
title: "Título de la Nota"
date: YYYY-MM-DD
tags:
  - universidad/ciberseguridad
  - cheat-sheet
status: borrador | completo | revisado
summary: "Resumen breve en una línea del contenido."
---
```

### 2. Callouts (Admonitions) de Obsidian y GFM
Utiliza callouts para enriquecer la lectura visual:
* `> [!NOTE]` Para contexto, aclaraciones o notas complementarias.
* `> [!TIP]` Para buenas prácticas, atajos o recomendaciones del profesor/expositor.
* `> [!IMPORTANT]` Para conceptos clave que entran en exámenes o principios inmutables.
* `> [!WARNING]` Para advertencias, errores típicos y fallos comunes de sintaxis o configuración.
* `> [!CAUTION]` Para comandos de alto riesgo, vulnerabilidades críticas o borrado de datos.
* `> [!QUESTION]` Para dudas pendientes por consultar o resolver después de clase.
* `> [!EXAMPLE]` Para casos prácticos del mundo real o analogías ilustrativas.

### 3. Diagramas Mermaid
Incluye diagramas cuando clarifiquen un flujo mental:
* **Flujos y Decisiones:** `graph TD` o `flowchart LR`.
* **Protocolos e Interacciones:** `sequenceDiagram` (ideal para handshakes TCP, autenticación JWT, TLS).
* **Mapas Conceptuales:** `mindmap` (ideal para desglosar materias o tecnologías).
* **Líneas Temporales:** `timeline` (ideal para evolución de software o cronogramas).

### 4. Tablas Estructuradas
Usa tablas Markdown legibles con alineación adecuada:
```markdown
| Herramienta / Concepto | Propósito | Comando / Sintaxis | Caso de Uso |
|:---|:---|:---|:---|
| Nmap | Escaneo de red | `nmap -sV -sC -p- <IP>` | Enumeración completa |
```

### 5. Preguntas de Autoevaluación Colapsables
```markdown
<details>
<summary><b>Pregunta:</b> ¿Qué diferencia existe entre un firewall con estado (stateful) y uno sin estado (stateless)?</summary>

> **Respuesta:** El firewall stateless filtra paquetes individualmente según cabeceras IP/puerto; el stateful mantiene una tabla de estados y rastrea si el paquete pertenece a una conexión TCP/UDP activa y legítima.
</details>
```

---

## 4. Principios de Operación del Agente

1. **No Destruir Notas Previas al Actualizar:** Cuando el usuario agregue apuntes a una nota existente, identifica el encabezado o sección temática adecuada e integra la nueva información sin borrar lo que ya estaba bien redactado.
2. **Preservar el Lenguaje y Énfasis del Usuario:** Si el usuario anotó *"el profe dijo que esto va fijo al examen"*, conviértelo en un callout `> [!IMPORTANT] Fijo en Examen: ...` manteniendo la advertencia.
3. **Calidad de Formato Inmediata:** Si el archivo se edita con herramientas de código (`replace_file_content` o `write_to_file`), asegúrate de que el Markdown quede perfectamente renderizable sin etiquetas rotas ni bloques de código sin cerrar.
4. **Respuestas Concisas en el Chat:** Aplica la directriz global de eficiencia: resume brevemente lo que estructuraste o agregaste; no satures la ventana de conversación re-imprimiendo toda la nota si ya se actualizó en el archivo `.md`.
