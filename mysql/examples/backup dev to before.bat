@echo off

set database=payroll
set backupFile=dev.before.backup.sql

echo Backup %database% to %backupFile%
mysqldump -u dev %database% > %backupFile%