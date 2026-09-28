-- =============================================
-- Consulta: Costo Total de Propiedad (TCO) por Modelo de Servicio
-- Descripción: Calcula el costo total asociado a cada modelo de servicio (PaaS, IaaS, SaaS)
-- Métrica: Costo Total de Propiedad (TCO)
-- Fuente: Facturas de AWS/Azure/GCP y herramientas de monitoreo de costos
-- =============================================
SELECT
    modelo_servicio,
    SUM(costo_directo) AS costo_directo_total,
    SUM(costo_indirecto) AS costo_indirecto_total,
    SUM(costo_directo + costo_indirecto) AS tco
FROM costos_cloud
GROUP BY modelo_servicio
ORDER BY tco DESC;

-- =============================================
-- Consulta: Rendimiento de Procesamiento (Queries/seg) por Modelo de Servicio
-- Descripción: Calcula el número de consultas ejecutadas por segundo en cada modelo de servicio
-- Métrica: Queries/seg
-- Fuente: Logs de AWS Redshift y Azure SQL Database
-- =============================================
SELECT
    modelo_servicio,
    COUNT(*) AS total_consultas,
    EXTRACT(EPOCH FROM (MAX(timestamp) - MIN(timestamp))) AS tiempo_total_segundos,
    COUNT(*) / EXTRACT(EPOCH FROM (MAX(timestamp) - MIN(timestamp))) AS queries_por_segundo
FROM logs_consultas
GROUP BY modelo_servicio
ORDER BY queries_por_segundo DESC;

-- =============================================
-- Consulta: Latencia Promedio de Consultas
-- Descripción: Calcula el tiempo promedio que tarda una consulta en ejecutarse
-- Métrica: Latencia de Consulta
-- Fuente: Logs de AWS Redshift y Azure SQL Database
-- =============================================
SELECT
    modelo_servicio,
    AVG(tiempo_ejecucion_ms) AS latencia_promedio_ms
FROM logs_consultas
GROUP BY modelo_servicio
ORDER BY latencia_promedio_ms DESC;

-- =============================================
-- Consulta: Costo por Query
-- Descripción: Calcula el costo promedio asociado a la ejecución de cada consulta
-- Métrica: Costo por Query
-- Fuente: Facturas de AWS/Azure/GCP y logs de consultas
-- =============================================
SELECT
    modelo_servicio,
    SUM(costo_total_servicio) / COUNT(*) AS costo_por_query
FROM (
    SELECT
        c.modelo_servicio,
        c.costo_total_servicio,
        COUNT(*) AS total_consultas
    FROM costos_servicios c
    JOIN logs_consultas l ON c.servicio = l.servicio
    GROUP BY c.modelo_servicio, c.costo_total_servicio
) AS subquery
GROUP BY modelo_servicio
ORDER BY costo_por_query DESC;

-- =============================================
-- Consulta: Disponibilidad del Servicio
-- Descripción: Calcula el porcentaje de tiempo que el servicio está disponible
-- Métrica: Disponibilidad del Servicio
-- Fuente: Herramientas de monitoreo (CloudWatch, Azure Monitor)
-- =============================================
SELECT
    servicio,
    modelo_servicio,
    SUM(tiempo_total) - SUM(tiempo_inactividad) AS tiempo_disponible,
    SUM(tiempo_total) AS tiempo_total,
    (SUM(tiempo_total) - SUM(tiempo_inactividad)) / SUM(tiempo_total) * 100 AS disponibilidad
FROM disponibilidad_servicios
GROUP BY servicio, modelo_servicio
ORDER BY disponibilidad DESC;

-- =============================================
-- Consulta: Escalabilidad Horizontal (Número de Nodos vs. Rendimiento)
-- Descripción: Analiza cómo escala el rendimiento al aumentar nodos en PaaS
-- Métrica: Escalabilidad Horizontal
-- Fuente: Documentación técnica y pruebas de carga
-- =============================================
SELECT
    numero_nodos,
    AVG(rendimiento_queries_seg) AS rendimiento_promedio
FROM escalabilidad_horizontal
GROUP BY numero_nodos
ORDER BY numero_nodos;

-- =============================================
-- Consulta: Costo de Almacenamiento por GB
-- Descripción: Calcula el costo asociado al almacenamiento de datos por cada GB
-- Métrica: Costo de Almacenamiento por GB
-- Fuente: Facturas de AWS/Azure/GCP
-- =============================================
SELECT
    proveedor,
    modelo_servicio,
    SUM(costo_total) / SUM(capacidad_gb) AS costo_por_gb
FROM costos_almacenamiento
GROUP BY proveedor, modelo_servicio
ORDER BY costo_por_gb;

-- =============================================
-- Consulta: Costo de Transferencia de Datos
-- Descripción: Calcula el costo asociado a la transferencia de datos entre servicios cloud
-- Métrica: Costo de Transferencia de Datos
-- Fuente: Facturas de AWS/Azure/GCP
-- =============================================
SELECT
    tipo_transferencia,
    SUM(datos_transferidos_gb) AS total_datos_gb,
    SUM(costo_total) AS costo_total,
    SUM(costo_total) / SUM(datos_transferidos_gb) AS costo_por_gb
FROM costos_transferencia
GROUP BY tipo_transferencia
ORDER BY costo_total DESC;

-- =============================================
-- Consulta: Uso de CPU por Instancia
-- Descripción: Calcula el porcentaje de uso de CPU en instancias cloud
-- Métrica: Uso de CPU
-- Fuente: CloudWatch, Azure Monitor
-- =============================================
SELECT
    instancia,
    modelo_servicio,
    AVG(uso_cpu) AS uso_promedio_cpu
FROM uso_recursos
WHERE recurso = 'CPU'
GROUP BY instancia, modelo_servicio
ORDER BY uso_promedio_cpu DESC;

-- =============================================
-- Consulta: Consistencia de Datos en Réplicas
-- Descripción: Calcula el porcentaje de registros consistentes en réplicas de bases de datos
-- Métrica: Consistencia de Datos
-- Fuente: Logs de replicación y herramientas de monitoreo
-- =============================================
SELECT
    replica,
    COUNT(*) AS total_registros,
    SUM(CASE WHEN es_consistente THEN 1 ELSE 0 END) AS registros_consistentes,
    SUM(CASE WHEN es_consistente THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS consistencia
FROM consistencia_datos
GROUP BY replica
ORDER BY consistencia DESC;

-- =============================================
-- Consulta: Tiempo de Implementación por Modelo de Servicio
-- Descripción: Calcula el tiempo requerido para implementar una solución cloud
-- Métrica: Tiempo de Implementación
-- Fuente: Herramientas de gestión de proyectos (Jira, Azure DevOps)
-- =============================================
SELECT
    proyecto,
    modelo_servicio,
    EXTRACT(DAY FROM (fecha_fin - fecha_inicio)) AS tiempo_implementacion_dias
FROM proyectos_implementacion
ORDER BY tiempo_implementacion_dias DESC;