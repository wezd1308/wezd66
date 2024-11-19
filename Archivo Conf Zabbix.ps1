# Ruta del archivo de configuración de Zabbix Agent 2
$configFilePath = "C:\Program Files\Zabbix Agent 2\zabbix_agent2.conf"

# Parámetros específicos para cada servidor (puedes adaptar esto según tus necesidades)
$hostname = $env:COMPUTERNAME
$serverIP = "cpdlzabbixproxy.industrial.com.ar"  # Cambia esto por la IP del servidor Zabbix correspondiente
$ServerActive = "cpdlzabbixproxy.industrial.com.ar:10051"

# Leer el archivo de configuración
$configFile = Get-Content -Path $configFilePath

# Editar las líneas necesarias
$configFile = $configFile -replace '^(Hostname=).*$', "Hostname=$hostname"
$configFile = $configFile -replace '^(Server=).*$', "Server=$serverIP"
$configFile = $configFile -replace '^(ServerActive=).*$', "ServerActive=$ServerActive"

# Guardar los cambios en el archivo de configuración
$configFile | Set-Content -Path $configFilePath

# Reiniciar el servicio de Zabbix Agent para aplicar los cambios
Restart-Service -Name "Zabbix Agent 2"
