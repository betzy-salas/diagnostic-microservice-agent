# Arquitecto de Microservicio Java — Agente para GitHub Copilot

Agente personalizado de GitHub Copilot que analiza microservicios Java (Spring Boot o Quarkus) en dos modos:

| Modo | Para qué sirve | Resultado |
|---|---|---|
| **Diagnóstico** | Análisis técnico y funcional completo del microservicio: arquitectura, reglas de negocio, almacenes de datos (relacional compartida, NoSQL, Redis), seguridad, observabilidad, hallazgos y mejoras, diagramas de componentes, **clases** y secuencia. | `docs/diagnostico-microservicio.md` |
| **Impacto** | Dado un requerimiento, identifica qué clases y métodos modificar, qué clases crear, cambios de datos, riesgos y plan de pruebas. Incluye diagrama de clases del cambio. **No escribe código.** | `docs/impacto-<requerimiento>.md` |

El agente solo lee el código y escribe dentro de la carpeta `docs/` del microservicio. Nunca modifica código fuente, configuración, pruebas ni el repositorio de esquemas.

---

## Contenido de este repositorio

```
copilot-agents/
├── diagnostic-microservice-ja.agent.md   ← el agente (este es el archivo que usa Copilot)
└── README.md                             ← esta guía
```

El único archivo necesario para que el agente funcione es **`diagnostic-microservice-ja.agent.md`**. Debe terminar en `.agent.md`.

---

## Instalación (una sola vez por computador)

El agente se instala a nivel de usuario, así queda disponible en **todos** los microservicios que abras, sin copiarlo en cada repositorio.

Copilot busca los agentes de usuario en esta carpeta:

| Sistema | Carpeta |
|---|---|
| Windows | `C:\Users\<tu-usuario>\.copilot\agents\` |
| Mac / Linux | `~/.copilot/agents/` |

### Opción A — Clonar este repositorio directamente en la carpeta (recomendado)

Abre una terminal (en VS Code: **Terminal → New Terminal**) y ejecuta:

**Windows (PowerShell)**
```powershell
git clone https://github.com/<tu-usuario>/copilot-agents.git "$env:USERPROFILE\.copilot\agents"
```

**Mac / Linux**
```bash
git clone https://github.com/<tu-usuario>/copilot-agents.git ~/.copilot/agents
```

> Si la carpeta `agents` ya existe con contenido, el clon falla. Mueve ese contenido a otro lugar, borra la carpeta y vuelve a ejecutar el comando.

### Opción B — Si ya clonaste el repositorio en otra carpeta

1. Mueve la carpeta clonada (`copilot-agents`) dentro de `.copilot`.
2. Cámbiale el nombre a `agents`.

La ruta final debe ser:
```
C:\Users\<tu-usuario>\.copilot\agents\diagnostic-microservice-ja.agent.md
```

> En Windows, activa **Vista → Mostrar → Extensiones de nombre de archivo** para confirmar que el archivo no quedó como `.agent.md.txt`.

### Activar

1. Cierra VS Code por completo y vuelve a abrirlo (o `Ctrl + Shift + P` → **Developer: Reload Window**).
2. Abre un microservicio y el chat de Copilot (`Ctrl + Alt + I`).
3. En el selector de agentes (debajo de la caja de texto, donde dice Agent / Ask / Plan) debe aparecer **Arquitecto de Microservicio Java**.

### Si no aparece

- Verifica la ruta y la extensión del archivo.
- Actualiza VS Code y la extensión **GitHub Copilot Chat**.
- Alternativa: `Ctrl + Shift + P` → **Chat: New Custom Agent** → ubicación **User Data** → pega el contenido del archivo y guarda.

---

## Uso

1. Abre en VS Code la carpeta del microservicio que quieres analizar.
2. Abre el chat de Copilot y selecciona **Arquitecto de Microservicio Java**.
3. Recomendado: elige un modelo capaz en el selector de modelos (por ejemplo, Claude Sonnet). Los modelos pequeños exploran menos el código.
4. Cuando el agente vaya a crear archivos en `docs/`, Copilot pedirá permiso: acéptalo.

### Modo 1 — Diagnóstico

Ejecútalo primero en cada microservicio. Puedes escribir simplemente:

```
diagnóstico
```

O con más contexto:

```
Realiza el diagnóstico técnico y funcional completo de este microservicio.

Contexto adicional (opcional):
- Propósito de negocio que conozco: [ej. apertura de cuentas para clientes YAPE]
- Áreas en las que quiero que profundices: [ej. uso de Redis, transacciones, integraciones externas]
- Dudas o problemas conocidos: [ej. lentitud en la consulta de saldos]
```

**Resultado:** `docs/diagnostico-microservicio.md` con resumen ejecutivo, ficha técnica, diagnóstico funcional y técnico, inventario de datos, diagramas de componentes, clases y secuencia, hallazgos priorizados, preguntas abiertas e índice de ubicación.

**Consejos**
- Si ya existe un diagnóstico, el agente lo actualiza. Para empezar de cero: *"Haz el diagnóstico desde cero, ignora el documento existente"*.
- En servicios grandes, pídelo por partes: *"Haz el diagnóstico funcional"* y luego *"Ahora el diagnóstico técnico"*.
- Si una sección queda superficial: *"Profundiza en el inventario de datos"* o *"Genera el diagrama de clases del modelo de dominio con todas las relaciones"*.

### Modo 2 — Análisis de impacto de un requerimiento

Requiere que exista el diagnóstico (si no existe, el agente te ofrece hacerlo primero). Puedes seguir en el mismo chat o abrir uno nuevo.

**Prompt para el Modo Impacto:**

```
Analiza el impacto de este requerimiento en el microservicio y dime qué clases modificar y cuáles crear.

Título: [nombre corto del requerimiento]

Descripción:
[Qué se necesita y para qué, en lenguaje de negocio]

Criterios de aceptación:
- [Criterio 1]
- [Criterio 2]

Reglas de negocio:
- [Regla 1]

Contratos o integraciones involucradas (si aplica):
- [Endpoint, evento, tabla o servicio externo]

Restricciones (si aplica):
- [Compatibilidad hacia atrás, normativa, plazos, etc.]
```

**Resultado:** `docs/impacto-<requerimiento>.md` con:
- Preguntas abiertas y supuestos
- Mapa de impacto por capa
- Árbol de archivos afectados (`[MODIFICAR]` / `[NUEVO]`)
- Ficha por clase: ruta, métodos a modificar con su firma, clases nuevas con paquete y firmas
- Cambios de datos (repositorio de esquemas, expand/contract, cache)
- Diagrama de clases del cambio (nuevas en verde, modificadas en amarillo) y diagrama de secuencia
- Riesgos, plan de pruebas, orden de implementación y complejidad

**Consejos**
- Mientras más concretos los criterios de aceptación, más precisa la lista de clases.
- Si conoces el endpoint o flujo afectado, nómbralo (ej. *"afecta el POST /cuentas/apertura"*).
- Si el agente hace preguntas por ambigüedades, respóndelas en el mismo chat para que continúe.
- Para profundizar: *"Para el punto 3, abre la clase y dame las firmas de los métodos a modificar"*.

---

## Contexto de base de datos

El agente asume el patrón **database shared** con los esquemas en un repositorio aparte:
- No reporta como hallazgo la ausencia de migraciones en el microservicio.
- Los cambios de esquema los propone en el **repositorio de esquemas**, con estrategia compatible hacia atrás.
- Las conclusiones sobre la estructura real de la base se marcan como **[Supuesto]**.

**Opcional:** si abres el repositorio de esquemas junto al microservicio (**File → Add Folder to Workspace**), el agente lo usa para validar tablas, columnas e índices contra el código.

---

## Ver los diagramas

Los diagramas están en formato Mermaid dentro de los `.md`. Se visualizan:
- En GitHub o Azure DevOps al abrir el archivo.
- En VS Code con la vista previa de Markdown (`Ctrl + Shift + V`); si no se renderizan, instala la extensión **Markdown Preview Mermaid Support**.

---

## Actualizar el agente

1. Edita `diagnostic-microservice-ja.agent.md` en GitHub (ícono del lápiz) y haz **Commit changes**.
2. En cada computador:

**Windows (PowerShell)**
```powershell
cd "$env:USERPROFILE\.copilot\agents"
git pull
```

**Mac / Linux**
```bash
cd ~/.copilot/agents && git pull
```

3. En VS Code: `Ctrl + Shift + P` → **Developer: Reload Window**.

Se recomienda subir la carpeta `docs/` de cada microservicio a su repositorio, para que el equipo no tenga que regenerar el diagnóstico.
