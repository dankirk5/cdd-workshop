Import-Module sqlps -DisableNameChecking

$databaseName = "Green"
$restoreFrom = join-path (Get-Location) "$databaseName.bak"
$serverPath = "SQLSERVER:\SQL\localhost\Default"

Restore-SqlDatabase -Path $serverPath -Database $databaseName -BackupFile $restoreFrom