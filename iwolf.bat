@echo off

@pushd %~dp0
if NOT ["%errorlevel%"]==["0"] pause

cmd.exe /k cscript iwolf2.vbs

