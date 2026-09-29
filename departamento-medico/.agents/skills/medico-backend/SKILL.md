---
name: medico-backend
description: Guía técnica exhaustiva del backend .NET 8 Clean Architecture del Departamento Médico ISTPET (Dominio, Casos de Uso, MySQL Pomelo EF Core, 39 Tablas, Sigafi y WebApi).
---

# Skill: Backend - Departamento Médico ISTPET (.NET 8 Clean Architecture)

Esta skill define la arquitectura oficial, patrones de diseño, estándares de codificación senior y directrices de persistencia para el desarrollo en `departamento_medico_istpet`. Prohíbe terminantemente parches temporales, casts forzados o consultas ineficientes.

---

## 1. Arquitectura de Software y Separación Estricta de Capas

El backend opera bajo una Clean Architecture pura en .NET 8 (C# Latest, `<Nullable>enable</Nullable>`):

```
src/
├── Istpet.DepartamentoMedico.Domain/          # Núcleo puro (Entidades, VO, Reglas de negocio, Cero dependencias)
├── Istpet.DepartamentoMedico.Application/     # Casos de uso, interfaces, DTOs inmutables, Result Pattern
├── Istpet.DepartamentoMedico.Infrastructure/  # EF Core, Pomelo MySQL, Sigafi, Repositorios, UnitOfWork
└── Istpet.DepartamentoMedico.WebApi/          # Composition Root, Controladores REST, ProblemDetails, HealthChecks
```

### Reglas de Dependencia Inviolables
1. **`Domain` (Agnóstico):** No referencia paquetes externos, ORMs, frameworks de serialización ni utilidades HTTP. Utiliza lenguaje ubicuo en español. Las invariantes de negocio se protegen dentro de las entidades y Value Objects.
2. **`Application` (Orquestación):** Depende exclusivamente de `Domain`. Define contratos (`Abstracciones/`) y casos de uso atómicos. No conoce controladores ni Entity Framework Core.
3. **`Infrastructure` (Adaptadores):** Implementa las interfaces de `Application`. Gestiona `DepartamentoMedicoDbContext`, mapeos Fluent API, consultas a `Sigafi` y `IUnidadDeTrabajo`.
4. **`WebApi` (Anfitrión HTTP):** Conecta las dependencias (`AgregarInfraestructura`, `AgregarCasosDeUso`). Mapea DTOs y devuelve respuestas REST estandarizadas con códigos HTTP semánticos.

---

## 2. Patrones de Diseño Senior en Dominio y Aplicación

### 2.1. Entidades Encapsuladas y Métodos Factoría
* **Constructores Protegidos/Privados:** Las entidades no exponen constructores públicos vacíos que permitan estados inconsistentes.
* **Métodos Factoría Estáticos:** Toda creación de entidad se realiza a través de un método estático `.Crear(...)` que valida parámetros obligatorios y asigna valores por defecto consistentes:
  ```csharp
  // Ejemplo del estándar implementado en MFIA_FICHA_ATEN y MFIC_FICHAS:
  public static MFIA_FICHA_ATEN Crear(
      long fichaId,
      string codigoFicha,
      string? motivo,
      string? tipoFicha,
      string? tipoEvento,
      string? enfermedadActual,
      string? interrogatorio,
      string? alergias,
      string? planTratamiento,
      string? procedimiento,
      sbyte activo)
  {
      return new MFIA_FICHA_ATEN
      {
          MFIA_ID = fichaId,
          MFIA_CODIGO = codigoFicha,
          MFIA_MOTIVO = motivo,
          MFIA_TIPO_FICHA = tipoFicha ?? "Atención Médica",
          MFIA_ACTIVO = activo
      };
  }
  ```

### 2.2. Casos de Uso Atómicos y Comandos Inmutables
* **Comandos y Resultados:** Definidos como `sealed record` inmutables.
* **Primary Constructors:** Inyección de dependencias directa y concisa:
  ```csharp
  public sealed class RegistrarAtencionMedica(
      IRepositorioAtenciones atenciones,
      IUnidadDeTrabajo unidadDeTrabajo)
  {
      public async Task<Resultado<AtencionRegistrada>> EjecutarAsync(
          RegistrarAtencionComando comando,
          CancellationToken cancelacion = default)
      {
          ArgumentNullException.ThrowIfNull(comando);
          if (string.IsNullOrWhiteSpace(comando.Motivo))
          {
              return Resultado<AtencionRegistrada>.Fallo("El motivo de la atención médica es obligatorio.");
          }
          // Lógica de dominio, agregados y persistencia...
      }
  }
  ```
* **Patrón Resultado Funcional (`Resultado<T>`):** Prohibido usar excepciones para control de flujo de negocio predecible. El método retorna `Resultado<T>.Exito(valor)` o `Resultado<T>.Fallo(mensajeError)`.

### 2.3. Transaccionalidad y Unidad de Trabajo (`IUnidadDeTrabajo`)
* Las operaciones que modifican múltiples tablas (ej. ficha médica + constantes vitales + diagnóstico + trauma) se coordinan en un agregado o repositorio y se confirman atómicamente con `await unidadDeTrabajo.GuardarCambiosAsync(cancelacion)`.
* Prohibido realizar múltiples `SaveChangesAsync` parciales que dejen la base de datos en estado corrupto ante una falla intermedia.

---

## 3. Modelo de Persistencia: 39 Tablas MySQL

Base de datos: MySQL 8.0 con `Pomelo.EntityFrameworkCore.MySql`.

### 3.1. Inventario Categorizado
1. **Núcleo de Atención Médica (Urgencias / Trauma):**
   * `MFIC_FICHAS`: Ficha raíz de registro clínico.
   * `MFIA_FICHA_ATEN`: Cabecera de atención médica.
   * `MFCO_FICH_CONST` & `MCON_CONSTAN_VI`: Constantes vitales (presión, FC, FR, Temp, SatO2, Glucosa).
   * `MGLA_ESCALA_GLASGOW`: Evaluación neurológica (apertura ocular, respuesta verbal, respuesta motora) y evaluación pupilar.
   * `MTRA_TRAUMA`: Registro de cinemática de trauma y tipos de lesión.
   * `MMAT_MATERIAL`: Materiales y fármacos administrados en la atención.
   * `MENT_ENTREGA_PACIENTE`: Trazabilidad de entrega a unidades de salud de mayor complejidad.
2. **Fichas Médicas Estudiantiles (HU-MED-001):**
   * `MFICH_FICHA_MEDICA`: Encabezado de ficha institucional.
   * `MAME_ANTECE_MED`: Catálogo maestro de 8 tipos de antecedentes patológicos.
   * `MAND_ANTECE_DET`: Detalle de antecedentes positivos del estudiante.
   * `MREV_REVISION_O`: Revisión de órganos y sistemas.
3. **Seguimiento Clínico y Adaptaciones:**
   * `MSEG_SEGUIMIENTO`: Historial de citas de evolución.
   * `MADA_ADAPTA`: Adaptaciones curriculares prescritas.
   * `MTAD_TIPO_ADAPTACION`: Catálogo de tipos de adaptación académica.
4. **Validaciones de Certificados:**
   * `MVAL_VALIDACION`: Registro y dictamen de certificados de reposo médico.
5. **Estudiantes y Trazabilidad LOPDP:**
   * `Estudiantes`: Registro local por cédula para anonimización y soberanía clínica.

### 3.2. Mapeo y Consultas Eficientes
* Configuración explícita mediante Fluent API en `Infrastructure/Persistencia/Configuraciones/`.
* **Prohibido:** `AsEnumerable()` o `.ToList()` prematuro para filtrar en memoria. Las consultas se componen con `IQueryable`, proyecciones `.Select()` a DTOs específicos y `.AsNoTracking()` en operaciones de solo lectura.

---

## 4. WebApi: Controladores REST y ProblemDetails RFC 7807

### 4.1. Estructura de Controladores
* Controladores delgados (Thin Controllers): Su única responsabilidad es recibir la solicitud HTTP, validar el modelo de entrada, invocar el Caso de Uso correspondiente y mapear el `Resultado<T>` al código HTTP semántico:
  * Éxito con recurso creado: `201 Created` (`CreatedAtAction` o cabecera `Location`).
  * Éxito con datos: `200 OK`.
  * Éxito sin contenido: `204 NoContent`.
  * Fallo de validación de negocio: `400 BadRequest` con ProblemDetails.
  * No encontrado: `404 NotFound`.
  * Conflicto de concurrencia/estado: `409 Conflict`.

### 4.2. Manejador Global de Excepciones
* Implementación de `IExceptionHandler` (`ManejadorDeExcepciones.cs`) registrado con `AddProblemDetails()`.
* Respuestas de error estandarizadas con `title`, `detail`, `status`, `instance` y `errors` (diccionario de validación).

### 4.3. HealthChecks en Kubernetes
* `/health/live`: Verifica que el proceso esté respondiendo. No hace llamadas a base de datos.
* `/health/ready`: Ejecuta `ChequeoDeBaseDeDatos` (MySQL) para asegurar que el pod puede recibir tráfico real.

---

## 5. Integración con SIGAFI

* `ConnectionStrings:Sigafi`: Acceso de solo lectura al padrón estudiantil institucional.
* Búsqueda por cédula con caché en memoria o consulta indexada para no sobrecargar el sistema académico.
* Minimización de datos: solo se consultan nombres, apellidos, carrera y matrícula vigente.

---

## 6. Comandos de Compilación y Calidad

```powershell
# Compilación determinista
dotnet build

# Ejecución en puerto local 5000
dotnet run --project src/Istpet.DepartamentoMedico.WebApi

# Pruebas unitarias e integración en Release
dotnet test --configuration Release

# Migraciones en Kubernetes (Job)
dotnet ef migrations add <NombreMigracion> `
  -p src/Istpet.DepartamentoMedico.Infrastructure `
  -s src/Istpet.DepartamentoMedico.WebApi
```
