@echo off

set database=payroll_compare
set dropAndCreate="DROP DATABASE IF EXISTS %database%; CREATE DATABASE %database%;"
set backupFile=dev.before.backup.sql

echo %dropAndCreate%
mysql -u dev -e %dropAndCreate%

echo Restoring %database% from %backupFile%
mysql -u dev %database% < %backupFile%