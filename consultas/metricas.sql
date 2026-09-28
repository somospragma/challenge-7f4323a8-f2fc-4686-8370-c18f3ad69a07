--
-- Métricas para análisis de arquitecturas cloud (PaaS, IaaS, SaaS)
-- Objetivo: Cuantificar costos, rendimiento y escalabilidad en diferentes modelos de servicio
-- Fuente de datos: AWS Redshift (logs de uso, facturación, rendimiento)
-- Responsable: Analista de datos sénior
--

-- =============================================
-- Métrica 1: Costo total de propiedad (TCO)
-- Definición: Suma de costos directos e indirectos asociados a cada modelo de servicio
-- Fórmula: (Costo_infraestructura + Costo_operaciones + Costo_licencias) / Periodo
-- Granularidad: Mensual
-- Ventana de tiempo: Últimos 12 meses
--
CREATE OR REPLACE VIEW vw_metrica_tco_cloud AS
SELECT
    servicio_tipo,  -- 'PaaS', 'IaaS', 'SaaS'
    DATE_TRUNC('month', fecha) AS mes,
    SUM(costo_infraestructura) AS costo_infra,
    SUM(costo_operaciones) AS costo_ops,
    SUM(costo_licencias) AS costo_lic,
    SUM(costo_infraestructura + costo_operaciones + costo_licencias) AS tco_total,
    -- Desglose porcentual
    ROUND(SUM(costo_infraestructura) * 100.0 / NULLIF(SUM(costo_infraestructura + costo_operaciones + costo_licencias), 0), 2) AS pct_infra,
    ROUND(SUM(costo_operaciones) * 100.0 / NULLIF(SUM(costo_infraestructura + costo_operaciones + costo_licencias), 0), 2) AS pct_ops,
    ROUND(SUM(costo_licencias) * 100.0 / NULLIF(SUM(costo_infraestructura + costo_operaciones + costo_licencias), 0), 2) AS pct_lic
FROM costos_servicios_cloud
WHERE fecha BETWEEN DATEADD(month, -12, CURRENT_DATE) AND CURRENT_DATE
GROUP BY servicio_tipo, DATE_TRUNC('month', fecha)
ORDER BY servicio_tipo, mes;

-- =============================================
-- Métrica 2: Escalabilidad vertical vs horizontal
-- Definición: Capacidad de escalar recursos computacionales (CPU, RAM, almacenamiento)
-- Fórmula:
--   - Vertical: Máximo % de utilización de recursos en instancias únicas
--   - Horizontal: Número de instancias escaladas automáticamente
-- Granularidad: Diaria
--
CREATE OR REPLACE VIEW vw_metrica_escalabilidad AS
SELECT
    servicio_tipo,
    DATE_TRUNC('day', timestamp) AS dia,
    -- Escalabilidad vertical
    MAX(cpu_utilizacion) AS max_cpu_util,
    MAX(ram_utilizacion) AS max_ram_util,
    MAX(almacenamiento_utilizacion) AS max_storage_util,
    -- Escalabilidad horizontal
    COUNT(DISTINCT instancia_id) AS instancias_activas,
    AVG(instancias_escaladas) AS instancias_promedio
FROM metricas_rendimiento
WHERE timestamp BETWEEN DATEADD(day, -30, CURRENT_DATE) AND CURRENT_DATE
GROUP BY servicio_tipo, DATE_TRUNC('day', timestamp)
ORDER BY servicio_tipo, dia;

-- =============================================
-- Métrica 3: Tiempo de implementación
-- Definición: Días requeridos para desplegar una solución completa
-- Fórmula: Fecha_fin_despliegue - Fecha_inicio_despliegue
-- Granularidad: Por proyecto
--
CREATE OR REPLACE VIEW vw_metrica_tiempo_implementacion AS
SELECT
    proyecto_id,
    servicio_tipo,
    nombre_proyecto,
    fecha_inicio,
    fecha_fin,
    DATEDIFF(day, fecha_inicio, fecha_fin) AS dias_implementacion,
    CASE
        WHEN servicio_tipo = 'PaaS' THEN 'Medio'
        WHEN servicio_tipo = 'IaaS' THEN 'Alto'
        WHEN servicio_tipo = 'SaaS' THEN 'Bajo'
    END AS complejidad_esperada
FROM proyectos_cloud
ORDER BY dias_implementacion DESC;

-- =============================================
-- Métrica 4: Disponibilidad del servicio
-- Definición: Porcentaje de tiempo en que el servicio estuvo operativo
-- Fórmula: (Tiempo_total - Tiempo_inactividad) / Tiempo_total * 100
-- Granularidad: Mensual
--
CREATE OR REPLACE VIEW vw_metrica_disponibilidad AS
SELECT
    servicio_tipo,
    DATE_TRUNC('month', fecha) AS mes,
    SUM(tiempo_operativo) AS tiempo_operativo_total,
    SUM(tiempo_inactividad) AS tiempo_inactividad_total,
    SUM(tiempo_operativo + tiempo_inactividad) AS tiempo_total,
    ROUND(SUM(tiempo_operativo) * 100.0 / NULLIF(SUM(tiempo_operativo + tiempo_inactividad), 0), 4) AS disponibilidad_pct
FROM metricas_disponibilidad
WHERE fecha BETWEEN DATEADD(month, -12, CURRENT_DATE) AND CURRENT_DATE
GROUP BY servicio_tipo, DATE_TRUNC('month', fecha)
ORDER BY servicio_tipo, mes;

-- =============================================
-- Métrica 5: Flexibilidad de personalización
-- Definición: Capacidad de adaptar el servicio a necesidades específicas
-- Fórmula: Número de parámetros configurables / Total de parámetros disponibles
-- Granularidad: Por servicio
--
CREATE OR REPLACE VIEW vw_metrica_flexibilidad AS
SELECT
    servicio_id,
    servicio_tipo,
    nombre_servicio,
    parametros_configurables,
    parametros_totales,
    ROUND(parametros_configurables * 100.0 / NULLIF(parametros_totales, 0), 2) AS flexibilidad_pct,
    CASE
        WHEN servicio_tipo = 'PaaS' THEN 'Media'
        WHEN servicio_tipo = 'IaaS' THEN 'Alta'
        WHEN servicio_tipo = 'SaaS' THEN 'Baja'
    END AS flexibilidad_esperada
FROM servicios_cloud
ORDER BY flexibilidad_pct DESC;

-- =============================================
-- Métrica 6: Consumo de ancho de banda
-- Definición: Datos transferidos entre servicios y usuarios
-- Fórmula: Suma de datos transferidos (GB)
-- Granularidad: Diaria
--
CREATE OR REPLACE VIEW vw_metrica_ancho_banda AS
SELECT
    servicio_tipo,
    DATE_TRUNC('day', fecha) AS dia,
    SUM(datos_entrada) AS gb_entrada,
    SUM(datos_salida) AS gb_salida,
    SUM(datos_entrada + datos_salida) AS gb_total,
    -- Tendencia semanal
    AVG(SUM(datos_entrada + datos_salida)) OVER (
        PARTITION BY servicio_tipo
        ORDER BY DATE_TRUNC('day', fecha)
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS media_semanal_gb
FROM metricas_ancho_banda
WHERE fecha BETWEEN DATEADD(day, -90, CURRENT_DATE) AND CURRENT_DATE
GROUP BY servicio_tipo, DATE_TRUNC('day', fecha)
ORDER BY servicio_tipo, dia;

-- =============================================
-- Métrica 7: Cumplimiento de SLA
-- Definición: Porcentaje de métricas que cumplen con los acuerdos de nivel de servicio
-- Fórmula: (Métricas_cumplidas / Métricas_totales) * 100
-- Granularidad: Mensual
--
CREATE OR REPLACE VIEW vw_metrica_cumplimiento_sla AS
SELECT
    servicio_tipo,
    DATE_TRUNC('month', fecha) AS mes,
    COUNT(*) AS metricas_evaluadas,
    SUM(CASE WHEN cumple_sla THEN 1 ELSE 0 END) AS metricas_cumplidas,
    ROUND(SUM(CASE WHEN cumple_sla THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cumplimiento_sla_pct
FROM metricas_sla
WHERE fecha BETWEEN DATEADD(month, -12, CURRENT_DATE) AND CURRENT_DATE
GROUP BY servicio_tipo, DATE_TRUNC('month', fecha)
ORDER BY servicio_tipo, mes;

-- =============================================
-- Métrica 8: Innovación tecnológica
-- Definición: Número de nuevas características implementadas
-- Fórmula: COUNT(DISTINCT caracteristicas_nuevas)
-- Granularidad: Trimestral
--
CREATE OR REPLACE VIEW vw_metrica_innovacion AS
SELECT
    servicio_tipo,
    DATE_TRUNC('quarter', fecha) AS trimestre,
    COUNT(DISTINCT caracteristica_id) AS nuevas_caracteristicas,
    COUNT(DISTINCT CASE WHEN estado = 'implementado' THEN caracteristica_id END) AS implementadas,
    ROUND(COUNT(DISTINCT CASE WHEN estado = 'implementado' THEN caracteristica_id END) * 100.0 /
          NULLIF(COUNT(DISTINCT caracteristica_id), 0), 2) AS pct_implementadas
FROM roadmap_servicios
WHERE fecha BETWEEN DATEADD(month, -12, CURRENT_DATE) AND CURRENT_DATE
GROUP BY servicio_tipo, DATE_TRUNC('quarter', fecha)
ORDER BY servicio_tipo, trimestre;