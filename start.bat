@echo off
REM Insurance Management System - Pearl Holding Group
echo ---------------------------------------------
echo Insurance Management System
echo Pearl Holding Group
echo ---------------------------------------------
echo.

REM Check Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js is not installed!
    echo Please install Node.js from: https://nodejs.org/
    pause
    exit /b 1
)
echo Node.js is installed
echo.

echo Select run mode:
echo 1. Run Backend only
echo 2. Run Frontend only
echo 3. Run both Backend and Frontend (recommended)
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" goto backend
if "%choice%"=="2" goto frontend
if "%choice%"=="3" goto both
echo Invalid choice!
pause
exit /b 1

:backend
echo Starting Backend...
cd backend
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
)
call npm run dev
goto end

:frontend
echo Starting Frontend...
cd frontend
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
)
call npm start
goto end

:both
echo Starting both Backend and Frontend...
if not exist "backend\node_modules" (
    echo Installing backend dependencies...
    cd backend
    call npm install
    cd ..
)
if not exist "frontend\node_modules" (
    echo Installing frontend dependencies...
    cd frontend
    call npm install
    cd ..
)
echo Starting Backend in new window...
start "Backend - Insurance System" cmd /k "cd backend && npm run dev"
timeout /t 3 /nobreak >nul
echo Starting Frontend...
cd frontend
call npm start
goto end

:end
echo.
echo System is running!
echo Frontend: http://localhost:3000
echo Backend:  http://localhost:5000
echo.
echo Press Ctrl+C to stop
pause

echo Node.js đã được cài đặt
echo.
REM Check Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo Node.js is not installed!
    echo Please install Node.js from: https://nodejs.org/
    pause
    exit /b 1
)
echo Node.js is installed
echo.

echo Select run mode:
echo 1. Run Backend only
echo 2. Run Frontend only
echo 3. Run both Backend and Frontend (recommended)
echo.
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" goto backend
if "%choice%"=="2" goto frontend
if "%choice%"=="3" goto both
echo Invalid choice!
pause
exit /b 1

goto end
:backend
echo Starting Backend...
cd backend
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
)
call npm run dev
goto end

goto end
:frontend
echo Starting Frontend...
cd frontend
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
)
call npm start
goto end

echo.
echo He thong dang chay!
echo Frontend: http://localhost:3000
echo Backend:  http://localhost:5000
echo.
echo Nhấn Ctrl+C để dừng
pause
:both
echo Starting both Backend and Frontend...

REM Install dependencies if needed
if not exist "backend\node_modules" (
    echo Installing backend dependencies...
    cd backend
    call npm install
    cd ..
)

if not exist "frontend\node_modules" (
    echo Installing frontend dependencies...
    cd frontend
    call npm install
    cd ..
)

REM Start backend in new window
echo Starting Backend...
start "Backend - Insurance System" cmd /k "cd backend && npm run dev"

REM Wait 3 seconds
timeout /t 3 /nobreak >nul

REM Start frontend in current window
echo Starting Frontend...
cd frontend
call npm start

:end
echo.
echo System is running!
echo Frontend: http://localhost:3000
echo Backend:  http://localhost:5000
echo.
echo Press Ctrl+C to stop
pause
