// =============================================================================
// PLANTILLA INSTITUCIONAL DE INGENIERÍA EN IA Y CIBERSEGURIDAD (UBE)
// =============================================================================

#let reporte_ingenieria(
  titulo: "Título de la Actividad / Laboratorio",
  subtitulo: "Subtítulo o Descripción Breve",
  materia: "Nombre de la Asignatura",
  codigo_tarea: "A1_Laboratorio",
  docente: "Nombre del Docente",
  autor: "Jorge Doicela",
  fecha: datetime.today().display("[day]/[month]/[year]"),
  body
) = {
  // Configuración general del documento
  set document(title: titulo, author: autor)
  set page(
    paper: "a4",
    margin: (x: 2.5cm, top: 3cm, bottom: 2.5cm),
    header: context {
      let page_num = counter(page).get().first()
      if page_num > 1 [
        #text(size: 9pt, fill: luma(100))[
          #grid(
            columns: (1fr, 1fr),
            align: (left, right),
            [#materia — #codigo_tarea],
            [#autor]
          )
          #v(-4pt)
          #line(length: 100%, stroke: 0.5pt + luma(180))
        ]
      ]
    },
    footer: context {
      let page_num = counter(page).get().first()
      if page_num > 1 [
        #text(size: 9pt, fill: luma(100))[
          #grid(
            columns: (1fr, 1fr),
            align: (left, right),
            [Universidad Bolivariana del Ecuador],
            [Página #page_num]
          )
        ]
      ]
    }
  )

  // Fuentes y espaciado
  set text(font: ("Times New Roman", "DejaVu Serif"), size: 11pt, lang: "es")
  set par(justify: true, leading: 0.8em, first-line-indent: 0pt)
  show raw: set text(font: "JetBrains Mono", size: 9pt)
  show raw.where(block: true): it => block(
    fill: rgb("#f6f8fa"),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    stroke: 0.5pt + rgb("#d0d7de"),
    it
  )

  // Portada Institucional
  align(center)[
    #v(1cm)
    #text(size: 16pt, weight: "bold", tracking: 1pt)[UNIVERSIDAD BOLIVARIANA DEL ECUADOR]\
    #v(0.3cm)
    #text(size: 13pt, weight: "medium", fill: rgb("#1f2328"))[FACULTAD DE INGENIERÍA, CIENCIAS Y TECNOLOGÍA]\
    #text(size: 12pt, fill: rgb("#3a3a3c"))[INGENIERÍA EN INTELIGENCIA ARTIFICIAL Y CIBERSEGURIDAD]\
    #v(2.5cm)

    #rect(width: 100%, stroke: (left: 4pt + rgb("#0969da")), fill: rgb("#f6f8fa"), inset: (x: 15pt, y: 15pt))[
      #align(left)[
        #text(size: 18pt, weight: "bold", fill: rgb("#1f2328"))[#titulo]\
        #if subtitulo != "" [
          #v(0.3cm)
          #text(size: 12pt, style: "italic", fill: rgb("#57606a"))[#subtitulo]
        ]
      ]
    ]

    #v(3.5cm)

    #align(left)[
      #grid(
        columns: (auto, 1fr),
        row-gutter: 0.8em,
        column-gutter: 1.5em,
        [*Asignatura:*], [#materia],
        [*Código:*], [#codigo_tarea],
        [*Docente:*], [#docente],
        [*Estudiante:*], [#autor],
        [*Fecha:*], [#fecha],
      )
    ]
  ]

  pagebreak()

  // Cuerpo del informe
  body
}

// =============================================================================
// EJEMPLO DE USO DEL DOCUMENTO:
// =============================================================================

#show: doc => reporte_ingenieria(
  titulo: "Diseño y Análisis de Complejidad de Algoritmos",
  subtitulo: "Evaluación de Casos de Prueba y Rendimiento Asintótico",
  materia: "Análisis y Resolución de Problemas",
  codigo_tarea: "A1_Complejidad",
  docente: "Docente de la Asignatura",
  doc
)

= 1. Introducción
El objetivo de este laboratorio es analizar el comportamiento temporal y espacial de los algoritmos de ordenamiento frente a conjuntos de datos de escala creciente.

= 2. Metodología y Desarrollo

== 2.1 Implementación en C
A continuación se presenta el código evaluado para el cálculo de la mediana:

```c
#include <stdio.h>

void ordenar(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}
```

== 2.2 Notación Asintótica
El análisis formal de la sumatoria arroja la siguiente cota asintótica:

$ T(n) = sum_(i=0)^(n-1) (n - i - 1) = (n(n - 1)) / 2 = Theta(n^2) $

= 3. Conclusiones y Cumplimiento
Todos los casos de prueba fueron verificados contra la rúbrica institucional con resultado óptimo.

= Referencias
- Cormen, T. H. (2022). *Introduction to Algorithms*. MIT Press.
