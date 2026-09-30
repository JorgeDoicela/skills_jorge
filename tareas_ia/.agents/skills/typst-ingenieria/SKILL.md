---
name: typst-ingenieria
description: "Directrices y catálogo para generar informes de laboratorio, código en C/Python y análisis matemático con Typst en ingeniería."
---

# Habilidad: Tipografía Técnica con Typst (`typst-ingenieria`)

Esta habilidad proporciona el flujo de trabajo para compilar reportes técnicos y científicos instantáneos con Typst, evitando el overhead de LaTeX o Word.

---

## 1. Cuándo Utilizar Typst
- Prácticas de laboratorio con código fuente en C, Python o scripts Bash.
- Tareas con deducciones formales, lógica de proposiciones y tablas de verdad.
- Reportes de redes con capturas de paquetes y tablas de subredes.
- Entregables donde el profesor acepta o prefiere directamente un archivo PDF.

---

## 2. Comandos Operativos
Compilación rápida de un archivo `.typ` a `.pdf`:
```bash
typst compile documento.typ
```

Compilación continua con recarga en vivo (modo escucha al editar):
```bash
typst watch documento.typ
```

---

## 3. Elementos Esenciales en Typst

### Bloques de Código con Resaltado
````typst
#figure(
  caption: [Implementación de sincronización con Mutex en C],
  ```c
  #include <stdio.h>
  #include <pthread.h>

  pthread_mutex_t lock;

  void* tarea(void* arg) {
      pthread_mutex_lock(&lock);
      // Sección crítica protegida
      printf("Acceso exclusivo al recurso compartido\n");
      pthread_mutex_unlock(&lock);
      return NULL;
  }
  ```
)
````

### Tablas Técnicas con Estilo
```typst
#figure(
  caption: [Plan de Subredes IPv4 VLSM],
  table(
    columns: (1.5fr, 2fr, 1.5fr, 1fr),
    align: (left, center, center, center),
    [*Subred*], [*Dirección de Red*], [*Máscara*], [*Hosts Útiles*],
    [VLAN 10 - Servidores], [192.168.10.0], [255.255.255.224 (/27)], [30],
    [VLAN 20 - Usuarios], [192.168.10.32], [255.255.255.192 (/26)], [62],
  )
)
```

### Matemáticas y Lógica Formal
```typst
$ (p or q) and (not p) arrow.double q $

$ T(n) = 2 T(n/2) + Theta(n) = Theta(n log n) $
```

---

## 4. Plantilla Reutilizable
La plantilla base institucional se encuentra lista para copiar en:
`.agents/skills/typst-ingenieria/plantilla_ingenieria.typ`
