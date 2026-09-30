---
name: apa7-docx
description: "Cheat sheet técnico y catálogo de funciones de python-docx para la plantilla monocromática apa_docx.py de rubric-driven."
---

# Habilidad: Generación Documental APA 7 (`apa7-docx`)

Esta habilidad documenta las interfaces y buenas prácticas para programar informes en Word con `_plantillas/apa_docx.py`.

---

## 1. Inicialización de Documento
El script debe importar el módulo e invocar `nuevo_documento`:

```python
import sys
from pathlib import Path

AQUI = Path(__file__).resolve().parent
sys.path.insert(0, str(AQUI.parents[2] / "_plantillas"))
from apa_docx import *

SALIDA = AQUI / nombre_entregable("A1_Titulo_Corto")

doc, figura, tabla = nuevo_documento(
    titulo="Análisis Comparativo de Algoritmos",
    materia="Análisis y Resolución de Problemas",
    salida=SALIDA,
)
```

---

## 2. Elementos Disponibles

### Títulos de Sección
```python
# Nivel 2: Secciones principales (alineado izquierda, negrita)
titulo(doc, "1. Introducción al Problema", 2)

# Nivel 3: Subsecciones (alineado izquierda, negrita, cursiva)
titulo(doc, "1.1 Complejidad Temporal en el Peor Caso", 3)

# Nivel 1: Especial para Referencias o Apéndices (centrado, negrita)
titulo(doc, "Referencias", 1)
```

### Párrafos y Listas
```python
# Párrafo estándar con sangría APA 7
parrafo(doc, "Este informe detalla el comportamiento del algoritmo...")

# Viñetas
vinieta(doc, "Primer elemento o característica observada.")
vinieta(doc, "Segundo elemento o caso de prueba.")
```

### Bloques de Código
```python
codigo(doc, """// Algoritmo de ordenamiento rápido en C
void quicksort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quicksort(arr, low, pi - 1);
        quicksort(arr, pi + 1, high);
    }
}""")
```

### Tablas APA 7
```python
encabezados = ["Algoritmo", "Mejor Caso", "Caso Promedio", "Peor Caso"]
filas = [
    ("QuickSort", "O(n log n)", "O(n log n)", "O(n^2)"),
    ("MergeSort", "O(n log n)", "O(n log n)", "O(n log n)"),
    ("BubbleSort", "O(n)", "O(n^2)", "O(n^2)"),
]

# Firma: tabla(doc, numero, titulo, columnas, filas, nota=None)
tabla(
    doc,
    1,
    "Comparativa de Complejidad Computacional Asintótica",
    encabezados,
    filas,
    nota="Nota. Adaptado de Introduction to Algorithms (Cormen et al., 2022)."
)
```

### Figuras y Evidencias
```python
# Firma: figura(doc, numero, titulo, ruta_imagen, nota=None)
figura(
    doc,
    1,
    "Captura de Tráfico TCP Handshake en Wireshark",
    AQUI / "capturas/wireshark_syn.png",
    nota="Nota. Salida obtenida en el laboratorio con tcpdump y analizada en Wireshark."
)
```

### Referencias Bibliográficas (APA 7)
```python
referencia(doc, "Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022). Introduction to algorithms (4th ed.). MIT Press.")
referencia(doc, "Tanenbaum, A. S., & Bos, H. (2015). Modern operating systems (4th ed.). Pearson.")
```

---

## 3. Reglas de Oro y Advertencias Técnicas
1. **Regla de Dos Tablas:** En `python-docx`, **nunca** insertes dos tablas consecutivas sin al menos un párrafo de texto intermedio. De lo contrario, Word las unifica o corrompe el XML interno.
2. **Imágenes Monocromáticas:** Preferir capturas legibles con temas claros o contrastes altos.
3. **Cierre del Documento:** Finalizar siempre con:
   ```python
   guardar_documento(doc, SALIDA)
   ```
