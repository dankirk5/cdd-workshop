## Getting mysql setup locally

1. Install mysql [dev.mysql.com](dev.mysql.com)
	- Including workbench
	- Also available via chocolatey
		- `choco install mysql` root user has blank password
		- `choco install mysql.workbench`
	- Know your root password to access your local mysql server
	- Validate
		- connect to local mysql server via `mysql` command line
		- connect to local mysql server via workbench
2. Configuring a user with global permissions in mysql
	- `mysql -u root -p`
	- `CREATE USER 'dev'@'localhost';`
	- Validate with `mysql -u dev`	

## Installing flyway

Java based database migration tool

1. Install jre or jdk
	- [http://java.com/en/download/](http://java.com/en/download/)
	- Or, `choco install jre8`
	- Validate with command line `java -version`
2. Download flyway [http://flywaydb.org](http://flywaydb.org)
	- Zip file download

## Getting MSSQL setup locally

1. Install MSSQL Dev Edition or Express (2012 or 2014)
2. Setup network access to SQL server
	- SQL Server Configuration Manager (program)
		- left pane
		- SQL Server Network Configuration -> Protocols for MSSQLSERVER -> TCP/IP -> Enable this
	- Restart-Service MSSQLSERVER
3. Add a user to connect to MSSQL server
	- Open SSMS.
	- Connect to your local MSSQL server.
	- Under Security -> Logins, right click and choose New Login
		- Set the name to flyway (or whatever you would like)
		- Set the auth type to SQL Server authentication
		- Set a password and remember it
		- Uncheck user must change password at next login
		- Under Server Roles in the left pane, select sysadmin server role
	- Save the new user
4. For comparisons, we'll use SSDT in Visual Studio 2013. If you have VS 2013, update your Sql Server data tools before you come. If not, you can use another diff tool or work with someone else during the portion of the workshop on schema comparisons.