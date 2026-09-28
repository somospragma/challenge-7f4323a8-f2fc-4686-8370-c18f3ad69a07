# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Comprendiendo los servicios de nube: PaaS, IaaS y SaaS**.

| | |
|---|---|
| Tema | fundamentos de cloud computing |
| Nivel | senior-l2 |
| Chapter | Ciencia de Datos — Analista |
| Especialidad | Analista de datos |
| Stack | Google Looker Studio / Arquitectura de datos en la nube |
| Patron arquitectonico | Análisis de modelos de servicio cloud con enfoque en arquitecturas de datos |
| Tiempo estimado | 2 horas |

## Receta del stack

Esqueleto obligatorio:

- `consultas/*.sql`
- `analisis/eda.ipynb`
- `diccionario-de-metricas.csv`
- `tablero.md`

Dependencias:

- Google Looker Studio n/a
- Google Analytics 4 n/a
- AWS Redshift n/a
- Azure Blob Storage n/a

## Tu tarea

Dejar este conjunto de artefactos en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `python3 -c "import json,glob; [json.load(open(f)) for f in glob.glob('**/*.ipynb', recursive=True)]"` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `python3 -c "import json,glob; [json.load(open(f)) for f in glob.glob('**/*.ipynb', recursive=True)]"` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Exploración de conceptos**: Compendio de las diferencias, ventajas y limitaciones de PaaS, IaaS y SaaS.
- **Fase 2 — Aplicación en arquitecturas de datos**: Arquitectura de datos en la nube diseñada con PaaS, IaaS y SaaS, incluyendo justificación y posibles desafíos.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

No se detectaron huecos: estan los archivos declarados, el boilerplate del stack y ninguna referencia quedo colgando. Igual corre el comando de verificacion — que los archivos existan no garantiza que compilen.

### Presentes (10)

- `consultas/metricas.sql`
- `analisis/eda_cloud.ipynb`
- `documentos/modelo_arquitectura_datos.md`
- `diccionario-de-metricas.csv`
- `tablero.md`
- `consultas/metricas_cloud.sql`
- `documentos/diccionario_metricas_cloud.csv`
- `documentos/comparativa_paas_iaas_saas.md`
- `documentos/tablero_cloud.md`
- `documentos/desafios_arquitectura.md`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `consultas`
- `analisis`
- `documentos`

## Verificacion

```bash
python3 -c "import json,glob; [json.load(open(f)) for f in glob.glob('**/*.ipynb', recursive=True)]"
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **Análisis de modelos de servicio cloud con enfoque en arquitecturas de datos**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Ciencia de Datos, Especialidad Analista de Datos, Seniority Senior
- Brecha que el reto ataca: Entiende los conceptos básicos que componen la nube y los tipos de servicios como PaaS, IaaS y SaaS. Comprende las diferencias fundamentales entre estos modelos de servicio en cloud, sus casos de uso, ventajas y limitaciones
- Mision: Candidato con seniority Senior, trabajando en ciencia de datos, necesita fortalecer su base en conceptos cloud fundamentales para aplicarlos en arquitecturas de datos en la nube

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
