WITH DB_CPU_Stats
AS
(SELECT DatabaseID, DB_Name(DatabaseID) AS [DatabaseName], sql_handle,
SUM(total_worker_time) AS [CPU_Time_Ms]
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY (SELECT CONVERT(int, value) AS [DatabaseID]
FROM sys.dm_exec_plan_attributes(qs.plan_handle)
WHERE attribute = N'dbid') AS F_DB
GROUP BY DatabaseID, sql_handle
)




SELECT ROW_NUMBER() OVER(ORDER BY [CPU_Time_Ms] DESC) AS [row_num],
DatabaseName, [CPU_Time_Ms], text, count(1) as Connections,
CAST([CPU_Time_Ms] * 1.0 / SUM([CPU_Time_Ms])
OVER() * 100.0 AS DECIMAL(5, 2)) AS [CPUPercent]
FROM DB_CPU_Stats
cross apply sys.dm_exec_sql_text(sql_handle) C
join sys.dm_exec_connections CON on CON.most_recent_sql_handle = sql_handle
WHERE DatabaseID > 4 -- system databases
AND DatabaseID <> 32767 -- ResourceDB
--AND DatabaseName='SELFID'
GROUP BY CPU_Time_Ms, DatabaseName, text
ORDER BY row_num
