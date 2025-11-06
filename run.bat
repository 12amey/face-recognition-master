@echo off
REM Face Recognition System - Run Script
REM Quick script to run the application

echo ========================================
echo Face Recognition System
echo ========================================
echo.

REM Check if project is built
if not exist "target\face-recognition-1.0-SNAPSHOT.jar" (
    echo Project not built yet!
    echo Building the project...
    echo.
    call mvn clean install
    if %errorlevel% neq 0 (
        echo.
        echo Build failed! Please check the error messages above.
        pause
        exit /b 1
    )
    echo.
    echo Build successful!
    echo.
)

echo Starting Face Recognition System...
echo.

REM Run the application
mvn exec:java -Dexec.mainClass="src.Main"

if %errorlevel% neq 0 (
    echo.
    echo Application failed to start!
    echo.
    echo Troubleshooting tips:
    echo   1. Ensure MySQL is running: net start MySQL80
    echo   2. Verify database exists: mysql -u root -p -e "SHOW DATABASES;"
    echo   3. Check that DLLs are copied: dir "%JAVA_HOME%\bin\*.dll"
    echo   4. See SETUP_GUIDE.md for more help
    echo.
)

pause
