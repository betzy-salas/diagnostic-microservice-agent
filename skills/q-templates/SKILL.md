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

Las rutas son relativas a la carpeta de esta skill. Ruta completa habitual: `~/.copilot/skills/q-templates/templates/` (Windows: `C:\Users\<usuario>\.copilot\skills\q-templates\templates\`). No están dentro del microservicio.

## Reglas de uso
1. **Abre la plantilla con la herramienta de lectura y crea el documento copiando su contenido completo**; después rellena cada sección. Nunca la escribas de memoria: aunque creas conocer la estructura, los títulos y columnas exactos importan porque otros agentes leen el documento.
2. Completa la cabecera YAML de la plantilla. `version-kit` es la versión indicada en la skill `q-context`. `fecha` en formato `AAAA-MM-DD`.
3. El texto entre `<...>` y los comentarios `<!-- ... -->` son instrucciones: reemplázalos con contenido real y elimina los comentarios.
4. Si una sección no aplica, déjala con el texto `No aplica` y una línea explicando por qué. No borres secciones.
5. Toda afirmación sobre el código debe citar evidencia: `ruta/Archivo.java` y, cuando aplique, `Clase#metodo` o línea.
6. Marca lo no verificable como **[Supuesto]** o **[No determinable]**.
7. Los diagramas siguen la skill `q-diagrams`.
8. **Antes de guardar**, compara tu documento con la plantilla: títulos de sección, orden y columnas de las tablas deben coincidir exactamente.
9. Si no puedes abrir la plantilla, no improvises la estructura: avisa al usuario y pide la ruta correcta.
