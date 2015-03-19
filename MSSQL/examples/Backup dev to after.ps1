Import-Module sqlps -DisableNameChecking

$databaseName = "payroll"
$backupTo = join-path (Get-Location) "$databaseName-after.bak"
$serverPath = "SQLSERVER:\SQL\localhost\Default"

Backup-SqlDatabase -Path $serverPath -Database $databaseName -BackupFile $backupTo