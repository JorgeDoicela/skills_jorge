---
name: desarrollo-frontend
description: Activa esta skill para tareas de desarrollo frontend, diseño de interfaces de usuario (UI), componentes de React, estilos CSS, animaciones interactivas o integraciones en el cliente.
---
# Directrices Globales de Desarrollo Frontend y UI/UX Premium

Esta habilidad define los estándares profesionales de diseño de interfaces y desarrollo frontend para todos los proyectos.

## 1. Estética Premium e Interfaz de Usuario (UI/UX)
* **Alineación Visual y Diseño Moderno:** Usa un sistema de espaciado proporcional y consistente (flex/grid, unidades rem). Diseña interfaces memorables con colores HSL a medida, gradientes suaves, sombras difusas y bordes delgados de alta precisión (`border-border-thin`), garantizando soporte premium para modos oscuros (dark mode).
* **Interacciones y Fluidez (Micro-animaciones):** Implementa transiciones suaves (`transition-all duration-200`) en estados hover, botones y modales. Utiliza respuestas visuales en tiempo real, esqueletos de carga (skeletons) y animaciones de carga para mejorar la experiencia de usuario.
* **Adaptabilidad y Responsividad:** Diseña layouts adaptables. Para paneles principales o barras de herramientas laterales que sean colapsables, guarda su estado de visibilidad en almacenamiento local (`localStorage`) para persistir la preferencia del usuario.
* **Tipografía Profesional:** Utiliza fuentes modernas de Google Fonts (como Inter, Outfit o Roboto) en lugar de las tipografías predeterminadas del navegador.

## 2. Componentes de React y TypeScript
* **Responsabilidad Única y Modularización:** Mantén los componentes pequeños y modulares. Si un componente supera las 400-500 líneas de código, extrae inmediatamente sus bloques a subcomponentes en una subcarpeta `components/`.
* **Tipado Estricto:** Define interfaces claras para las propiedades (`Props`) de cada componente. Evita estrictamente el uso de `any`.
* **Hooks Personalizados:** Separa la lógica compleja o del lado del cliente del renderizado de la UI encapsulándola en Hooks personalizados.
* **Flujo Limpio de Datos:** Delega la manipulación del estado global y llamadas de API en componentes contenedores principales. Mantén los componentes secundarios enfocados principalmente en la representación visual (componentes de presentación) para optimizar el rendimiento.

## 3. Estilos y Estructura CSS
* **Vanilla CSS / CSS Modules:** Prioriza Vanilla CSS bien estructurado o CSS Modules para máximo control del diseño.
* **TailwindCSS:** Evitar por defecto. Solo se usará si el proyecto ya lo tiene configurado o si el desarrollador lo solicita explícitamente.

## 4. Integración de API y Colaboración en Tiempo Real
* **Formularios y Estado Compartido:** Al trabajar con flujos colaborativos en tiempo real (ej. WebSockets, CRDTs, Yjs), encapsula correctamente las entradas utilizando componentes vinculados al estado compartido de forma óptima.
* **Integración de Servicios y APIs:** Usa clientes HTTP estructurados y maneja de manera proactiva la serialización (camelCase o snake_case) de los DTOs provenientes del servidor para evitar discrepancias de tipos.
