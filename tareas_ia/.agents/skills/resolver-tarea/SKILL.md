---
name: resolver-tarea
description: "Flujo integral y protocolar para resolver tareas académicas en rubric-driven garantizando cobertura del 100% de la rúbrica y alineación con los apuntes del docente."
---

# Habilidad: Resolver Tareas Académicas (`resolver-tarea`)

Esta habilidad guía al agente en la resolución sistemática de una tarea universitaria dentro de `rubric-driven`, garantizando nota máxima mediante el análisis de rúbricas e inyección de contexto de clase.

---

## 1. Verificación Inicial de Entorno
Antes de redactar código o documentos:
1. Comprueba la existencia del entorno virtual y configuración:
   ```bash
   .venv/bin/python _plantillas/tareas.py verificar
   ```
2. Asegúrate de que existe `.env` en la raíz con el nombre del estudiante y sufijo configurado.

---

## 2. Ingesta de Contexto (Paso a Paso)
Cuando el usuario indique una tarea (ej. `materias/redes/A1_Subredes`):

1. **Lectura de la Ficha:** Abre y analiza `materias/<materia>/<carpeta>/TAREA.md`.
2. **Lectura de Enunciado:** Revisa todo el contenido en `materias/<materia>/<carpeta>/enunciado/`. Si hay PDFs o DOCX, extrae el texto clave y los requisitos del profesor.
3. **Lectura de Apuntes en Obsidian:** Si `TAREA.md` apunta a una ruta en `/home/jorge/Documentos/Vida de Jorge/...`, lee el apunte de clase correspondiente.
   * Anota los términos clave que usa el docente.
   * Detecta si el docente prohíbe ciertas bibliotecas o enfoques.
   * Identifica la notación o convenciones que el profesor espera ver.
4. **Mapeo de la Rúbrica:**
   * Lista todos los criterios de evaluación con sus puntos.
   * Diseña una sección o subsección específica para cubrir cada criterio.

---

## 3. Elección del Canal y Generación

### Si es Canal 1: Ofimática Formal (`apa_docx.py`)
1. Edita el script `generar_documento.py` en la carpeta de la tarea.
2. Utiliza las funciones del módulo `apa_docx`:
   * `nuevo_documento(...)`
   * `titulo(doc, "...", nivel)`
   * `parrafo(doc, "...")`
   * `tabla(...)` / `figura(...)`
   * `referencia(...)`
3. Ejecuta el generador para producir el archivo Word:
   ```bash
   .venv/bin/python materias/<materia>/<carpeta>/generar_documento.py
   ```
4. Compila a PDF desatendido:
   ```bash
   .venv/bin/python _plantillas/tareas.py pdf materias/<materia>/<carpeta>
   ```

### Si es Canal 2: Tipografía Técnica (`Typst`)
1. Copia la plantilla técnica de ingeniería a la carpeta de la actividad:
   ```bash
   cp .agents/skills/typst-ingenieria/plantilla_ingenieria.typ materias/<materia>/<carpeta>/documento.typ
   ```
2. Rellena los metadatos (título, materia, fecha, autor) y desarrolla las secciones con bloques de código, tablas y fórmulas.
3. Compila a PDF:
   ```bash
   typst compile materias/<materia>/<carpeta>/documento.typ
   ```

---

## 4. Auditoría y Cierre Obligatorio
1. Abre `TAREA.md` y completa la columna **"Dónde se cumple"** en la tabla de Rúbrica con el título de la sección que responde a cada criterio.
2. Cambia `Estado: pendiente` a `Estado: listo` en `TAREA.md`.
3. Actualiza la tabla de estado en `materias/<materia>/README.md`.
4. Informa al usuario con un resumen conciso:
   * Enlace a los archivos generados (.docx / .pdf).
   * Confirmación de que todos los criterios de la rúbrica fueron cubiertos al 100%.
   * Indicación de si se requieren capturas reales adicionales de su equipo.
