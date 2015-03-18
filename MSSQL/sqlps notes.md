## sqlps module in MSSQL 2012

Things to try out:

- Load with `Import-Module sqlps -DisableNameChecking`
- See available commands with `Get-Command -Module sqlps`
- List contents with `dir SQLSERVER:`, can cd through dbs :)
	- use localhost to generically refer to a local machine so scripts aren't coupled to machine name

Here's a cheat sheet for using sqlps [http://www.simple-talk.com/content/file.ashx?file=7234](http://www.simple-talk.com/content/file.ashx?file=7234)
- sqlps provides a powershell interface to much of SMO, you'll see SMO objects coming back

Commands that help with database changes:

- `Invoke-SqlCmd` - invoking arbitrary sql commands and queries from posh
	- Might be good to alias as sql: `New-Alias sql Invoke-SqlCmd`
	- Try `sql "select * from cars" -Database Green` obviously replace with a valid query for a database on your machine
- `Backup-SqlDatabase`
	- Corresponds closely to SMO's Backup class
	- `-BackupFile` specify location of backup file
	- `Restore-SqlDatabase`
		- Drop a database: `sql "Drop database Green"`
	- For examples `help Backup-SqlDatabase -examples`
- `Get-SqlDatabase`
	- `$database = Get-SqlDatabase -Path SQLSERVER:\SQL\localhost\Default $databaseName`
	- To show everything about database: 
		- Show all members and values: `$database | Format-List *`
		- Show list of members without values: `$database | get-member`