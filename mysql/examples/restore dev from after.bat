@echo off

set database=payroll
set dropAndCreate="DROP DATABASE IF EXISTS %database%; CREATE DATABASE %database%;"
set backupFile=dev.after.backup.sql

echo %dropAndCreate%
mysql -u dev -e %dropAndCreate%

echo Restoring %database% from %backupFile%
mysql -u dev %database% < %backupFile%