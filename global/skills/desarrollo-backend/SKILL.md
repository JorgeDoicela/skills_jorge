---
name: desarrollo-backend
description: Activa esta skill para desarrollo backend profesional, APIs (REST, GraphQL, gRPC), arquitectura de software (Clean Architecture, Hexagonal, DDD, CQRS, Microservicios, Monolito Modular), persistencia (SQL, NoSQL, ORMs), concurrencia, resiliencia y cero parches en cualquier lenguaje (C#, TypeScript, Python, Go, Java, Rust).
---
# Directrices Universales de Desarrollo Backend e Ingeniería de Software Senior

Esta habilidad define los estándares innegociables de ingeniería de software para el desarrollo del lado del servidor, APIs y bases de datos en cualquier stack tecnológico y lenguaje de programación.

---

## 1. Mandato Innegociable: Cero Parches y Causa Raíz

* **Prohibición Absoluta de Parches:** Queda terminantemente prohibido aplicar soluciones rápidas, parches provisionales o workarounds que silencien fallos en lugar de resolver la causa raíz en su origen.
* **Antipatrones Prohibidos:**
  - **Excepciones Silenciadas:** Prohibido usar bloques `catch (Exception) {}` o `try: ... except: pass` vacíos o que solo impriman un log sin propagar o traducir el error según la capa arquitectónica.
  - **Consultas N+1 y Filtrado Ineficiente en Memoria:** Prohibido cargar colecciones completas a memoria del servidor para filtrarlas con código cuando la base de datos debe resolverlo mediante índices, joins o proyecciones.
  - **Violación de Capas:** Prohibido consultar la base de datos o ejecutar lógica de dominio directamente dentro de controladores HTTP, vistas o resolvers de GraphQL.
  - **Mutaciones Ocultas y Parámetros Mágicos:** Prohibido alterar entidades de negocio de forma encubierta o usar cadenas/números mágicos sin constantes o enums tipados.
* **Disparador `profesional` / `senior` / `sin-parches`:** Ante cualquier duda o solicitud de optimización, el agente auditará la solución completa para garantizar que la causa raíz esté resuelta con el estándar más alto de la industria.

---

## 2. Arquitecturas de Software y Separación de Capas

El backend debe estructurarse según el paradigma arquitectónico del proyecto, respetando siempre la separación de responsabilidades:

* **Clean Architecture / Hexagonal (Ports & Adapters) / Onion:**
  - **Dominio (Core):** Las entidades de negocio y reglas de dominio no dependen de ningún framework, ORM o librería externa.
  - **Aplicación / Casos de Uso:** Orquestan la lógica de negocio a través de puertos/interfaces. Cada caso de uso tiene una única responsabilidad bien definida (ej. CQRS con Commands y Queries separados).
  - **Infraestructura:** Implementa los adaptadores concretos (repositorios, clientes HTTP, colas de mensajería, bases de datos).
  - **Presentación / API:** Controladores o routers ultradelgados que solo serializan/deserializan y delegan.
* **Domain-Driven Design (DDD):**
  - Distingue claramente entre **Entidades** (con identidad única), **Value Objects** (inmutables, definidos por sus atributos) y **Agregados** (garantes de invariantes transaccionales).
* **Inversión de Dependencias (DIP):**
  - Los módulos de alto nivel nunca dependen de módulos de bajo nivel; ambos dependen de abstracciones (interfaces/traits).
  - Configura contenedores de Inyección de Dependencias con ciclos de vida apropiados (Transient, Scoped, Singleton) evitando fugas de memoria o estados compartidos no seguros para concurrencia.
* **Validación en los Bordes:**
  - Valida de forma estricta y defensiva las entradas a nivel de DTOs antes de tocar el dominio o la persistencia.

---

## 3. Persistencia de Datos, SQL y Modelado

* **Eficiencia en Consultas:**
  - Relacionales: Incluye siempre de forma explícita las relaciones requeridas (`.Include()` en EF Core, joins explícitos en SQL/TypeORM/SQLAlchemy) previniendo cargas diferidas no controladas (Lazy Loading silencioso).
  - Consultas de Solo Lectura: Usa flags de no-tracking (ej. `.AsNoTracking()` o queries sin estado) para optimizar memoria y tiempo de CPU.
  - Índices y Planes de Ejecución: Diseña tablas pensando en las consultas reales. Toda llave foránea o campo de filtro frecuente debe contar con índices adecuados.
* **Transaccionalidad y Consistencia (ACID):**
  - Operaciones que afecten múltiples entidades deben ejecutarse dentro de transacciones atómicas explícitas con políticas de rollback ante fallos.
* **Gobernanza y Migraciones:**
  - Los cambios en esquema de base de datos se versionan mediante migraciones reproducibles en código (cero cambios manuales directos en producción).
  - Distingue rigurosamente entre tablas del dominio propio (escritura) y datos o esquemas externos legados (estrictamente solo lectura).

---

## 4. Diseño de APIs y Contratos de Servicio (REST, GraphQL, gRPC)

* **REST Semántica y Predecible:**
  - Nombres en plural para recursos (`/api/pedidos`, `/api/usuarios/{id}/roles`).
  - Verbos HTTP semánticos (GET para consultas seguras, POST para creación, PUT para reemplazo completo, PATCH para actualización parcial, DELETE para borrado).
  - Códigos de estado HTTP rigurosos: `200 OK`, `201 Created`, `204 No Content`, `400 Bad Request`, `401 Unauthorized`, `403 Forbidden`, `404 Not Found`, `409 Conflict`, `422 Unprocessable Entity`.
* **Contratos Estrictos y DTOs:**
  - Prohibido exponer entidades de base de datos directamente al cliente exterior. Usa siempre DTOs/ViewModels de entrada y salida desacoplados.
* **Estándar de Errores RFC 7807 (Problem Details):**
  - Devuelve respuestas de error con formato estandarizado que incluyan tipo, título, detalle y código de estado.

---

## 5. Resiliencia, Concurrencia y Manejo Global de Errores

* **Manejo Centralizado de Excepciones:**
  - Implementa middlewares globales o filtros de excepción que capturen errores no controlados y generen respuestas homogéneas, evitando `try-catch` redundantes en controladores.
* **Logging Estructurado y Observabilidad:**
  - Usa logs con propiedades estructuradas (formato JSON con timestamps, correlación de petición `TraceId`/`RequestId` y parámetros clave), nunca interpolación simple de strings.
* **Resiliencia y Protección del Sistema:**
  - Aplica políticas de reintento con retroceso exponencial (exponential backoff con jitter), circuit breakers y timeouts estrictos ante llamadas a servicios externos.
  - Asegura la **idempotencia** en operaciones críticas (ej. pagos, procesamiento de eventos) mediante llaves de idempotencia (`Idempotency-Key`).

---

## 6. Principios SOLID y Patrones de Diseño Aplicados

* **Single Responsibility (SRP):** Clases y métodos cortos con un único motivo de cambio. Si una clase requiere más de 5-7 dependencias inyectadas, es síntoma inequívoco de sobrecarga de responsabilidades que debe refactorizarse.
* **Open/Closed (OCP):** Extensible mediante nuevas clases, interfaces o estrategias, sin alterar el código existente probado.
* **Liskov Substitution (LSP):** Subclases o implementaciones deben ser sustituibles sin alterar la corrección del programa.
* **Interface Segregation (ISP):** Interfaces pequeñas y específicas para cada consumidor.
* **Patrones GoF Aplicados con Criterio:** Repository/UnitOfWork (desacoplamiento de datos), Factory/Builder (creación compleja), Strategy (algoritmos intercambiables), Decorator/Middleware (comportamientos cruzados), CQRS (segregación de lectura y escritura). No apliques patrones por moda — úsalos cuando resuelven una necesidad real del dominio.
