
#To delete a user
#sudo deluser username
#sudo deluser --remove-home username
read -t 5 -p "<<<<<<<<<<<<<<<<< Updating your system >>>>>>>>>>>>>>>>>>>> "
echo " "
sudo apt-get update
sudo apt-get upgrade

read -t 5 -p "<<<<<<<<<<<<<<<<< Installing Docker >>>>>>>>>>>>>>>>>>>>>>> "
sudo apt install docker.io

read -t 5 -p "<<<<<<<<<<<<<<<<< Creating Docker User >>>>>>>>>>>>>>>>>>>> "
echo " "
RED='\033[0;31m'
echo -e "${RED}Do you want to add Docker to Users? [yes/no] , If you add a Docker user the script will stop here"
echo -e "${RED}and you have to start the script again."
NC='\033[0m'
echo -e "${NC}"
read  x
if [[ "${x}" = "yes" ]]
then
    sudo usermod -aG docker $USER && newgrp docker
else
    echo 'Skipped Docker User'
fi


sudo systemctl start docker
sudo apt-get update
sudo apt-get upgrade


read -t 5 -p "<<<<<<<<<<<<<<<<< Deploying Images >>>>>>>>>>>>>>>>>>>>>>>> "
echo " "
RED='\033[0;31m'
echo -e "${RED}Which image do you want to deploy?"
NC='\033[0m'
echo -e "${NC}"
echo "spark"
echo "hadoop"
read  x
if [[ "${x}" = "spark" ]]
then
    docker pull bitnami/spark
    sudo apt-get install unzip
    cd /usr/local
    sudo wget https://github.com/anmolpal/Docker-Compose/archive/refs/heads/main.zip
    sudo unzip main.zip 
    cd /usr/local/Docker-Compose-main/ 
    sudo chmod 777 docker-compose.yml
    sudo apt install docker-compose
    docker-compose up -d
    cd /usr/local/
    sudo rm -rf main.zip

elif [[ "${x}" = "hadoop" ]]
then
	docker pull lewuathe/hadoop-master
	sudo apt-get install unzip
    cd /usr/local
    sudo wget https://github.com/anmolpal/Hadoop-Docker-Compose/archive/refs/heads/main.zip
    sudo unzip main.zip 
    cd /usr/local/Hadoop-Docker-Compose-main/
    sudo chmod 777 docker-compose.yml
    sudo apt install docker-compose
    docker-compose up -d
    cd /usr/local/ 
    sudo rm -rf main.zip

else
    echo "No selection choosen"
fi 

echo " "
RED='\033[0;31m'
echo -e "${RED}Do you want to Deploy another Docker Image? [yes/no]"
NC='\033[0m'
echo -e "${NC}"
read  x
if [[ "${x}" = "yes" ]]
then
    read -t 5 -p "<<<<<<<<<<<<<<<<< Deploying Images >>>>>>>>>>>>>>>>>>>> "
    echo "Which image do you want to deploy?"
    echo "spark"
    echo "hadoop"
    read  x
    if [[ "${x}" = "spark" ]]
    then
        docker pull bitnami/spark
        sudo apt-get install unzip
        cd /usr/local
        sudo wget https://github.com/anmolpal/Docker-Compose/archive/refs/heads/main.zip
        sudo unzip main.zip 
        cd /usr/local/Docker-Compose-main/ 
        sudo chmod 777 docker-compose.yml
        sudo apt install docker-compose
        docker-compose up -d
        cd /usr/local/
        sudo rm -rf main.zip

    elif [[ "${x}" = "hadoop" ]]
    then
        docker pull lewuathe/hadoop-master
        sudo apt-get install unzip
        cd /usr/local
        sudo wget https://github.com/anmolpal/Hadoop-Docker-Compose/archive/refs/heads/main.zip
        sudo unzip main.zip 
        cd /usr/local/Hadoop-Docker-Compose-main/
        sudo chmod 777 docker-compose.yml
        sudo apt install docker-compose
        docker-compose up -d
        cd /usr/local/ 
        sudo rm -rf main.zip
    
    else
        echo "No selection choosen"
    fi
else
    echo "No selection choosen"
fi 
