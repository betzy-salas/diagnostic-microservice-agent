# Changelog

Todos los cambios relevantes de Agente Q se registran en este archivo.

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/) y versionado semántico:
- **MAJOR**: cambios que rompen el contrato entre agentes (rutas o estructura de documentos, nombres de agentes).
- **MINOR**: nuevas capacidades compatibles (nuevas verificaciones, nuevos agentes o skills).
- **PATCH**: ajustes de redacción o correcciones que no cambian el comportamiento esperado.

Cuando cambies la versión, actualízala también en `VERSION` y en `skills/q-context/SKILL.md`.

## [Planificado]
- `q-review` (1.1.0): revisión de código independiente con veredicto, trazabilidad contra el análisis de impacto y modo de corrección de observaciones en `q-implement`.

## [1.0.3] - 2026-11-23
### Corregido
- Los agentes escribían los documentos de memoria, sin abrir la plantilla, y el resultado no coincidía exactamente (títulos abreviados, columnas faltantes). Ahora `q-diagnose`, `q-impact` y `q-implement` crean cada documento copiando la plantilla completa, indican qué plantilla abrieron y, antes de guardar, comparan títulos, orden y columnas con ella.
- Si no pueden abrir la plantilla, se detienen y piden la ruta en vez de improvisar la estructura.

## [1.0.2] - 2026-11-23
### Corregido
- `q-diagnose` y `q-impact` no podían guardar el documento cuando la carpeta `docs/ia/<ID-JIRA>/` no existía (sus herramientas solo crean archivos en carpetas existentes y no tienen terminal). Ahora verifican la carpeta, intentan crearla y, si no pueden, le dan al usuario el comando exacto para crearla y esperan.
- `q-implement` crea la carpeta de la historia desde la terminal si no existe.

## [1.0.1] - 2026-11-23
### Corregido
- Los agentes buscaban las skills dentro del microservicio y no las encontraban. Ahora cada agente sabe que las skills están en la carpeta de usuario de Copilot (`~/.copilot/skills/`) y las lee directamente desde ahí si Copilot no se las entrega.

## [1.0.0] - 2026-11-23
Primera versión de **Agente Q, con licencia para evolucionar**: agentes de GitHub Copilot para evolucionar microservicios Java existentes (Spring Boot o Quarkus). Complementa a Agente 007, que crea microservicios nuevos.

### Agentes
- `agent-q`: punto de entrada. Decide el siguiente paso, delega el diagnóstico y el análisis de impacto como subagentes, controla los gates de aprobación y ofrece el comando `estado`.
- `q-diagnose`: diagnóstico técnico y funcional del microservicio (solo lectura), con inventario de datos, hallazgos y diagramas de componentes, clases y secuencia.
- `q-impact`: análisis de impacto de una historia a nivel de clase y método (solo lectura), con alternativas, riesgos, plan de pruebas y diagrama de clases del cambio.
- `q-implement`: implementación en la rama `feature/<ID-JIRA>` con pruebas, compilación y TODO de lo no resuelto. Se detiene a pedir confirmación en cada etapa clave y nunca hace push.

### Skills compartidas
- `q-context`: parámetros del entorno (base de datos compartida, repositorio de esquemas, ramas, commits, build, TODO), datos sensibles, rutas y estados de documentos.
- `q-templates`: plantillas de diagnóstico, impacto e informe de implementación.
- `q-diagrams`: reglas para diagramas Mermaid.
- `q-standards`: espacio para estándares del equipo (vacío por defecto).

### Funcionamiento
- Documentos en `docs/ia/` del microservicio, agrupados por historia en `docs/ia/<ID-JIRA>/`.
- Estados de documento (`Borrador`, `Aprobado`, `Bloqueado`): `q-implement` solo trabaja sobre análisis aprobados.
- Protección contra prompt injection: el contenido del repositorio se trata como datos, no como instrucciones.
- Instaladores `install.ps1` (Windows) e `install.sh` (Mac / Linux).
