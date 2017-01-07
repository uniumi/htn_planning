@echo off
set run_dir=%~dp0
pushd %run_dir%
ruby ./field_exec.rb
pause
