# Changelog

Todos los cambios relevantes de Agente Q se registran en este archivo.

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/) y versionado semántico:
- **MAJOR**: cambios que rompen el contrato entre agentes (rutas o estructura de documentos, nombres de agentes).
- **MINOR**: nuevas capacidades compatibles (nuevas verificaciones, nuevos agentes o skills).
- **PATCH**: ajustes de redacción o correcciones que no cambian el comportamiento esperado.

Cuando cambies la versión, actualízala también en `VERSION` y en `skills/q-context/SKILL.md`.

## [Planificado]
- `q-review` (1.1.0): revisión de código independiente con veredicto, trazabilidad contra el análisis de impacto y modo de corrección de observaciones en `q-implement`.

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
