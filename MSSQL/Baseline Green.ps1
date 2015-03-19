Import-Module sqlps -DisableNameChecking

$databaseName = "Green"
$serverPath = "SQLSERVER:\SQL\localhost\Default"

function baseline($serverPath, $databaseName)
{
	$server = Get-Item $serverPath
	$database = Get-SqlDatabase -Path $serverPath $databaseName
	$scriptTo = join-path (Get-Location) "V001__baseline $databaseName.sql"

	$scripter = new-object("Microsoft.SqlServer.Management.Smo.Scripter")($server)
	$scripter.Options.AppendToFile = $False
	$scripter.Options.ToFileOnly = $True
	$scripter.Options.FileName = $scriptTo
	$scripter.Options.AllowSystemObjects = $False
	$scripter.Options.WithDependencies = $True
	$scripter.Options.Triggers = $True
	$scripter.Options.DriAll = $True
	$scripter.Options.Statistics = $False

	$objectsToScript = $database.Tables + $database.Views + $database.StoredProcedures + $database.UserDefinedFunctions

	$scripter.Script([Microsoft.SqlServer.Management.Smo.SqlSmoObject[]]($objectsToScript))

	# Notes:
	# Don't script out create database statement, just structures, that way you can create a new database from scratch with any database name	
}

baseline $serverPath $databaseName