@echo off
REM Face Recognition System - Setup Script (Batch Version)
REM Run this if you have issues with the PowerShell script

echo ========================================
echo Face Recognition System - Setup Script
echo ========================================
echo.

REM Check Java
echo [1/6] Checking Java Installation...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo   X Java not found! Please install JDK 8 or higher.
    pause
    exit /b 1
)
echo   + Java found
echo.

REM Check Maven
echo [2/6] Checking Maven Installation...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo   X Maven not found! Please install Apache Maven.
    pause
    exit /b 1
)
echo   + Maven found
echo.

REM Create lib directory
echo [3/6] Creating lib directory...
if not exist "lib" (
    mkdir lib
    echo   + lib directory created
) else (
    echo   + lib directory already exists
)
echo.

REM Download Java 3D libraries
echo [4/6] Downloading Java 3D libraries...
echo This may take a few minutes...
echo.

REM Using curl (available in Windows 10+)
if not exist "lib\j3d-core.jar" (
    echo   - Downloading j3d-core.jar...
    curl -L -o lib\j3d-core.jar https://repo1.maven.org/maven2/java3d/j3d-core/1.5.2/j3d-core-1.5.2.jar
    if %errorlevel% equ 0 (echo   + Downloaded j3d-core.jar) else (echo   X Failed to download j3d-core.jar)
) else (
    echo   + j3d-core.jar already exists
)

if not exist "lib\j3d-utils.jar" (
    echo   - Downloading j3d-utils.jar...
    curl -L -o lib\j3d-utils.jar https://repo1.maven.org/maven2/java3d/j3d-core-utils/1.5.2/j3d-core-utils-1.5.2.jar
    if %errorlevel% equ 0 (echo   + Downloaded j3d-utils.jar) else (echo   X Failed to download j3d-utils.jar)
) else (
    echo   + j3d-utils.jar already exists
)

if not exist "lib\vecmath.jar" (
    echo   - Downloading vecmath.jar...
    curl -L -o lib\vecmath.jar https://repo1.maven.org/maven2/java3d/vecmath/1.5.2/vecmath-1.5.2.jar
    if %errorlevel% equ 0 (echo   + Downloaded vecmath.jar) else (echo   X Failed to download vecmath.jar)
) else (
    echo   + vecmath.jar already exists
)

echo.

REM Download JAI libraries
echo [5/6] Downloading JAI libraries...
echo.

if not exist "lib\jai_core.jar" (
    echo   - Downloading jai_core.jar...
    curl -L -o lib\jai_core.jar https://repo1.maven.org/maven2/javax/media/jai_core/1.1.3/jai_core-1.1.3.jar
    if %errorlevel% equ 0 (echo   + Downloaded jai_core.jar) else (echo   X Failed to download jai_core.jar)
) else (
    echo   + jai_core.jar already exists
)

if not exist "lib\jai_codec.jar" (
    echo   - Downloading jai_codec.jar...
    curl -L -o lib\jai_codec.jar https://repo1.maven.org/maven2/com/github/jai-imageio/jai-imageio-core/1.4.0/jai-imageio-core-1.4.0.jar
    if %errorlevel% equ 0 (echo   + Downloaded jai_codec.jar) else (echo   X Failed to download jai_codec.jar)
) else (
    echo   + jai_codec.jar already exists
)

if not exist "lib\mlibwrapper_jai.jar" (
    echo   ! mlibwrapper_jai.jar not found (optional - may not be needed)
    echo     If you encounter issues, download it manually from Oracle's JAI distribution
)

echo.

REM Copy Windows DLLs
echo [6/6] Setting up Windows DLLs...
if defined JAVA_HOME (
    if exist "%JAVA_HOME%\bin" (
        echo   - Copying DLLs to %JAVA_HOME%\bin...
        copy /Y platform-specific\windows\*.dll "%JAVA_HOME%\bin\" >nul 2>&1
        if %errorlevel% equ 0 (
            echo   + DLLs copied to Java bin directory
        ) else (
            echo   X Failed to copy DLLs
            echo     You may need to run this script as Administrator
        )
    ) else (
        echo   X Java bin directory not found at %JAVA_HOME%\bin
    )
) else (
    echo   ! JAVA_HOME environment variable not set
    echo     Please manually copy DLLs from platform-specific\windows to your Java bin directory
)

echo.
echo ========================================
echo Setup Summary
echo ========================================
echo.
echo Downloaded libraries in lib/:
dir /B lib 2>nul
echo.
echo Next Steps:
echo   1. Setup MySQL database (see SETUP_GUIDE.md - Database Setup section)
echo   2. Build the project: mvn clean install
echo   3. Run the application: mvn exec:java -Dexec.mainClass="src.Main"
echo.
echo For detailed instructions, see SETUP_GUIDE.md
echo.
echo Setup completed!
echo.
pause
