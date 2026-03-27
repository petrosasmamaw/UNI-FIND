@echo off
REM UNIFIND Project Setup Helper Script for Windows
REM Run this script to setup the entire project

echo.
echo ========================================
echo  UNIFIND Setup Helper - Windows Edition
echo ========================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Node.js is not installed or not in PATH
    echo Please install Node.js 18+ from https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js %NODE_VERSION% found
node --version

REM Setup Backend
echo.
echo Checking Backend Setup...
cd backend

if not exist ".env" (
    echo [ERROR] .env file not found in backend/
    echo Please create backend\.env with the following variables:
    echo PORT=5000
    echo MONGO_URI=your_mongodb_connection_string
    echo CLOUDINARY_CLOUD_NAME=your_cloud_name
    echo CLOUDINARY_API_KEY=your_api_key
    echo CLOUDINARY_API_SECRET=your_api_secret
    cd ..
    pause
    exit /b 1
)

echo [OK] .env file found
echo.
echo Installing backend dependencies...
call npm install

echo [OK] Backend dependencies installed
cd ..

REM Setup Frontend
echo.
echo Checking Frontend Setup...
cd FrontendFindItems

if not exist ".env.local" (
    echo [INFO] .env.local not found. Creating with defaults...
    (
        echo NEXT_PUBLIC_API_URL=http://localhost:5000
        echo NEXT_PUBLIC_AUTH_BASE_URL=http://localhost:3000
        echo DATABASE_URL=postgresql://postgres:password@localhost:5432/unifind
        echo BETTER_AUTH_SECRET=change-this-to-random-string-in-production
    ) > .env.local
    echo [OK] Created .env.local
    echo [WARNING] Please update .env.local with your actual database and auth credentials
)

echo.
echo Installing frontend dependencies...
call npm install

echo.
echo Generating Prisma client...
call npx prisma generate

echo [OK] Frontend dependencies installed
cd ..

echo.
echo ===========================================
echo [SUCCESS] Setup complete!
echo ===========================================
echo.
echo Next steps:
echo 1. Update backend\.env with your MongoDB and Cloudinary credentials
echo 2. Update FrontendFindItems\.env.local with database URL and BETTER_AUTH_SECRET
echo 3. Setup PostgreSQL and create database: psql -U postgres -c "CREATE DATABASE unifind;"
echo 4. Run Prisma migrations: cd FrontendFindItems ^&^& npx prisma migrate dev
echo.
echo To start development:
echo   Terminal 1 (Backend): cd backend ^&^& npm run dev
echo   Terminal 2 (Frontend): cd FrontendFindItems ^&^& npm run dev
echo.
echo Open http://localhost:3000 in your browser
echo.
pause
