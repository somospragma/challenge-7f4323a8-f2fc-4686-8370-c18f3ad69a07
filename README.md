# Comprendiendo los servicios de nube: PaaS, IaaS y SaaS

Como analista de datos sénior, necesitas entender los modelos de servicios de nube para diseñar arquitecturas de datos eficientes. Explorarás los conceptos de PaaS, IaaS y SaaS, identificando sus diferencias, ventajas y limitaciones.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | fundamentos de cloud computing |
| **Nivel** | senior-l2 |
| **Tipo** | theoretical |
| **Tiempo estimado** | 2 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración de conceptos

**Objetivo:** Entender los modelos de servicios de nube

**Tiempo estimado:** 45 minutos

**Instrucciones:**

- Investiga y compara los modelos de servicio PaaS, IaaS y SaaS.
- Identifica las diferencias fundamentales entre estos modelos.
- Enumera las ventajas y limitaciones de cada uno.

**Entregable:** Compendio de las diferencias, ventajas y limitaciones de PaaS, IaaS y SaaS.

<details>
<summary>Pistas de conocimiento</summary>

- Considera casos de uso reales para cada modelo de servicio.
- Piensa en cómo cada modelo puede ser aplicado en diferentes escenarios de datos.

</details>

### Fase 2: Aplicación en arquitecturas de datos

**Objetivo:** Aplicar conocimientos de servicios de nube en arquitecturas de datos

**Tiempo estimado:** 1 hora 15 minutos

**Instrucciones:**

- Diseña una arquitectura de datos en la nube utilizando PaaS, IaaS y SaaS.
- Justifica tus elecciones basándote en las ventajas y limitaciones de cada modelo.
- Identifica posibles desafíos y cómo los abordarías.

**Entregable:** Arquitectura de datos en la nube diseñada con PaaS, IaaS y SaaS, incluyendo justificación y posibles desafíos.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la escalabilidad, la seguridad y el costo en tu diseño.
- Piensa en cómo cada modelo puede afectar la eficiencia y el rendimiento de tu arquitectura.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué son PaaS, IaaS y SaaS y cuáles son sus diferencias?
- **paraQueSirve**: ¿En qué escenarios se aplican PaaS, IaaS y SaaS?
- **erroresComunes**: ¿Cuáles son los errores comunes al elegir un modelo de servicio de nube?
- **comoSeUsa**: ¿Cómo se aplican PaaS, IaaS y SaaS en una arquitectura de datos?
- **queDecisionesImplica**: ¿Qué decisiones implica elegir entre PaaS, IaaS y SaaS en una arquitectura de datos?

## Criterios de Evaluacion

- Comprensión clara de los modelos de servicio de nube PaaS, IaaS y SaaS.
- Identificación de las diferencias, ventajas y limitaciones de cada modelo.
- Diseño de una arquitectura de datos en la nube utilizando los modelos de servicio adecuados.
- Justificación de las elecciones basada en las características de cada modelo.
- Identificación de posibles desafíos y propuestas para abordarlos.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
python3 -c "import json,glob; [json.load(open(f)) for f in glob.glob('**/*.ipynb', recursive=True)]"
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
