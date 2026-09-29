# Memoria Global del Desarrollador — Contexto y Preferencias Universales

Este archivo almacena el perfil técnico, principios de ingeniería y preferencias operativas universales de Jorge en todos sus dispositivos (IDE y CLI). Se lee de forma persistente al inicio de cada sesión.

---

## 1. Perfil del Desarrollador y Dinámica de Trabajo

* **Rol y Nivel:** Ingeniero de software senior (+10 años de experiencia). Exige rigor técnico, soluciones a nivel de causa raíz y rechazo absoluto a parches, hacks o apaños provisionales.
* **Entorno de Trabajo:** Pantalla dividida habitual (interfaz CLI/IDE en un lado y archivo de código o `.md` abierto en el otro).
* **Idioma:** Español profesional, claro, directo y conciso.
* **Cero Emojis:** Queda estrictamente prohibido el uso de emojis en documentación, código, commits, chat o configuraciones.
* **Cero Lenguaje Marketero / Inflado:** Prohibido el uso de adjetivos comerciales o grandilocuentes (*"la solución definitiva"*, *"arquitectura enterprise revolucionaria"*). Toda redacción debe ser sobria, fáctica, verificable y técnica.

---

## 2. Paradigmas y Estándares Consolidados

* **Documentación Técnica:**
  - Metodología: **Docs-as-Code** con **Taxonomía Jerárquica Numérica (`01-`, `02-...`)** y modelo de **Dosier Técnico Modular**.
  - Libertad total para expandir carpetas y archivos en profundidad sin límites artificiales de tamaño.
  - Sincronización viva en el mismo turno ante cambios sustanciales en el código.
* **Ingeniería de Software:**
  - Agnóstico a lenguajes y frameworks (C#, TypeScript, Python, Go, Rust, Java, React, Vue, Svelte, etc.).
  - Separación estricta de capas (Clean Architecture, Hexagonal, DDD, CQRS, Monolito Modular, Microservicios).
  - Tipado estricto (cero `any` o casts forzados), validación defensiva en bordes y contratos limpios.
  - Base de datos: prevención estricta de consultas N+1, transaccionalidad ACID e integridad referencial.
* **Sistemas y DevOps:**
  - Linux y Windows: estándares estrictos de scripting (Bash `set -euo pipefail`, PowerShell nativo).
  - Principio de mínimo privilegio (prohibido `chmod 777` o loops ciegos de reinicio).
  - Idempotencia y observabilidad real mediante logs estructurados.

---

## 3. Diccionario de Comandos Rápidos Universales

| Comando | Propósito |
|---|---|
| `profesional` / `senior` / `sin-parches` | Orden estricta de auditoría: audita la solución, erradica parches y eleva la arquitectura al estándar más limpio de la industria. |
| `hazlo` / `pulir` / `organizar` | En toma de apuntes, transforma texto bruto de congresos/clases en notas estructuradas en Markdown/Obsidian. |
| `documentar` / `sincronizar-docs` | En documentación técnica, audita o actualiza los `.md` numéricos de acuerdo con los últimos cambios de código. |

---

## 4. Política de Estabilidad de esta Memoria Global

* **Estabilidad entre Dispositivos:** Este archivo permanece estable y sincronizado a través del repositorio central `skills_jorge`.
* **Escritura Dinámica:** Las notas y decisiones específicas de cada desarrollo diario se registran en el archivo local `<proyecto>/.agents/memory.md`, evitando desincronizaciones entre dispositivos.
