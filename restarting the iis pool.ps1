$poolName = "имя_пула"
$serverName = "имя_сервера"

$iis = [ADSI]"IIS://$serverName/W3SVC/AppPools"
$pool = $iis.psbase.children | where {$_.psbase.SchemaClassName -eq "IIsApplicationPool" -and $_.Name -eq $poolName}

if ($pool -eq $null) {
    Write-Host "Пул приложения не найден."
} else {
    if ($pool.psbase.InvokeGet("AppPoolState") -ne 2) {
        Write-Host "Пул приложения $poolName не запущен. Запуск пула..."
        $pool.psbase.Invoke("Start", $null)
    } else {
        Write-Host "Пул приложения $poolName уже запущен."
    }
}
