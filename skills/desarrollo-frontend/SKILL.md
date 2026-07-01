---
name: desarrollo-frontend
description: Activa esta skill para tareas de desarrollo frontend, diseño de interfaces de usuario (UI), componentes de React, estilos CSS, animaciones interactivas o integraciones en el cliente.
---
# Directrices Globales de Desarrollo Frontend y UI/UX Premium

Esta habilidad define los estándares profesionales de diseño de interfaces y desarrollo frontend para todos los proyectos.

## 1. Estética Premium e Interfaz de Usuario (UI/UX)
* **Alineación Visual y Espaciado:** Usa un sistema de espaciado consistente y proporcional (basado en rem o flex/grid).
* **Paleta de Colores Armoniosa:** Evita colores planos primarios (rojo puro, azul puro). Usa paletas personalizadas, gradientes suaves y soportes premium para modos oscuros (dark mode).
* **Micro-animaciones:** Agrega transiciones suaves (`transition-all duration-200`) en estados hover, botones y modales para dar sensación de fluidez y dinamismo.
* **Tipografía Profesional:** Utiliza fuentes modernas de Google Fonts (como Inter, Outfit o Roboto) en lugar de las tipografías predeterminadas del navegador.

## 2. Componentes de React y TypeScript
* **Responsabilidad Única:** Mantén los componentes pequeños y modulares. Si un componente supera las 200 líneas, evalúa dividirlo en subcomponentes.
* **Tipado Estricto:** Define interfaces claras para las propiedades (`Props`) de cada componente. Evita el uso de `any`.
* **Hooks Personalizados:** Separa la lógica compleja del renderizado de la UI encapsulándola en Hooks personalizados.

## 3. Estilos y Estructura CSS
* **Vanilla CSS / CSS Modules:** Prioriza Vanilla CSS bien estructurado o CSS Modules para máximo control del diseño.
* **TailwindCSS:** Solo se usará si el proyecto ya lo tiene configurado o si el desarrollador lo solicita explícitamente.
