# Especificación del Tablero: Arquitectura de Datos en la Nube

## Audiencia
Este tablero está dirigido a arquitectos de datos, equipos de DevOps y gerentes de finanzas que necesitan monitorear el rendimiento, costos y escalabilidad de las soluciones cloud implementadas. También es relevante para equipos de desarrollo que buscan optimizar el uso de recursos en la nube.

## Preguntas de Negocio que Responde
1. **¿Cuál es el costo total de propiedad (TCO) de nuestras soluciones cloud y cómo se distribuye entre PaaS, IaaS y SaaS?**
2. **¿Cómo varía el rendimiento de procesamiento (queries/seg) entre diferentes modelos de servicio cloud?**
3. **¿Cuál es la latencia promedio de nuestras consultas en bases de datos cloud y cómo impacta en la experiencia del usuario?**
4. **¿Estamos optimizando el uso de recursos en la nube para reducir costos sin afectar el rendimiento?**
5. **¿Cómo se comporta la escalabilidad horizontal en nuestros servicios cloud bajo diferentes cargas de trabajo?**
6. **¿Cuál es el costo asociado al almacenamiento y transferencia de datos en la nube?**
7. **¿Qué tan consistentes son nuestros datos en réplicas distribuidas y cómo afecta esto a la toma de decisiones?**

## Estructura del Tablero

### Sección 1: Visión General de Costos
**Objetivo:** Proporcionar una vista consolidada de los costos asociados a los servicios cloud.

- **Visual 1: Distribución de Costos por Modelo de Servicio**
  - **Tipo:** Gráfico de pastel.
  - **Métrica:** Costo Total de Propiedad (TCO).
  - **Propósito:** Mostrar la proporción de costos entre PaaS, IaaS y SaaS.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Costo Total de Propiedad).
  - **Ejemplo:**
    - PaaS: 45% ($54,000/año)
    - IaaS: 35% ($42,000/año)
    - SaaS: 20% ($24,000/año)

- **Visual 2: Costo por Query vs. Latencia**
  - **Tipo:** Gráfico de dispersión.
  - **Métricas:** Costo por Query (eje Y) y Latencia de Consulta (eje X).
  - **Propósito:** Identificar la relación entre el costo y el rendimiento de las consultas.
  - **Fuente:** `diccionario-de-metricas.csv` (Métricas: Costo por Query, Latencia de Consulta).
  - **Ejemplo:**
    - Consultas con latencia > 200 ms tienen un costo promedio de $0.0008.

### Sección 2: Rendimiento y Escalabilidad
**Objetivo:** Evaluar el rendimiento y la capacidad de escalabilidad de los servicios cloud.

- **Visual 3: Rendimiento de Procesamiento por Modelo de Servicio**
  - **Tipo:** Gráfico de barras.
  - **Métrica:** Queries/seg.
  - **Propósito:** Comparar el rendimiento de procesamiento entre PaaS, IaaS y SaaS.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Rendimiento de Procesamiento).
  - **Ejemplo:**
    - PaaS (Redshift): 150 queries/seg
    - IaaS (EC2 + PostgreSQL): 80 queries/seg
    - SaaS (Google BigQuery): 200 queries/seg

- **Visual 4: Escalabilidad Horizontal**
  - **Tipo:** Gráfico de líneas.
  - **Métrica:** Número de nodos vs. Rendimiento (queries/seg).
  - **Propósito:** Analizar cómo escala el rendimiento al aumentar nodos en PaaS.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Escalabilidad Horizontal).
  - **Ejemplo:**
    - 1 nodo: 50 queries/seg
    - 3 nodos: 150 queries/seg
    - 5 nodos: 250 queries/seg

### Sección 3: Almacenamiento y Transferencia de Datos
**Objetivo:** Monitorear los costos y eficiencia en el almacenamiento y transferencia de datos.

- **Visual 5: Costo de Almacenamiento por GB**
  - **Tipo:** Gráfico de barras.
  - **Métrica:** Costo de Almacenamiento por GB.
  - **Propósito:** Comparar costos de almacenamiento entre diferentes proveedores y modelos de servicio.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Costo de Almacenamiento por GB).
  - **Ejemplo:**
    - AWS S3: $0.023/GB
    - Azure Blob Storage: $0.02/GB
    - Google Cloud Storage: $0.02/GB

- **Visual 6: Costo de Transferencia de Datos**
  - **Tipo:** Gráfico de líneas.
  - **Métrica:** Costo de Transferencia de Datos.
  - **Propósito:** Analizar cómo varía el costo de transferencia de datos entre regiones y servicios.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Costo de Transferencia de Datos).
  - **Ejemplo:**
    - Transferencia dentro de la misma región: $0.01/GB
    - Transferencia entre regiones: $0.02/GB

### Sección 4: Disponibilidad y Consistencia
**Objetivo:** Evaluar la disponibilidad y consistencia de los datos en entornos cloud.

- **Visual 7: Disponibilidad del Servicio**
  - **Tipo:** Tabla.
  - **Métrica:** Disponibilidad del Servicio.
  - **Propósito:** Mostrar la disponibilidad de los servicios cloud en los últimos 12 meses.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Disponibilidad del Servicio).
  - **Ejemplo:**
    | Servicio               | Disponibilidad |
    |-----------------------|----------------|
    | AWS Redshift          | 99.95%         |
    | Azure SQL Database    | 99.99%         |
    | Google BigQuery       | 99.98%         |

- **Visual 8: Consistencia de Datos**
  - **Tipo:** Gráfico de barras.
  - **Métrica:** Consistencia de Datos.
  - **Propósito:** Evaluar la consistencia de los datos en réplicas distribuidas.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Consistencia de Datos).
  - **Ejemplo:**
    - Réplica 1: 99.9%
    - Réplica 2: 99.8%
    - Réplica 3: 99.9%

### Sección 5: Tiempo de Implementación
**Objetivo:** Analizar el tiempo requerido para implementar soluciones cloud.

- **Visual 9: Tiempo de Implementación por Modelo de Servicio**
  - **Tipo:** Gráfico de barras.
  - **Métrica:** Tiempo de Implementación.
  - **Propósito:** Comparar el tiempo de implementación entre PaaS, IaaS y SaaS.
  - **Fuente:** `diccionario-de-metricas.csv` (Métrica: Tiempo de Implementación).
  - **Ejemplo:**
    - PaaS (Redshift): 15 días
    - IaaS (EC2 + PostgreSQL): 30 días
    - SaaS (Google BigQuery): 5 días

## Conclusiones Esperadas
1. **Optimización de Costos:** Identificar oportunidades para reducir costos sin afectar el rendimiento, como migrar de IaaS a PaaS en servicios de bases de datos.
2. **Mejora de Rendimiento:** Evaluar si el rendimiento actual justifica el costo asociado y proponer ajustes en la arquitectura.
3. **Escalabilidad:** Analizar si los servicios actuales pueden escalar eficientemente bajo cargas de trabajo variables.
4. **Consistencia y Disponibilidad:** Garantizar que la consistencia y disponibilidad de los datos cumplan con los SLAs establecidos.

## Recomendaciones para el Diseño en Google Looker Studio
- Usar **filtros dinámicos** para permitir a los usuarios seleccionar modelos de servicio (PaaS, IaaS, SaaS) y rangos de fechas.
- Incluir **indicadores clave (KPIs)** en la parte superior del tablero para resaltar métricas críticas como TCO, latencia promedio y disponibilidad.
- Utilizar **gráficos interactivos** que permitan a los usuarios hacer clic en elementos para filtrar datos en otras visualizaciones.
- Asegurar que **todas las métricas estén vinculadas** al `diccionario-de-metricas.csv` para mantener la trazabilidad y actualización automática.