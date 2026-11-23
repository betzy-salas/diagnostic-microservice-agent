---
documento: diagnostico
microservicio: <nombre del microservicio>
estado: Borrador
fecha: <AAAA-MM-DD>
version-kit: <versión>
commit-analizado: <hash corto del commit analizado, si se conoce>
---

# Diagnóstico del microservicio <nombre>

## 1. Resumen ejecutivo
<!-- Máximo 10 líneas: qué es, estado general y los 3 hallazgos principales. -->

## 2. Ficha técnica
| Aspecto | Valor | Evidencia |
|---|---|---|
| Framework y versión | | |
| Versión de Java | | |
| Build | | |
| Estilo de arquitectura | | |
| Base de datos relacional | | |
| NoSQL | | |
| Cache | | |
| Mensajería | | |
| Despliegue | | |

## 3. Diagnóstico funcional
### 3.1 Propósito del servicio
### 3.2 Capacidades expuestas
| Tipo (REST/evento/job) | Operación | Entrada | Salida | Códigos | Propósito de negocio | Clase |
|---|---|---|---|---|---|---|
### 3.3 Reglas de negocio
| Regla | Dónde vive | Observación (dispersa/duplicada/en SQL) |
|---|---|---|
### 3.4 Flujos principales
### 3.5 Modelo de dominio
### 3.6 Datos sensibles

## 4. Diagnóstico técnico
### 4.1 Arquitectura y fronteras
### 4.2 Integraciones
| Sistema | Cliente | Timeouts | Reintentos | Circuit breaker | Manejo de errores |
|---|---|---|---|---|---|
### 4.3 Almacenes de datos
#### Base de datos relacional (compartida)
#### NoSQL
#### Redis / cache
### 4.4 Configuración
### 4.5 Seguridad
### 4.6 Resiliencia y concurrencia
### 4.7 Observabilidad
### 4.8 Manejo de errores
### 4.9 Testing
### 4.10 Despliegue

## 5. Inventario de datos
| Almacén | Esquema / colección / patrón de clave | Tabla o entidad | Lectura/Escritura | Clase o repositorio | ¿Posiblemente compartida? | Observaciones |
|---|---|---|---|---|---|---|

## 6. Mapa de componentes
<!-- Diagrama Mermaid según q-diagrams. -->

## 7. Diagramas de clases
### 7.1 Modelo de dominio
### 7.2 Arquitectura por flujo
### 7.3 Modelo de persistencia

## 8. Diagramas de secuencia de los flujos principales

## 9. Hallazgos priorizados
| ID | Hallazgo | Evidencia | Severidad (Alta/Media/Baja) | Recomendación |
|---|---|---|---|---|

## 10. Preguntas abiertas para el equipo

## 11. Índice de ubicación
<!-- Usado por q-impact para saber dónde buscar. -->
| Capacidad de negocio | Punto de entrada | Clases de aplicación y dominio | Adaptadores / repositorios | Pruebas existentes |
|---|---|---|---|---|
