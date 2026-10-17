@echo off
title MessLink Web Platform
set PORT=3001
echo ===================================================
echo   Starting MessLink Web Server at http://localhost:3001
echo ===================================================
timeout /t 1 /nobreak >nul
start "" http://localhost:3001
node src/server.js
pause
