Import-Module sqlps -DisableNameChecking

$databaseName = "payroll_compare"
$restoreFrom = join-path (Get-Location) "payroll-before.bak"
$serverPath = "SQLSERVER:\SQL\localhost\Default"

if(Test-Path (join-path $serverPath "Databases\$databaseName"))
{
	Invoke-SqlCmd "Drop database $databaseName"
}
Invoke-SqlCmd "Create database $databaseName"


# Restore with relocating log files (yes I know it's painful)
# Huge props to this [link](http://www.morgantechspace.com/2014/11/Powershell-script-to-Backup-and-Restore-SQL-Database.html) for the following restore script:

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SMO") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoExtended") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.SmoEnum") | Out-Null

[Microsoft.SqlServer.Management.Smo.Server]$server = New-Object ("Microsoft.SqlServer.Management.Smo.Server") "(local)"
$backupDevice = New-Object ("Microsoft.SqlServer.Management.Smo.BackupDeviceItem") ($restoreFrom, "File")
$smoRestore = New-Object Microsoft.SqlServer.Management.Smo.Restore

$smoRestore.NoRecovery = $false;
$smoRestore.ReplaceDatabase = $true;
$smoRestore.Action = "Database"
$smoRestore.PercentCompleteNotification = 10;
$smoRestore.FileNumber = 0
$smoRestore.Devices.Add($backupDevice)

# Get the details from the backup device for the database name and output that
$smoRestoreDetails = $smoRestore.ReadBackupHeader($server)
$smoRestore.Database = $databaseName

$dbLogicalName = ""
$logLogicalName = ""

$logicalFileNameList = $smoRestore.ReadFileList($server)
foreach($row in $logicalFileNameList)
{ 
   #$smoRestore.Database = $smoRestoreDetails.Rows[0]["DatabaseName"]

   $fileType = $row["Type"].ToUpper()
   if ($fileType.Equals("D")) 
   {
      $dbLogicalName = $row["LogicalName"]
      $smoRestoreFile = New-Object("Microsoft.SqlServer.Management.Smo.RelocateFile") 
      $smoRestoreFile.LogicalFileName = $dbLogicalName
      $smoRestoreFile.PhysicalFileName = $server.Information.MasterDBPath + "\" + $databaseName + "_Data.mdf"
      $smoRestoreFile
      $smoRestore.RelocateFiles.Add($smoRestoreFile)
   }
   elseif ($fileType.Equals("L")) 
   {
      $logLogicalName = $row["LogicalName"]
      $smoRestoreLog = New-Object("Microsoft.SqlServer.Management.Smo.RelocateFile")
      $smoRestoreLog.LogicalFileName = $logLogicalName
      $smoRestoreLog.PhysicalFileName = $server.Information.MasterDBPath + "\" + $databaseName + "_Log.ldf"
      $smoRestoreLog
      $smoRestore.RelocateFiles.Add($smoRestoreLog)
   }
}

$server.KillAllProcesses($databaseName)
$smoRestore.SqlRestore($server)