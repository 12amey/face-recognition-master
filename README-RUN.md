# Run Instructions (Distribution)

This application is packaged as a runnable JAR with dependencies and platform DLLs.

## Requirements
- Windows 10/11
- MySQL Server 8.0 running (service name MySQL80)
- Database `face_recognition` (or update DB config in `src/main/java/src/FrontEnd.java`)

## Files
- `target/face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar`
- `platform-specific/windows/*.dll` (ensure they are in your Java bin or add to PATH)
- `run.bat` (launch helper)

## Run
1. Start MySQL: `net start MySQL80`
2. Double-click `run.bat` or run:
   ```bat
   java -jar target\face-recognition-1.0-SNAPSHOT-jar-with-dependencies.jar
   ```

## Notes
- If DLL errors: copy `platform-specific\windows\*.dll` to `%JAVA_HOME%\bin`.
- To change DB connection, edit `FrontEnd.java` constants and rebuild.
