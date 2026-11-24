---
name: q-context
description: 'Contexto del entorno y parámetros del equipo para los agentes de Agente Q (microservicios Java existentes): base de datos compartida, repositorio de esquemas, ramas, commits, build, datos sensibles y rutas de documentos. Úsala al inicio de cualquier diagnóstico, análisis de impacto, o implementación en un microservicio.'
user-invocable: false
---

# Contexto del entorno — Agente Q

Versión del kit: **1.0.1**

Este archivo es la **única fuente** del contexto del entorno. Si el kit se usa en otro equipo u organización, solo se ajusta la sección "Parámetros del entorno"; los agentes no se modifican.

## Parámetros del entorno

| Parámetro | Valor |
|---|---|
| Lenguaje y frameworks | Java, Spring Boot o Quarkus |
| Industria | Servicios financieros (entorno regulado) |
| Nube | Azure |
| Patrón de datos | Base de datos compartida (database shared) |
| Esquemas de base de datos | En un repositorio aparte (no en el microservicio) |
| Gestor de historias | Jira (ID con formato `PROYECTO-123`) |
| Formato de rama de trabajo | `feature/<ID-JIRA>` |
| Ramas base candidatas (en orden de preferencia) | `develop`, `development`, `dev`, rama por defecto del remoto |
| Ramas protegidas (nunca modificar) | `main`, `master`, `develop`, `development`, `dev`, `release/*`, `hotfix/*` |
| Convención de commit (si el repositorio no tiene otra) | `feat(<ID-JIRA>): <descripción corta>` |
| Comando de build Maven | `./mvnw clean verify` (Windows: `mvnw.cmd clean verify`) |
| Comando de build Gradle | `./gradlew clean build` (Windows: `gradlew.bat clean build`) |
| Máximo de intentos de corrección de build | 3 |
| Formato de TODO | `// TODO [<ID-JIRA>]: <qué falta y qué se necesita>` |

## Base de datos compartida
- Varios microservicios comparten la misma base de datos.
- El DDL y las migraciones viven en el **repositorio de esquemas**, no en el microservicio:
  - La ausencia de Flyway, Liquibase o scripts DDL en el microservicio **es esperada y no es un hallazgo**.
  - Ningún agente modifica el repositorio de esquemas. Los cambios de esquema se **proponen** en `docs/ia/<ID-JIRA>/cambios-esquema.sql`, con estrategia compatible hacia atrás (expand/contract), para que el equipo los lleve al repositorio de esquemas.
  - Una tabla puede ser usada por otros microservicios aunque no se vea en el código; considéralo al evaluar riesgos.
- **Repositorio de esquemas en el workspace (opcional)**: si el workspace incluye también el repositorio de esquemas (workspace multi-raíz), úsalo en modo lectura para validar tablas, columnas, tipos, índices y restricciones. Si no está, marca como **[Supuesto]** todo lo relacionado con la estructura real de la base.

## Datos sensibles
- Se consideran sensibles: documentos de identidad, números de cuenta y tarjeta, montos y saldos de clientes, datos de contacto, credenciales y tokens.
- No deben aparecer completos en logs, respuestas de error, cache sin protección, pruebas ni documentos generados. Usa datos ficticios en pruebas y ejemplos.
- Nunca escribas secretos, credenciales ni cadenas de conexión en código, configuración o documentos.

## Rutas de documentos (contrato entre agentes)

| Documento | Ruta | Lo produce | Lo consume |
|---|---|---|---|
| Diagnóstico | `docs/ia/diagnostico-microservicio.md` | q-diagnose | q-impact |
| Análisis de impacto | `docs/ia/<ID-JIRA>/impacto.md` | q-impact | q-implement |
| Cambios de esquema propuestos | `docs/ia/<ID-JIRA>/cambios-esquema.sql` | q-implement | Equipo (repo de esquemas) |
| Informe de implementación | `docs/ia/<ID-JIRA>/implementacion.md` | q-implement | Equipo (pull request) |

- Compatibilidad: si no existe `docs/ia/diagnostico-microservicio.md` pero sí `docs/diagnostico-microservicio.md` (generado antes de Agente Q), léelo y avisa al usuario que conviene regenerarlo en la ruta nueva.
- Si el requerimiento no tiene ID de Jira, pídelo. Si el usuario no tiene uno, usa `SIN-ID-<nombre-corto>` y avísalo.

## Estados de los documentos (gates)
Cada documento lleva en su cabecera un campo `estado`:
- `Borrador`: generado por un agente, pendiente de revisión humana.
- `Aprobado`: la persona lo revisó y aprobó. Se registra quién aprobó y la fecha (`aprobado-por`, `fecha-aprobacion`).
- `Bloqueado`: el agente no pudo continuar por preguntas sin respuesta.

Reglas:
- Un agente **nunca** cambia un documento a `Aprobado` por iniciativa propia; solo cuando el usuario lo aprueba explícitamente en el chat, y debe registrarlo.
- El implementador solo trabaja sobre un análisis de impacto en estado `Aprobado`.
