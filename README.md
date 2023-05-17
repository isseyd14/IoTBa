## IoTBay Group 4

### To run this project on IntelliJ (Recommended):

1. Clone the GitHub Repository
2. Open the folder containing the repository code as a new IntelliJ project
3. This will normally happen automatically, but if a popup "Maven Scripts Found" comes up in the lower right corner of the screen, click "Load Maven Project"
4. Using the run configuration that is already set up in the project, launch GlassFish v6.2.5
5. Open a browser and go to [http://localhost:8080/](http://localhost:8080/) to be presented with the website's landing page.


### To run this project on Netbeans:
1. Clone the Github repository.
2. On Netbeans, File -> Open Project -> Select folder containing repository code.
3. Run project and if there is trouble detecting server, right click the IoT project -> properties -> run -> under server, and ensure Glassfish server is selected running version 6.2.5. If no option available, manually add server under tools -> server.
4. If using a mac/linux machine, you may get an error `Cannot run program "/Users/(username)/(folderlocation)/IoTBa/mvnw" (in directory "/Users/(username)/(folderlocation)/IoTBa"): error=13, Permission denied`. To fix this, `cd` into the `IoTBa` folder on terminal and run `chmod +x mvwn`.
5. Run project, browser should automatically open to landing page or manually go to [http://localhost:8080/](http://localhost:8080/).
