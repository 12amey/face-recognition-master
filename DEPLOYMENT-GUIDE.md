# Face Recognition System - Deployment Guide

## ✅ Deployment Package Created Successfully!

Your application has been packaged and is ready for distribution.

---

## 📦 Deliverable

**File:** `face-recognition-dist.zip` (6.2 MB)  
**Location:** `c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master\face-recognition-dist.zip`

---

## 📁 Package Contents

The ZIP file contains:
- **face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar** (6.1 MB) - Main application
- **run.bat** - Launch script for Windows
- **setup-database.sql** - MySQL database creation script
- **README-RUN.md** - User instructions
- **Platform DLLs** (5 files):
  - exthelper.dll
  - j3dcore-d3d.dll
  - j3dcore-ogl.dll
  - j3dcore-ogl-cg.dll
  - j3dcore-ogl-chk.dll

---

## 🚀 How Users Will Run It

### Prerequisites
- Windows 10/11
- Java 8 or higher installed
- MySQL Server 8.0+ installed and running

### Installation Steps

1. **Extract the ZIP file**
   - Unzip `face-recognition-dist.zip` to any folder (e.g., `C:\FaceRecognition\`)

2. **Setup Database** (First time only)
   - Open Command Prompt or PowerShell
   - Navigate to the extracted folder
   - Run:
     ```powershell
     mysql -u root -p < setup-database.sql
     ```
   - Enter your MySQL root password when prompted

3. **Run the Application**
   - Double-click `run.bat`
   - Or from command line:
     ```batch
     run.bat
     ```

### What run.bat Does
```batch
@echo off
setlocal
REM Ensure MySQL is running: net start MySQL80
java -jar "%~dp0face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar"
```

---

## 🔧 Configuration

### Database Connection
The application connects to:
- **Database:** `face_recognition`
- **User:** `root`
- **Password:** (empty by default)
- **URL:** `jdbc:mysql://localhost/face_recognition`

To change these settings, you'll need to modify `src/main/java/src/FrontEnd.java` and rebuild.

---

## 📋 What Changed From Original

1. **Database URL Updated**
   - Changed from `jdbc:mysql://localhost/3dface` to `jdbc:mysql://localhost/face_recognition`

2. **Main Class Updated**
   - Set manifest to use `src.FrontEnd` (GUI entry point) instead of `src.Main` (applet)

3. **Dependencies Updated**
   - Replaced system-scoped Java 3D libraries with publicly available `javax.vecmath`
   - Added JAI imageio libraries from Maven Central
   - All dependencies now download automatically from Maven Central

4. **Java 3D Visualization**
   - 3D visualization features are optional (Java 3D core libraries not included)
   - Core face recognition features work fully without Java 3D

---

## 🎯 Application Features

### Working Features
✅ User Registration & Login  
✅ Load face images for training  
✅ Compute eigenfaces (PCA-based face recognition)  
✅ Identify faces from test images  
✅ Database storage of user credentials  
✅ GUI with Swing interface  

### Optional Features (Requires Java 3D)
⚠️ 3D feature space visualization (commented out in current build)

---

## 📤 Distribution Options

### Current: Portable ZIP
- ✅ Easy to distribute
- ✅ No installer required
- ✅ Users need Java pre-installed
- ✅ Simple extraction and run

### Future Options

#### 1. Windows Installer (.exe)
Use Inno Setup or Launch4j to create:
- One-click installer
- Start menu shortcuts
- Desktop shortcut
- Automatic JRE bundling (optional)

#### 2. Bundle JRE
Include a private JRE inside the package:
- Users don't need Java installed
- Larger file size (~100-150 MB)
- More reliable (consistent Java version)

#### 3. Docker Container
Package app + MySQL in Docker:
- No installation required
- Cross-platform
- Isolated environment

---

## 🐛 Troubleshooting

### Issue: "Java is not recognized"
**Solution:** User needs to install Java JDK/JRE 8+

### Issue: MySQL connection failed
**Solutions:**
- Start MySQL: `net start MySQL80`
- Verify database exists: `mysql -u root -p -e "SHOW DATABASES;"`
- Check username/password in application settings

### Issue: UnsatisfiedLinkError (DLL not found)
**Solution:** DLLs should be in the same folder as the JAR. If issues persist, copy DLLs to `%JAVA_HOME%\bin`

### Issue: Application window doesn't appear
**Solution:** Check if Java GUI is supported. Run from command line to see error messages.

---

## 📊 Build Information

- **Build Date:** November 6, 2025
- **Maven Version:** 3.9.9
- **Java Version:** JDK 8 (compiled with 1.8 target)
- **JAR Type:** Fat JAR (jar-with-dependencies)
- **Main Class:** `src.FrontEnd`

---

## 🔄 Rebuilding from Source

If you need to rebuild:

```powershell
# Navigate to project directory
cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master

# Clean and build
mvn clean package -DskipTests

# Package will be created at:
# target/face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar
```

---

## 📝 License

This project is licensed under the MIT License. See `License.txt` for details.

---

## 🎉 Ready to Distribute!

Your `face-recognition-dist.zip` is ready to share with users. They just need to:
1. Extract the ZIP
2. Setup the MySQL database (one-time)
3. Double-click run.bat

**Package Location:**  
`c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master\face-recognition-dist.zip`

---

## 📞 Support

For issues or questions, refer users to:
- The included `README-RUN.md`
- This deployment guide
- The project's original README.md

**Deployment completed successfully!** ✨
