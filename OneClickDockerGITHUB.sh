
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
PS3='Please enter your choice: '
options=("1 Hadoop" "2 Spark" "3 Postgresql" "4 Airflow" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "1 Hadoop")
            echo "you chose choice 1"
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
            ;;
        "2 Spark")
            echo "you chose choice 2"
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
            ;;
        "3 Postgresql")
            echo "you chose choice $REPLY which is $opt"
            docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
            ;;
        "4 Airflow")
            echo "you chose choice $REPLY which is $opt"
            #Recommended docker-compose version 1.29 or above. If version is less then 1.29 uninstall 
            #previous docker-compose
            #pip uninstall docker-compose
            sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            sudo mkdir airflow-docker
            sudo chmod 777 airflow-docker
            cd airflow-docker
            curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.2.1/docker-compose.yaml'
            sudo mkdir ./dags ./plugins ./logs
            sudo chmod 777 ./dags ./plugins ./logs
            echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=0" > .env
            docker-compose up airflow-init
            docker-compose up -d
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


