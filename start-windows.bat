@echo off
cd /d "%~dp0"
if not exist ".env" (
  copy ".env.example" ".env" >nul
  echo.
  echo A new .env file has been created.
  echo Add your OpenAI API key, save the file, then run this script again.
  notepad ".env"
  pause
  exit /b 0
)
if not exist "node_modules" (
  echo Installing dependencies...
  call npm install
  if errorlevel 1 (
    pause
    exit /b 1
  )
)
echo Starting Gold & Forex Intelligence V2...
call npm start
pause
