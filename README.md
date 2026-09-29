# Ecosistema de Skills y Reglas para Antigravity / Gemini

Este repositorio centraliza y organiza la configuración de **Skills** y **Reglas (AGENTS.md)** tanto globales como específicas de proyectos (como DIITRA) para el agente Antigravity.

---

## Estructura del Repositorio

```text
skills_jorge/
├── global/
│   ├── AGENTS.md                   # Reglas universales de comportamiento, ahorro de tokens y orquestación
│   ├── memory.md                   # Memoria global estable y persistente (perfil de Jorge y preferencias universales)
│   └── skills/                     # Skills globales compartidas entre todos los proyectos
│       ├── ahorro-tokens/          # Restricción de búsquedas y respuestas rápidas
│       ├── apuntes/                # Notas enriquecidas Markdown/Obsidian, clases, congresos y comandos rápidos
│       ├── datos-seguros/          # Seguridad en BD, credenciales y datos de prueba
│       ├── desarrollo-backend/     # Estándares universales (Clean Architecture, DDD, SOLID, APIs, cero parches)
│       ├── desarrollo-frontend/    # Estándares universales UI/UX (Multi-framework, Component-Driven, WCAG)
│       ├── documentacion/          # Documentación técnica modular Docs-as-Code (01-, 02-...), sin lenguaje marketero ni emojis
│       └── sysadmin/               # Administración de sistemas Linux/Windows y DevOps (senior)
│
├── diitra/
│   └── .agents/                    # Configuración del workspace específico DIITRA
│       ├── AGENTS.md               # Stack tecnológico de DIITRA y matriz de combinación de skills
│       ├── memory.md               # Memoria local persistente de DIITRA (decisiones arquitectónicas consolidadas)
│       └── skills/
│           ├── diitra-backend/     # Extensión: convenciones inv_, sigafi (solo lectura), EF Core
│           └── diitra-frontend/    # Extensión: Yjs, CoWorkField, snake_case, Axios, umbral 700 lineas
│
└── README.md                       # Guía de despliegue y orquestación (este archivo)
```

---

## Diagrama de Orquestación y Cascada de Skills

Cuando trabajas en un proyecto (ej. DIITRA), las habilidades operan en **cascada jerárquica**:

```mermaid
flowchart TD
    subgraph global ["1. Capa Global (~/.gemini/config o %USERPROFILE%\.gemini\config)"]
        G_AGENTS["AGENTS.md Global"]
        G_MEM["memory.md Global"]
        G_BE["desarrollo-backend"]
        G_FE["desarrollo-frontend"]
        G_SEC["datos-seguros"]
        G_EFF["ahorro-tokens"]
        G_SYS["sysadmin"]
        G_NOTES["apuntes"]
        G_DOCS["documentacion"]
    end

    subgraph PROYECTO ["2. Capa Proyecto DIITRA (<proyecto>/.agents)"]
        P_AGENTS["AGENTS.md DIITRA"]
        P_BE["diitra-backend"]
        P_FE["diitra-frontend"]
    end

    TaskFrontend["Tarea UI / React en DIITRA"] --> G_FE
    TaskFrontend --> P_FE

    TaskBackend["Tarea API / C# en DIITRA"] --> G_BE
    TaskBackend --> P_BE

    TaskSecurity["Modificación Sensible / Login"] --> G_SEC
    TaskSysAdmin["Tareas de SO / Scripts / Redes"] --> G_SYS
    TaskNotes["Toma de Notas / Clases / Congresos"] --> G_NOTES
    TaskDocs["Documentación Técnica Docs-as-Code"] --> G_DOCS
```

---

## Guía de Despliegue Manual (Multiplataforma: IDE y CLI)

Sigue estos pasos para instalar y activar la configuración en cualquier dispositivo (Windows, Linux o macOS):

### Paso 1: Instalar la Capa Global

Copia el contenido de `global/` al directorio de configuración global de Gemini/Antigravity de tu usuario.

#### En Windows (PowerShell):
```powershell
# Crear directorios si no existen
New-Item -ItemType Directory -Force -Path "$HOME\.gemini\config\skills"

# Copiar reglas globales AGENTS.md y memoria global estable
Copy-Item -Path "global\AGENTS.md" -Destination "$HOME\.gemini\config\AGENTS.md" -Force
Copy-Item -Path "global\memory.md" -Destination "$HOME\.gemini\config\memory.md" -Force

# Copiar las 7 skills globales
Copy-Item -Path "global\skills\*" -Destination "$HOME\.gemini\config\skills\" -Recurse -Force
```

#### En Linux / macOS (Bash / Zsh):
```bash
# Crear directorios si no existen
mkdir -p ~/.gemini/config/skills

# Copiar reglas globales AGENTS.md y memoria global estable
cp global/AGENTS.md ~/.gemini/config/AGENTS.md
cp global/memory.md ~/.gemini/config/memory.md

# Copiar las 7 skills globales
cp -r global/skills/* ~/.gemini/config/skills/
```

---

### Paso 2: Instalar la Capa de Proyecto (Ejemplo: DIITRA)

Copia la carpeta `.agents` del proyecto a la raíz de tu workspace local:

#### En Windows (PowerShell):
```powershell
Copy-Item -Path "diitra\.agents" -Destination "<ruta-a-tu-proyecto>\.agents" -Recurse -Force
```

#### En Linux / macOS (Bash):
```bash
cp -r diitra/.agents "<ruta-a-tu-proyecto>/.agents"
```

---

## Verificación de Instalación

Una vez instalados los archivos en sus destinos:
- **Tanto en el IDE como en el CLI:** Al abrir cualquier proyecto, el agente respetará las directrices del `AGENTS.md` global y tendrá disponibles las 7 skills globales (`ahorro-tokens`, `apuntes`, `datos-seguros`, `desarrollo-backend`, `desarrollo-frontend`, `documentacion`, `sysadmin`).
- Al abrir un proyecto con configuración local (ej. **DIITRA**), el agente detectará automáticamente `.agents/` y combinará las directrices locales (`diitra-frontend`, `diitra-backend`) con las skills globales correspondientes.
