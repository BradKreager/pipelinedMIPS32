@echo off
cmd /k "cd /d %~dp0 && vivado -mode batch -source project.tcl && exit"
