# Face Recognition System - Complete Setup Guide

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Database Setup](#database-setup)
3. [Java 3D API Installation](#java-3d-api-installation)
4. [JAI Libraries Setup](#jai-libraries-setup)
5. [Platform-Specific Setup (Windows)](#platform-specific-setup-windows)
6. [Building the Project](#building-the-project)
7. [Running the Application](#running-the-application)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software
- **Java Development Kit (JDK) 8 or higher**
  - Download from: https://www.oracle.com/java/technologies/downloads/
  - Verify installation: `java -version` and `javac -version`
  - Set JAVA_HOME environment variable

- **Apache Maven 3.6+**
  - Download from: https://maven.apache.org/download.cgi
  - Verify installation: `mvn -version`
  - Add Maven to PATH

- **MySQL Server 8.0+**
  - Download from: https://dev.mysql.com/downloads/mysql/
  - Remember the root password you set during installation

- **Git** (if cloning from repository)
  - Download from: https://git-scm.com/downloads

---

## Database Setup

### Step 1: Start MySQL Server
```powershell
# On Windows, start MySQL service
net start MySQL80
```

### Step 2: Create Database and Table
```powershell
# Login to MySQL
mysql -u root -p
```

Then execute the following SQL commands:
```sql
-- Create the database
CREATE DATABASE face_recognition;

-- Use the database
USE face_recognition;

-- Create users table
CREATE TABLE users (
    UserName VARCHAR(30),
    Email VARCHAR(50),
    Phone VARCHAR(10),
    Password VARCHAR(20)
);

-- Verify table creation
SHOW TABLES;
DESCRIBE users;

-- Exit MySQL
EXIT;
```

### Step 3: Configure Database Connection (if needed)
The application may use default MySQL credentials. If you need custom credentials, you may need to update configuration files in the source code.

---

## Java 3D API Installation

### Option 1: Download Java 3D 1.5.2 (Recommended)

1. **Create lib directory** in your project root:
   ```powershell
   cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master
   mkdir lib
   ```

2. **Download Java 3D libraries**:
   - Visit: https://jogamp.org/deployment/java3d/1.5.2/
   - Or use Maven repository: https://repo1.maven.org/maven2/java3d/
   
3. **Required JAR files**:
   - `j3d-core.jar` (version 1.5.2)
   - `j3d-utils.jar` (version 1.5.2)
   - `vecmath.jar` (version 1.5.2)

4. **Download using PowerShell** (automated):
   ```powershell
   # Navigate to project directory
   cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master
   
   # Create lib directory if it doesn't exist
   if (!(Test-Path "lib")) { New-Item -ItemType Directory -Path "lib" }
   
   # Download Java 3D libraries
   $baseUrl = "https://repo1.maven.org/maven2"
   
   Invoke-WebRequest -Uri "$baseUrl/java3d/j3d-core/1.5.2/j3d-core-1.5.2.jar" -OutFile "lib\j3d-core.jar"
   Invoke-WebRequest -Uri "$baseUrl/java3d/j3d-core-utils/1.5.2/j3d-core-utils-1.5.2.jar" -OutFile "lib\j3d-utils.jar"
   Invoke-WebRequest -Uri "$baseUrl/java3d/vecmath/1.5.2/vecmath-1.5.2.jar" -OutFile "lib\vecmath.jar"
   ```

### Option 2: Manual Download

1. Visit each link and download manually:
   - https://repo1.maven.org/maven2/java3d/j3d-core/1.5.2/j3d-core-1.5.2.jar
   - https://repo1.maven.org/maven2/java3d/j3d-core-utils/1.5.2/j3d-core-utils-1.5.2.jar
   - https://repo1.maven.org/maven2/java3d/vecmath/1.5.2/vecmath-1.5.2.jar

2. Save them to the `lib` directory with these exact names:
   - `j3d-core.jar`
   - `j3d-utils.jar`
   - `vecmath.jar`

---

## JAI Libraries Setup

### Download Java Advanced Imaging (JAI) Libraries

1. **Download JAI 1.1.3**:
   - Core: https://repo1.maven.org/maven2/javax/media/jai_core/1.1.3/jai_core-1.1.3.jar
   - Codec: https://repo1.maven.org/maven2/com/github/jai-imageio/jai-imageio-core/1.4.0/jai-imageio-core-1.4.0.jar

2. **Using PowerShell** (automated):
   ```powershell
   cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master
   
   # Download JAI libraries
   Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/javax/media/jai_core/1.1.3/jai_core-1.1.3.jar" -OutFile "lib\jai_core.jar"
   Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/com/github/jai-imageio/jai-imageio-core/1.4.0/jai-imageio-core-1.4.0.jar" -OutFile "lib\jai_codec.jar"
   
   # For mlibwrapper (if needed - may not be available in public repos)
   # This might need to be extracted from Oracle's JAI distribution
   ```

3. **Manual alternative**:
   - Download Oracle JAI SDK from: https://www.oracle.com/java/technologies/advanced-imaging-api.html
   - Extract and copy these files to `lib/`:
     - `jai_core.jar`
     - `jai_codec.jar`
     - `mlibwrapper_jai.jar`

**Note**: `mlibwrapper_jai.jar` may be optional or need manual extraction from Oracle's distribution.

---

## Platform-Specific Setup (Windows)

### Step 1: Install Microsoft Visual C++ Redistributable
1. Download from: https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist
2. Install `vcredist_x86.exe` (32-bit) or `vcredist_x64.exe` (64-bit based on your Java installation)

### Step 2: Copy DLLs to Java Directory
The project already includes Windows DLLs in `platform-specific\windows\`. Copy them to your Java bin directory:

```powershell
# Find your JAVA_HOME
echo $env:JAVA_HOME

# If JAVA_HOME is not set, find Java manually
# Example: C:\Program Files\Java\jdk1.8.0_xxx

# Copy DLLs
cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master
Copy-Item platform-specific\windows\*.dll "$env:JAVA_HOME\bin\"

# Alternative: Copy to JRE bin if you have separate JRE
# Copy-Item platform-specific\windows\*.dll "$env:JAVA_HOME\jre\bin\"
```

### Step 3: Add Java 3D to Library Path (Optional)
You may need to add the lib directory to your java.library.path:

```powershell
# Set environment variable temporarily
$env:JAVA_LIBRARY_PATH="c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master\lib"
```

---

## Building the Project

### Step 1: Verify Dependencies
```powershell
cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master

# List lib directory contents
dir lib

# You should see:
# j3d-core.jar
# j3d-utils.jar
# vecmath.jar
# jai_core.jar
# jai_codec.jar
# mlibwrapper_jai.jar (optional)
```

### Step 2: Clean and Build
```powershell
# Clean previous builds
mvn clean

# Compile and package
mvn clean install

# Or compile without tests
mvn clean install -DskipTests
```

### Step 3: Verify Build Success
After successful build, you should see:
- `target/face-recognition-1.0-SNAPSHOT.jar`
- `target/face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar`

---

## Running the Application

### Method 1: Using Maven Exec Plugin
```powershell
mvn exec:java -Dexec.mainClass="src.Main"
```

### Method 2: Using Java Directly
```powershell
# Run with dependencies
java -jar target\face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar
```

### Method 3: Run with Explicit Classpath
```powershell
java -cp "target\face-recognition-1.0-SNAPSHOT.jar;lib\*" src.Main
```

---

## Using the Application

### Step 1: Load Training Images
1. Click **"Load Images"** button
2. Select a folder containing face images (.jpg or .png)
3. Images will be displayed in the face browser

### Step 2: Train the System
1. Click **"Compute Eigen Vectors"** button
2. Wait for eigenface computation to complete
3. The system will build the feature space

### Step 3: Identify a Face
1. Click **"Identify Face"** button
2. Select a test image
3. The system will match it against the training set
4. Results will show the matched person and processing time

### Step 4: View Results
1. Click **"Display Result Chart"** to see 3D visualization
2. The feature space chart shows the classification

---

## Troubleshooting

### Issue 1: UnsatisfiedLinkError for Java 3D
**Error**: `java.lang.UnsatisfiedLinkError: no j3dcore-ogl in java.library.path`

**Solution**:
```powershell
# Copy DLLs again
Copy-Item platform-specific\windows\*.dll "$env:JAVA_HOME\bin\" -Force

# Or set library path
java -Djava.library.path="platform-specific\windows" -jar target\face-recognition-1.0-SNAPSHOT.jar
```

### Issue 2: ClassNotFoundException
**Error**: `ClassNotFoundException: src.Main`

**Solution**: Ensure you're running from project root and the class path is correct.

### Issue 3: MySQL Connection Error
**Error**: `SQLException: Access denied for user`

**Solution**:
- Verify MySQL is running: `net start MySQL80`
- Check credentials in source code
- Ensure `face_recognition` database exists

### Issue 4: Missing JAR Files
**Error**: `FileNotFoundException` for lib/*.jar

**Solution**: Re-download all required libraries to `lib/` directory.

### Issue 5: Out of Memory
**Error**: `OutOfMemoryError`

**Solution**:
```powershell
# Increase heap size
java -Xmx2G -jar target\face-recognition-1.0-SNAPSHOT.jar
```

---

## Project Structure Reference

```
face-recognition-master/
├── src/
│   └── main/
│       ├── java/src/          # Source code
│       │   ├── Main.java      # Entry point
│       │   ├── Face.java
│       │   ├── FeatureSpace.java
│       │   ├── TSCD.java
│       │   └── ...
│       └── resources/         # Resources
│           ├── face.png
│           └── bkd.png
├── lib/                       # Local dependencies (you create this)
│   ├── j3d-core.jar
│   ├── j3d-utils.jar
│   ├── vecmath.jar
│   ├── jai_core.jar
│   ├── jai_codec.jar
│   └── mlibwrapper_jai.jar
├── platform-specific/
│   └── windows/               # Windows DLLs
│       ├── j3dcore-ogl.dll
│       └── ...
├── pom.xml                    # Maven configuration
└── README.md

```

---

## Quick Start Script

Here's a complete setup script for Windows PowerShell:

```powershell
# Navigate to project
cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master

# Create lib directory
if (!(Test-Path "lib")) { New-Item -ItemType Directory -Path "lib" }

# Download Java 3D libraries
$baseUrl = "https://repo1.maven.org/maven2"
Invoke-WebRequest -Uri "$baseUrl/java3d/j3d-core/1.5.2/j3d-core-1.5.2.jar" -OutFile "lib\j3d-core.jar"
Invoke-WebRequest -Uri "$baseUrl/java3d/j3d-core-utils/1.5.2/j3d-core-utils-1.5.2.jar" -OutFile "lib\j3d-utils.jar"
Invoke-WebRequest -Uri "$baseUrl/java3d/vecmath/1.5.2/vecmath-1.5.2.jar" -OutFile "lib\vecmath.jar"

# Download JAI libraries
Invoke-WebRequest -Uri "$baseUrl/javax/media/jai_core/1.1.3/jai_core-1.1.3.jar" -OutFile "lib\jai_core.jar"
Invoke-WebRequest -Uri "$baseUrl/com/github/jai-imageio/jai-imageio-core/1.4.0/jai-imageio-core-1.4.0.jar" -OutFile "lib\jai_codec.jar"

# Copy DLLs to Java bin
Copy-Item platform-specific\windows\*.dll "$env:JAVA_HOME\bin\" -Force

# Build project
mvn clean install

# Run application
mvn exec:java -Dexec.mainClass="src.Main"
```

---

## Additional Resources

- **Java 3D Documentation**: https://docs.oracle.com/javase/8/docs/technotes/guides/java3d/
- **JAI Documentation**: https://www.oracle.com/java/technologies/advanced-imaging-api.html
- **Maven Documentation**: https://maven.apache.org/guides/
- **MySQL Documentation**: https://dev.mysql.com/doc/

---

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Verify all prerequisites are installed
3. Ensure all library files are in the correct locations
4. Check console output for specific error messages

## License
This project is licensed under the MIT License - see the License.txt file for details.
