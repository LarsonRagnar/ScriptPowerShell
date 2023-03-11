$appPoolName = "DCD_WS"

while ($true) {
    # Получаем информацию о состоянии пула приложений
    $appPool = Get-WebAppPoolState -Name $appPoolName

    # Если пул приложений остановлен
    if ($appPool.Value -ne "Started") {
        # Выводим сообщение о том, что пул приложений остановлен
        Write-Host "Пул приложений $appPoolName остановлен. Будет выполнен перезапуск."

        # Запускаем пул приложений
        Start-WebAppPool -Name $appPoolName

        # Выводим сообщение о том, что пул приложений перезапущен
        Write-Host "Пул приложений $appPoolName перезапущен."
    }

    # Ждем 60 секунд перед повторной проверкой состояния пула приложений
    Start-Sleep -Minutes 10
}