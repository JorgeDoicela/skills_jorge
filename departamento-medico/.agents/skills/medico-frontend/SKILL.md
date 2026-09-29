---
name: medico-frontend
description: Guía técnica exhaustiva del frontend Angular 22 SSR del Departamento Médico ISTPET (Arquitectura Standalone, Signals, MSAL Entra ID, Fluent 2 y Vitest).
---

# Skill: Frontend - Departamento Médico ISTPET (Angular 22 SSR & Fluent 2)

Esta skill define la arquitectura oficial, patrones de desarrollo senior, gestión reactiva de estado y normas UI/UX para el repositorio `departamento_medico_istpet-front`. Prohíbe el uso de `any`, mutaciones mutables impredecibles y parches en componentes.

---

## 1. Arquitectura de Software y Principios de Diseño

* **Framework:** Angular 22 con soporte nativo de Server-Side Rendering (`@angular/ssr`), ejecutado sobre Node.js 22 Alpine y Express 5.
* **Componentes Standalone:** Todo componente, directiva o pipe es Standalone (`standalone: true` implícito en Angular 22). No se utilizan NgModules obsoletos.
* **Estrategia de Detección de Cambios:** `ChangeDetectionStrategy.OnPush` obligatorio en el 100% de las vistas y componentes para garantizar rendimiento óptimo y predictibilidad de renderizado.
* **Inyección de Dependencias:** Uso exclusivo de la función `inject(...)` a nivel de propiedad de clase (evitar inyección verbosa por constructor):
  ```typescript
  export class AtencionV2Component {
    private readonly servicio = inject(AtencionV2Service);
    private readonly auth = inject(Autenticacion);
    private readonly toast = inject(ToastService);
  }
  ```

---

## 2. Gestión Reactiva del Estado con Angular Signals

* **Estado Local con Signals:** El estado de los formularios y vistas complejas se modela con primitivas reactivas `signal()`, derivadas con `computed()` y efectos colaterales auditados con `effect()`:
  ```typescript
  // Estado local reactivo
  readonly cargando = signal<boolean>(false);
  readonly atenciones = signal<AtencionV2DetalleDto[]>([]);
  readonly terminoBusqueda = signal<string>('');

  // Estado derivado inmutable
  readonly totalAtenciones = computed(() => this.atenciones().length);
  readonly atencionesFiltradas = computed(() => {
    const termino = this.terminoBusqueda().toLowerCase().trim();
    if (!termino) return this.atenciones();
    return this.atenciones().filter(a =>
      a.nombresPaciente.toLowerCase().includes(termino) ||
      a.cedula.includes(termino)
    );
  });
  ```
* **Separación de Flujos:** RxJS se reserva exclusivamente para flujos asíncronos y cancelables de HTTP (`Observable`). Los resultados se consumen y sincronizan con Signals en la capa de componente.

---

## 3. Tipado Estricto: Cero `any` y Contratos Epejados

* Prohibido utilizar `any`, `unknown` sin guarda o casts forzados (`as any`).
* Cada módulo de página cuenta con su archivo de contratos (`*.models.ts`) fuertemente tipado que refleja con exactitud los DTOs del backend C#:
  * `atencion-v2.models.ts`
  * `fichas-medicas.models.ts`
  * `seguimiento-dm.models.ts`
  * `validacion-certificados.models.ts`
* Las solicitudes y respuestas se tipan con interfaces específicas (ej. `RegistrarAtencionV2Solicitud`, `AtencionV2DetalleDto`).

---

## 4. Estructura Modular de Páginas (`src/app/pages/`)

1. **`acceso/`:** Control de acceso institucional con redirección y autenticación interactiva MSAL.
2. **`inicio/`:** Dashboard directivo y médico con métricas consolidadas del día.
3. **`atencion-v1/`:** Módulo clásico para atenciones ambulatorias rápidas.
4. **`atencion-v2/`:** Módulo integral de urgencias y traumatología:
   * Formulario por secciones: Datos de paciente (SIGAFI), Signos Vitales, Escala Glasgow y pupilas, Revisión de Órganos, Diagnóstico CIE-10 con autocompletado predictivo, Prescripción y Materiales.
   * Semáforo clínico en tiempo real según valores de Glasgow y signos vitales.
5. **`fichas-medicas/`:** Ficha Médica Estudiantil HU-MED-001 (antecedentes de 8 tipos, examen físico).
6. **`seguimiento-dm/`:** Evolución longitudinal y prescripción de adaptaciones académicas curriculares.
7. **`validacion-certificados/`:** Dictamen médico de reposo, cálculo de fechas y validación de ausencias.
8. **`redireccion/`:** Callback router para procesar el token OAuth de Microsoft Entra ID.

---

## 5. Capa Core y Servicios Centrales (`src/app/core/`)

* **`configuracion.ts`:** Carga asíncrona de `public/config.json` en el bootstrap con fallback automático seguro para desarrollo local (`http://localhost:5000/api`).
* **`autenticacion.ts`:** Estado de sesión del usuario con Signals, gestión de claims institucionales y token Bearer.
* **`api.servicio.ts`:** Cliente HTTP base con tipado genérico (`get<T>`, `post<T>`, `put<T>`, `delete<T>`), manejo de cabeceras de autorización y captura de errores RFC 7807 (`ProblemDetails`).
* **`tema.servicio.ts`:** Selector reactivo de tema Claro/Oscuro con persistencia en `localStorage` y aplicación de clase CSS en el elemento raíz del DOM.

---

## 6. Normativa de Diseño UI/UX Institucional y Fluent 2

* **Paleta Oficial ISTPET:**
  * Primario: `--color-navy` (`#1B2A4A`) y `--color-navy-dark` (`#101A2E`).
  * Secundario / Acento: `--color-secondary` (`#C59B27`) y `--color-secondary-light` (`#FDFAF0`).
* **Semáforo Clínico Universal:**
  * Éxito / Normal: `#107C41` (`--color-success`).
  * Alerta / Precaución: `#D83B01` (`--color-warning`).
  * Peligro / Crítico: `#C42B1C` (`--color-danger`).
  * Informativo: `#0F6CBD` (`--color-info`).
* **Accesibilidad (WCAG 2.1 AA):** Ratios de contraste garantizados >= 4.5:1 para texto normal y >= 3:1 para controles UI. Navegación por teclado completa con anillos de foco visibles.
* **Componentes Compartidos (`src/app/shared/components/`):**
  * `button`, `icon-button`, `add-button`
  * `card`, `modal`, `drawer`, `layout` (`header`, `navbar`)
  * `input`, `datepicker`, `select-search`
  * `badge`, `alert`, `spinner`, `toast`

---

## 7. Pruebas Unitarias con Vitest

* Configuración moderna en `vite.config.mts` / `vitest.config.ts` sobre entorno simulado `jsdom`.
* Cobertura de lógica de componentes, servicios de API y transformaciones de modelos.
* Comandos:
  ```powershell
  # Ejecutar suite de pruebas en una sola pasada
  npm test -- --watch=false

  # Ejecutar con análisis de cobertura de código
  npm test -- --coverage
  ```
