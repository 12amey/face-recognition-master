# Face Recognition System - Quick Start Guide

## 🚀 Quick Setup (5 Steps)

### Step 1: Install Prerequisites
Install these tools if you don't have them:
- **Java JDK 8+** → https://www.oracle.com/java/technologies/downloads/
- **Apache Maven** → https://maven.apache.org/download.cgi
- **MySQL Server** → https://dev.mysql.com/downloads/mysql/

Verify installations:
```powershell
java -version
mvn -version
mysql --version
```

### Step 2: Setup Database
Start MySQL and create the database:
```powershell
# Start MySQL service
net start MySQL80

# Run database setup script
mysql -u root -p < setup-database.sql

# Or manually:
mysql -u root -p
CREATE DATABASE face_recognition;
USE face_recognition;
CREATE TABLE users (
    UserName VARCHAR(30),
    Email VARCHAR(50),
    Phone VARCHAR(10),
    Password VARCHAR(20)
);
EXIT;
```

### Step 3: Download Dependencies
Run the automated setup script:
```powershell
# Navigate to project directory
cd c:\Users\deshm\Downloads\face-recognition-master\face-recognition-master

# Run setup script (downloads Java 3D and JAI libraries)
.\setup.ps1
```

**Manual alternative:** If the script fails, download libraries manually (see SETUP_GUIDE.md)

### Step 4: Build the Project
```powershell
# Clean and build
mvn clean install
```

Wait for the build to complete. You should see `BUILD SUCCESS`.

### Step 5: Run the Application
```powershell
# Run using Maven
mvn exec:java -Dexec.mainClass="src.Main"

# Or run the JAR directly
java -jar target\face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar
```

---

## 📋 Using the Application

### 1. Load Training Images
- Click **"Load Images"**
- Select a folder with face images (.jpg or .png files)
- Images appear in the browser

### 2. Train the System
- Click **"Compute Eigen Vectors"**
- Wait for processing to complete
- System builds face recognition model

### 3. Identify a Face
- Click **"Identify Face"**
- Select a test image
- View the match results

### 4. View Results
- Click **"Display Result Chart"**
- See 3D visualization of feature space

---

## 🛠️ Troubleshooting

### ❌ Error: "UnsatisfiedLinkError: j3dcore-ogl"
**Fix:** Copy DLLs to Java bin directory
```powershell
Copy-Item platform-specific\windows\*.dll "$env:JAVA_HOME\bin\" -Force
```

### ❌ Error: "ClassNotFoundException: src.Main"
**Fix:** Rebuild the project
```powershell
mvn clean install
```

### ❌ Error: MySQL connection failed
**Fix:** 
1. Start MySQL: `net start MySQL80`
2. Check database exists: `mysql -u root -p -e "SHOW DATABASES;"`
3. Verify credentials in code

### ❌ Error: "Cannot find symbol" during build
**Fix:** Ensure all JARs are in `lib/` directory
```powershell
dir lib
# Should show: j3d-core.jar, j3d-utils.jar, vecmath.jar, jai_core.jar, jai_codec.jar
```

---

## 📁 Required File Structure

```
face-recognition-master/
├── lib/                          ← Libraries (created by setup.ps1)
│   ├── j3d-core.jar
│   ├── j3d-utils.jar
│   ├── vecmath.jar
│   ├── jai_core.jar
│   └── jai_codec.jar
├── platform-specific/windows/     ← Windows DLLs (already included)
├── src/main/java/src/            ← Source code
├── src/main/resources/           ← Images (face.png, bkd.png)
├── pom.xml                       ← Maven configuration
├── setup.ps1                     ← Setup script
├── setup-database.sql            ← Database script
└── SETUP_GUIDE.md               ← Detailed guide
```

---

## 🎯 What Each File Does

| File | Purpose |
|------|---------|
| `setup.ps1` | Downloads Java 3D and JAI libraries automatically |
| `setup-database.sql` | Creates MySQL database and tables |
| `SETUP_GUIDE.md` | Detailed setup instructions with troubleshooting |
| `QUICK_START.md` | This file - fast setup guide |
| `pom.xml` | Maven build configuration |

---

## 💡 Tips

1. **Run PowerShell as Administrator** if you get permission errors when copying DLLs
2. **Use Java 8** for best compatibility (Java 11+ may have issues with Java 3D)
3. **Check JAVA_HOME** is set correctly: `echo $env:JAVA_HOME`
4. **Keep images small** (recommended: 48x64 pixels for faces)
5. **Use consistent lighting** in training images for better recognition

---

## 🔗 Helpful Commands

```powershell
# Check if MySQL is running
Get-Service MySQL80

# Start MySQL
net start MySQL80

# Stop MySQL
net stop MySQL80

# View Maven dependencies
mvn dependency:tree

# Clean build artifacts
mvn clean

# Build without tests
mvn clean install -DskipTests

# Run with more memory
java -Xmx2G -jar target\face-recognition-1.0-SNAPSHOT.jar
```

---

## 📚 More Information

- **Detailed Setup:** See `SETUP_GUIDE.md`
- **Project Structure:** See main `README.md`
- **Code Style:** See `CODING_STYLE.md`
- **License:** See `License.txt`

---

## ✅ Success Checklist

Before running the application, verify:

- [ ] Java JDK 8+ installed
- [ ] Maven installed
- [ ] MySQL installed and running
- [ ] Database `face_recognition` created
- [ ] Table `users` created
- [ ] All JAR files in `lib/` directory
- [ ] DLLs copied to Java bin directory
- [ ] Project builds successfully (`mvn clean install`)

---

## 🆘 Still Having Issues?

1. Read the detailed `SETUP_GUIDE.md`
2. Check console error messages
3. Verify all prerequisites are installed correctly
4. Ensure file paths are correct
5. Try running PowerShell as Administrator

---

**Need help?** Check the troubleshooting section in `SETUP_GUIDE.md` for detailed solutions.
