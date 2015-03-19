Import-Module sqlps -DisableNameChecking

$databaseName = "payroll_compare"
$serverPath = "SQLSERVER:\SQL\localhost\Default"

$server = Get-Item $serverPath

# todo drop database if exists
Invoke-SqlCmd "Drop database $databaseName"
Invoke-SqlCmd "Create database $databaseName"

