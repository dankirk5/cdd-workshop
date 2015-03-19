Import-Module sqlps -DisableNameChecking

$databaseName = "payroll"
$restoreFrom = join-path (Get-Location) "$databaseName-after.bak"
$serverPath = "SQLSERVER:\SQL\localhost\Default"

Restore-SqlDatabase -Path $serverPath -Database $databaseName -BackupFile $restoreFrom -ReplaceDatabase