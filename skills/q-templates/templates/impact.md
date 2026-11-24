---
documento: impacto
historia: <ID-JIRA>
titulo: <título corto del requerimiento>
estado: Borrador
aprobado-por:
fecha-aprobacion:
alternativa-elegida:
fecha: <AAAA-MM-DD>
version-kit: <versión>
diagnostico-base: docs/ia/diagnostico-microservicio.md
---

# Análisis de impacto <ID-JIRA> — <título>

## 1. Requerimiento y supuestos
### 1.1 Reformulación
### 1.2 Cambios funcionales
### 1.3 Clasificación
<!-- Nueva capacidad / modificación / regla de negocio / integración / datos / no funcional. -->
### 1.4 Supuestos

## 2. Preguntas abiertas
| # | Pregunta | ¿Bloquea? | Supuesto tomado mientras tanto |
|---|---|---|---|

## 3. Mapa de impacto
| Capa | ¿Afectada? | Detalle |
|---|---|---|
| Contrato expuesto (API/eventos) | | |
| Entrada (controllers, consumers, jobs) | | |
| Aplicación (casos de uso, servicios) | | |
| Dominio | | |
| Puertos y adaptadores de salida | | |
| Base de datos relacional compartida | | |
| NoSQL | | |
| Redis / cache | | |
| Configuración | | |
| Seguridad y datos sensibles | | |
| Observabilidad | | |
| Pruebas | | |

## 4. Puntos de cambio
### 4.1 Árbol de archivos afectados
```
<árbol solo con archivos afectados, cada uno con [MODIFICAR] o [NUEVO]>
```
### 4.2 Tabla resumen
| # | Repositorio | Ruta del archivo | Clase | Método(s) | Tipo (crear/modificar/eliminar) | Descripción | Criterio de aceptación |
|---|---|---|---|---|---|---|---|
### 4.3 Fichas por clase
<!--
Clase existente: ruta, capa, métodos a modificar (firma actual y cambio), métodos nuevos (firma), atributos/anotaciones/dependencias, motivo ligado a criterio.
Clase nueva: ruta y paquete, tipo, responsabilidad, firmas públicas, quién la usa, clase de referencia de estilo.
No Java: propiedades, contratos OpenAPI/AsyncAPI, objetos de BD.
Pruebas: clases de test a modificar y nuevas, con escenarios.
-->

## 5. Cambios de datos
<!-- Esquema (en repo de esquemas, expand/contract), migración de datos, NoSQL, invalidación o versionado de cache, orden de despliegue. -->

## 6. Diagrama de clases del cambio

## 7. Diagrama de secuencia del flujo resultante

## 8. Alternativas y recomendación
| Alternativa | Descripción | Ventajas | Desventajas |
|---|---|---|---|
**Recomendación:** <alternativa y motivo>

## 9. Riesgos y mitigaciones
| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|

## 10. Plan de pruebas
| Tipo | Clase de test | Escenario | Criterio de aceptación |
|---|---|---|---|

## 11. Orden sugerido de implementación

## 12. Complejidad estimada
<!-- Baja / Media / Alta, con justificación. -->
