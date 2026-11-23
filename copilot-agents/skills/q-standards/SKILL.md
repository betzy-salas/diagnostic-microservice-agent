---
name: q-standards
description: 'Estándares de arquitectura y código del equipo u organización para microservicios Java (convenciones, lineamientos de arquitectura, reglas de code review, contratos). Úsala al diagnosticar, analizar impacto o implementar código para verificar el cumplimiento de estándares propios.'
user-invocable: false
---

# Estándares del equipo

**Estado: sin estándares cargados.**

Mientras esta sección diga "sin estándares cargados", los agentes aplican solo buenas prácticas generales y las convenciones que observen en el propio código del microservicio. No reportan hallazgos de "incumplimiento de estándares".

## Cómo cargar estándares (cuando el equipo o la organización lo decida)
1. Cambia el estado a **"estándares cargados"** e indica la versión y la fuente (por ejemplo, la página de Confluence de origen y su fecha).
2. Agrega las reglas en las secciones de abajo, una por línea, con un identificador estable (por ejemplo `ARQ-01`), para que los hallazgos puedan citarlas.
3. Si las reglas son extensas, sepáralas en archivos dentro de esta carpeta (por ejemplo `arquitectura.md`, `code-review.md`) y enlázalos aquí.

## Reglas para los agentes cuando haya estándares cargados
- **q-diagnose**: verifica el cumplimiento y reporta cada incumplimiento como hallazgo de categoría "Estándares", citando el identificador de la regla.
- **q-impact**: propone cambios que cumplan los estándares y advierte si el requerimiento obliga a desviarse de alguno.
- **q-implement**: implementa cumpliendo los estándares; si no puede cumplir alguno, lo deja como TODO y lo informa.

## Arquitectura
<!-- ARQ-01: ... -->

## Código y convenciones
<!-- COD-01: ... -->

## APIs y contratos
<!-- API-01: ... -->

## Seguridad
<!-- SEG-01: ... -->

## Pruebas
<!-- PRU-01: ... -->
