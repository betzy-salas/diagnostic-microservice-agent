---
name: q-templates
description: 'Plantillas oficiales de los documentos que producen los agentes de Agente Q: diagnóstico de microservicio, análisis de impacto e informe de implementación. Úsala siempre antes de crear o actualizar uno de esos documentos en docs/ia/.'
user-invocable: false
---

# Plantillas de documentos de Agente Q

Cada documento que producen los agentes sigue una plantilla fija. Las plantillas son el **contrato entre agentes**: un agente produce el documento y el siguiente lo lee esperando esa estructura. No cambies el orden ni los nombres de las secciones.

| Documento | Plantilla |
|---|---|
| Diagnóstico del microservicio | [templates/diagnostic.md](templates/diagnostic.md) |
| Análisis de impacto | [templates/impact.md](templates/impact.md) |
| Informe de implementación | [templates/implementation.md](templates/implementation.md) |

## Reglas de uso
1. Lee la plantilla correspondiente **antes** de escribir el documento.
2. Completa la cabecera YAML de la plantilla. `version-kit` es la versión indicada en la skill `q-context`. `fecha` en formato `AAAA-MM-DD`.
3. El texto entre `<...>` y los comentarios `<!-- ... -->` son instrucciones: reemplázalos con contenido real y elimina los comentarios.
4. Si una sección no aplica, déjala con el texto `No aplica` y una línea explicando por qué. No borres secciones.
5. Toda afirmación sobre el código debe citar evidencia: `ruta/Archivo.java` y, cuando aplique, `Clase#metodo` o línea.
6. Marca lo no verificable como **[Supuesto]** o **[No determinable]**.
7. Los diagramas siguen la skill `q-diagrams`.
