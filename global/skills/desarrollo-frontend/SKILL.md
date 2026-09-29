---
name: desarrollo-frontend
description: Activa esta skill para desarrollo frontend profesional, diseño UI/UX de alto nivel, componentes modulares (React, Vue, Svelte, Angular, Next.js, Vanilla), sistemas de diseño, estilos CSS/Modules, gestión predecible de estado, accesibilidad WCAG y cero parches.
---
# Directrices Universales de Desarrollo Frontend y UI/UX Senior

Esta habilidad define los estándares innegociables de ingeniería de interfaces de usuario, arquitectura frontend y experiencia de usuario (UX/UI) en cualquier framework o tecnología web.

---

## 1. Mandato Innegociable: Cero Parches en Frontend

* **Prohibición Absoluta de Parches:** Queda terminantemente prohibido aplicar soluciones rápidas o apaños cosméticos que enmascaren problemas de arquitectura o diseño.
* **Antipatrones Prohibidos:**
  - **Uso de `any` en TypeScript:** Prohibido usar `any` para eludir errores del compilador. Tipa estrictamente modelos, interfaces de Props, eventos y payloads.
  - **Hacks de Especificidad CSS:** Prohibido usar `!important` o estilos inline aleatorios para forzar alineaciones que deben resolverse con un sistema de layout limpio (Flexbox, CSS Grid o tokens de espaciado).
  - **Componentes Monolito:** Prohibido crear componentes gigantescos (>400 líneas) que mezclen llamadas de red, estado global, transformaciones de datos y renderizado.
  - **Estados Incompletos:** Prohibido omitir estados de carga (skeletons/spinners), estados vacíos (empty states) o estados de error descriptivos. Cada interfaz interactiva debe gestionar el ciclo de vida completo: `idle`, `loading`, `error`, `success`.
  - **Mutación Directa del Estado:** Prohibido mutar variables reactivas o estado local directamente sin respetar la inmutabilidad.
* **Disparador `profesional` / `senior` / `sin-parches`:** Ante cualquier duda de interfaz o refactorización, el agente auditará la solución asegurando modularidad, tipado estricto y fidelidad visual al sistema de diseño.

---

## 2. Arquitectura de Interfaces y Component-Driven Design

* **Separación Estricta de Responsabilidades:**
  - **Componentes de Presentación (Dumb/UI Components):** Enfocados exclusivamente en la representación visual y affordance. Reciben datos y emiten eventos vía props. Fáciles de probar y altamente reutilizables.
  - **Componentes Contenedores / Páginas (Smart Components):** Orquestan llamadas de API, suscripciones en tiempo real y lectura de estado global.
  - **Capa de Lógica Reutilizable:** Encapsula la lógica de negocio del cliente, cálculos complejos o consumo de servicios en Hooks personalizados (React), Composables (Vue), o Servicios inyectables (Angular/Vanilla).
* **Modularización Proactiva (Límite 400 Líneas):**
  - Si un componente supera las 400 líneas, extrae de inmediato sus secciones lógicas a subcomponentes en una carpeta `components/` adyacente.
* **Flujo Unidireccional e Inmutabilidad:**
  - Los datos fluyen hacia abajo (props/inputs) y los eventos fluyen hacia arriba (callbacks/outputs). El estado compartido debe ser predecible y serializable.

---

## 3. Estética Premium, Sistemas de Diseño y CSS

* **Design Tokens y Coherencia Visual:**
  - Utiliza siempre tokens del sistema de diseño (variables CSS / Custom Properties) para colores, tipografías, radios de borde (`border-radius`), sombras y espaciados proporcionales (escala basada en rems).
  - Prohibido introducir colores hexadecimales o espaciados arbitrarios ad-hoc que rompan la armonía visual del producto.
* **Paletas Sofisticadas y Modo Oscuro:**
  - Emplea combinaciones armónicas basadas en HSL (tonos neutros balanceados, acentos con contraste suficiente, gradientes sutiles y bordes de alta definición). Soporta modos claro y oscuro de manera nativa y consistente.
* **Micro-animaciones y Fluidez:**
  - Agrega transiciones sutiles (`transition: all 200ms ease`) en estados hover, focus, modales y botones. Una interfaz reactiva y viva mejora sustancialmente la percepción de rendimiento y calidad.
* **Tipografía Profesional:**
  - Aplica tipografías modernas y legibles (Inter, Roboto, Outfit, JetBrains Mono para código) respetando la jerarquía tipográfica (escalas de tamaño y peso `font-weight`).

---

## 4. Experiencia de Usuario (UX) y Accesibilidad (WCAG AA)

* **Reducción de Carga Cognitiva:**
  - Diseña para que el usuario identifique la acción principal en menos de 3 segundos. Jerarquía visual contundente: el elemento primario destaca claramente sobre los secundarios.
* **Affordance y Feedback Inmediato:**
  - Todo elemento interactivo debe comunicar visualmente que puede ser accionado (`cursor: pointer`, cambio sutil de elevación o color al hover/focus).
  - Nunca dejes al usuario sin respuesta visual tras un clic: desactiva botones en proceso, muestra indicadores de progreso y notifica el resultado con mensajes descriptivos.
* **Accesibilidad Innegociable (A11y):**
  - Contraste de color mínimo WCAG AA (4.5:1 para texto estándar).
  - Elementos de formulario con etiquetas visibles y asociadas (`htmlFor`/`for`).
  - Atributos semánticos `aria-label`, `role` y soporte completo de navegación por teclado (`tabindex`, focus visible).
* **Diseño Responsivo Real:**
  - Diseña interfaces adaptables desde dispositivos móviles hasta pantallas de alta resolución (Fluid Layouts, Flexbox, Grid, container queries). Guarda preferencias de interfaz (como barras laterales colapsadas) en `localStorage`.

---

## 5. Integración de APIs, Rendimiento y Resiliencia en Cliente

* **Contratos Fuertes con el Backend:**
  - Maneja de forma explícita la serialización entre cliente y servidor (camelCase vs snake_case).
  - Valida respuestas en los bordes si la API es externa o dinámica (usando esquemas tipados como Zod).
* **Rendimiento Web:**
  - Divide el código por rutas (code-splitting / lazy loading de componentes pesados).
  - Optimiza el ciclo de renderizado: memoiza transformaciones costosas y evita recreaciones innecesarias de funciones en renders repetitivos.
* **Resiliencia ante Fallos de Red:**
  - Maneja tiempos de espera (timeouts), estados offline e implementa reintentos amigables o mecanismos de recuperación para que la aplicación nunca quede en pantalla en blanco.
