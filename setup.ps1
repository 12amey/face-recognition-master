# Face Recognition System - Automated Setup Script
# Run this script in PowerShell to automatically download and setup dependencies

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Face Recognition System - Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get project directory
$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectDir

Write-Host "Project Directory: $projectDir" -ForegroundColor Yellow
Write-Host ""

# Step 1: Check Java Installation
Write-Host "[1/6] Checking Java Installation..." -ForegroundColor Green
try {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "  ✓ Java found: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Java not found! Please install JDK 8 or higher." -ForegroundColor Red
    exit 1
}

# Check Maven Installation
Write-Host "[2/6] Checking Maven Installation..." -ForegroundColor Green
try {
    $mavenVersion = mvn -version 2>&1 | Select-String "Apache Maven"
    Write-Host "  ✓ Maven found: $mavenVersion" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Maven not found! Please install Apache Maven." -ForegroundColor Red
    exit 1
}

# Step 2: Create lib directory
Write-Host "[3/6] Creating lib directory..." -ForegroundColor Green
if (!(Test-Path "lib")) {
    New-Item -ItemType Directory -Path "lib" | Out-Null
    Write-Host "  ✓ lib directory created" -ForegroundColor Green
} else {
    Write-Host "  ✓ lib directory already exists" -ForegroundColor Green
}

# Step 3: Download Java 3D libraries
Write-Host "[4/6] Downloading Java 3D libraries..." -ForegroundColor Green
$baseUrl = "https://repo1.maven.org/maven2"

$java3dLibs = @(
    @{Name="j3d-core.jar"; Url="$baseUrl/java3d/j3d-core/1.5.2/j3d-core-1.5.2.jar"},
    @{Name="j3d-utils.jar"; Url="$baseUrl/java3d/j3d-core-utils/1.5.2/j3d-core-utils-1.5.2.jar"},
    @{Name="vecmath.jar"; Url="$baseUrl/java3d/vecmath/1.5.2/vecmath-1.5.2.jar"}
)

foreach ($lib in $java3dLibs) {
    $outputPath = "lib\$($lib.Name)"
    if (Test-Path $outputPath) {
        Write-Host "  ✓ $($lib.Name) already exists" -ForegroundColor Yellow
    } else {
        Write-Host "  → Downloading $($lib.Name)..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri $lib.Url -OutFile $outputPath -UseBasicParsing
            Write-Host "  ✓ Downloaded $($lib.Name)" -ForegroundColor Green
        } catch {
            Write-Host "  ✗ Failed to download $($lib.Name): $_" -ForegroundColor Red
        }
    }
}

# Step 4: Download JAI libraries
Write-Host "[5/6] Downloading JAI libraries..." -ForegroundColor Green

$jaiLibs = @(
    @{Name="jai_core.jar"; Url="$baseUrl/javax/media/jai_core/1.1.3/jai_core-1.1.3.jar"},
    @{Name="jai_codec.jar"; Url="$baseUrl/com/github/jai-imageio/jai-imageio-core/1.4.0/jai-imageio-core-1.4.0.jar"}
)

foreach ($lib in $jaiLibs) {
    $outputPath = "lib\$($lib.Name)"
    if (Test-Path $outputPath) {
        Write-Host "  ✓ $($lib.Name) already exists" -ForegroundColor Yellow
    } else {
        Write-Host "  → Downloading $($lib.Name)..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri $lib.Url -OutFile $outputPath -UseBasicParsing
            Write-Host "  ✓ Downloaded $($lib.Name)" -ForegroundColor Green
        } catch {
            Write-Host "  ✗ Failed to download $($lib.Name): $_" -ForegroundColor Red
        }
    }
}

# Check for mlibwrapper_jai.jar
if (!(Test-Path "lib\mlibwrapper_jai.jar")) {
    Write-Host "  ⚠ mlibwrapper_jai.jar not found (optional - may not be needed)" -ForegroundColor Yellow
    Write-Host "    If you encounter issues, download it manually from Oracle's JAI distribution" -ForegroundColor Yellow
}

# Step 5: Copy Windows DLLs
Write-Host "[6/6] Setting up Windows DLLs..." -ForegroundColor Green
if ($env:JAVA_HOME) {
    $javaBinDir = "$env:JAVA_HOME\bin"
    if (Test-Path $javaBinDir) {
        Write-Host "  → Copying DLLs to $javaBinDir..." -ForegroundColor Cyan
        try {
            Copy-Item platform-specific\windows\*.dll $javaBinDir -Force
            Write-Host "  ✓ DLLs copied to Java bin directory" -ForegroundColor Green
        } catch {
            Write-Host "  ✗ Failed to copy DLLs: $_" -ForegroundColor Red
            Write-Host "    You may need to run PowerShell as Administrator" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  ✗ Java bin directory not found at $javaBinDir" -ForegroundColor Red
    }
} else {
    Write-Host "  ⚠ JAVA_HOME environment variable not set" -ForegroundColor Yellow
    Write-Host "    Please manually copy DLLs from platform-specific\windows to your Java bin directory" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Downloaded libraries in lib/:" -ForegroundColor Yellow
Get-ChildItem lib -ErrorAction SilentlyContinue | ForEach-Object {
    $size = [math]::Round($_.Length / 1KB, 2)
    Write-Host "  • $($_.Name) ($size KB)" -ForegroundColor White
}

Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Setup MySQL database (see SETUP_GUIDE.md - Database Setup section)" -ForegroundColor White
Write-Host "  2. Build the project: mvn clean install" -ForegroundColor White
Write-Host "  3. Run the application: mvn exec:java -Dexec.mainClass='src.Main'" -ForegroundColor White
Write-Host ""
Write-Host "For detailed instructions, see SETUP_GUIDE.md" -ForegroundColor Cyan
Write-Host ""
Write-Host "Setup completed!" -ForegroundColor Green
Write-Host ""
