---
name: q-diagrams
description: 'Reglas para generar diagramas Mermaid de microservicios Java (componentes, clases, secuencia y diagrama de clases de un cambio con clases nuevas y modificadas). Úsala cuando un documento de diagnóstico o de impacto incluya diagramas.'
user-invocable: false
---

# Reglas de diagramas Mermaid

Genera los diagramas a partir del **código real** (abre las clases; no los deduzcas por nombres). Usa sintaxis Mermaid válida dentro de bloques ```` ```mermaid ````.

## Reglas generales
- Un diagrama por vista. **Nunca** un único diagrama gigante.
- Si una vista supera 15 elementos, divídela en subdiagramas por módulo o subdominio.
- Usa los nombres reales de las clases, sin paquete. Debajo de cada diagrama de clases agrega una tabla: `Clase | Paquete | Archivo`.
- No uses caracteres especiales en los identificadores (tildes, espacios, guiones); si hace falta, usa un alias con etiqueta.
- Las anomalías que revele un diagrama (dependencias que violan capas, ciclos, clases con demasiadas dependencias, dominio que depende de infraestructura) se describen en el texto y se llevan a la tabla de hallazgos, no se dibujan como notas.

## Mapa de componentes (`flowchart LR`)
- Muestra el microservicio, sus componentes principales, sistemas externos, colas/tópicos y almacenes de datos (relacional compartida, NoSQL, Redis).
- Distingue con forma: base de datos `[(Nombre)]`, cola o tópico `[[Nombre]]`, sistema externo `{{Nombre}}`.
- Marca las tablas o almacenes posiblemente compartidos con la etiqueta "compartida".

## Diagramas de clases (`classDiagram`)
Vistas en el diagnóstico:
1. **Modelo de dominio**: entidades, agregados, value objects y enums de estado, con atributos principales (nombre y tipo) y métodos de negocio relevantes. Relaciones con cardinalidad: composición `*--`, agregación `o--`, asociación `-->` (por ejemplo `Cuenta "1" --> "*" Movimiento`).
2. **Arquitectura por flujo** (uno por flujo principal, máximo 5): controller/resource → caso de uso/servicio → puertos → adaptadores → repositorios/clientes. Implementación de interfaces `<|..`, herencia `<|--`, dependencia inyectada `..>`. Solo métodos públicos usados en el flujo.
3. **Modelo de persistencia** (si está separado del dominio): entidades JPA/Panache o documentos NoSQL, con la tabla o colección que mapean en la tabla inferior.

Notación:
- Estereotipos: `<<interface>>`, `<<abstract>>`, `<<enumeration>>`, `<<entity>>`, `<<record>>`, `<<port>>`, `<<adapter>>`, `<<service>>`, `<<controller>>`.
- Visibilidad: `+` público, `-` privado, `#` protegido.
- Omite getters, setters, `equals`, `hashCode` y `toString`.

## Diagrama de clases de un cambio (análisis de impacto)
- Incluye solo las clases afectadas y sus vecinas directas, mostrando cómo quedan **después** del cambio.
- Clases nuevas: estereotipo `<<nuevo>>` y `style NombreClase fill:#d4edda,stroke:#28a745`.
- Clases modificadas: estereotipo `<<modificado>>` y `style NombreClase fill:#fff3cd,stroke:#ffc107`.
- Clases sin cambios: sin estilo.
- Debajo, una tabla: `Clase | Estado (nuevo/modificado) | Métodos o atributos que cambian`.
- Toda clase marcada `[NUEVO]` o `[MODIFICAR]` en la tabla de puntos de cambio debe aparecer en el diagrama.

## Diagramas de secuencia (`sequenceDiagram`)
- Uno por flujo principal (máximo 5), de punta a punta: cliente → entrada → aplicación → dominio → adaptadores → almacenes/sistemas externos → respuesta.
- Incluye los caminos de error relevantes con `alt` / `else`.
- En el análisis de impacto, resalta lo nuevo o modificado con `rect rgb(212, 237, 218)` alrededor de los pasos nuevos y una nota `Note over` que indique "Nuevo" o "Modificado".
