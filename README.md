# To-Do-List

Implementation:

![image](https://github.com/vbs30/To-Do-List/assets/95699405/d33aae56-5a84-4ad4-927b-51181b10fb50)


Implementation commands:

1. Make sure you install Node.js
2. npm install (will install all the node packages)
3. Run node server.js to run the website at port 3000


*For deployment I have used AWS EC2 with Docker and jenkins*
1. I utilized AWS EC2 to create an Ubuntu instance, providing a robust, scalable environment to streamline the deployment process.
2. By integrating Jenkins with AWS, he set up a seamless pipeline, allowing code from the GitHub repository to be directly transferred to the EC2 instance. Jenkins facilitated continuous integration, automating the process of fetching and preparing the code for deployment.
3. Docker was then employed to containerize and deploy the website, ensuring consistency across environments and simplifying the management of dependencies.
4. This combination of EC2, Jenkins, and Docker enabled an efficient, automated, and reliable deployment workflow.

*Commands that I performed*
1. Created EC2 Instance of Ubuntu 
2. _sudo apt update_ (for updating inner files and packages)
3. _sudo apt install openjdk-11-jre_ (As jenkins is made with java so installing java)
4. Checking whether java installed or not by _java --version_

--For installing jenkins

6. curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
7. echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
8. sudo apt-get update (to update packages newly installed)
9. sudo apt-get install jenkins
10. sudo systemctl enable jenkins
11. sudo systemctl start jenkins 
12. sudo systemctl status jenkins (check where jenkins is active or not)

--For setting public and private key so that this instance can be directly connect with github and jenkins

13. ssh-keygen
14. cd .ssh
15. the file (rsa) has private key and file (.pub) has public key

--Now start the jenkins with port 8080

16. Add all credentials like username password and and go to the main page of Jenkins
17. If jenkins site do not start then add the new 8080 port at AWS EC2 Security group.
(You should locate the security groups of the running instance. You should locate the edit inbound rules and add a new network with CUSTOM TCP and add the port 8080. This will start the jenkins site)
18. Now start with a freestyle project.
19. Give description of why are you using it.
20. In source code management, select GIT and add the Repository URL. 
21. Now in credentials part, click ADD, select SSH Username with private key in KIND, give ID name of your choice, give description of your choice, username must be the instance you creaated (eg. ubuntu). At private key section click ENTER DIRECTLY and add the private key which you created earlier. Then click ADD 
22. After adding, select this newly created credential and click SAVE.
23. Now once the freestyle project is created click BUILD at left. This will automatically move all the files from github repository to your EC2 instance. Will now allow you to access all the files and folders in your instance. 
24. Enter command cd file-name (file name is mentioned at the console output of the jenkins freestyle project. You will see this output once you click build and build is successful.)

--Now you need to create a docker file which will allow the website to run dircectly at any system (Linux, Ubuntu, Windows, MacOS, etc).

25. sudo apt-install nodejs (Install node js in your instance)
26. sudo install npm
27. sudo apt install docker.io
28. sudo vim Dockerfile
CODE TO ADD:

FROM node:12.2.0-alpine
WORKDIR app
COPY . .
RUN npm install
EXPOSE your_port (eg. 8000) 
CMD ["node","file_name.js"]


29. sudo usermod -a -G docker $USER (will allow you to build docker container at your instance)
30. sudo reboot (After you provide permission to create docker containers, your instance needs to be rebooted)
31. docker build . -t your_app_name
32. docker run -d --name your_container_name -p 8000:8000 build_name
33. docker ps (To check whether container is running or not)
34. Add this network to the security groups in your EC2 instance.
35. In Edit inbound rules, add custom TCP, you select anytime ipv4 option and add the port of your app.
36. Now your app is running at any local or server computers. You do not need any hosting site.
