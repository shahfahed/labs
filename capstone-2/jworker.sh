sudo apt update
sudo openjdk-17-jdk -y
wget https://raw.githubusercontent.com/shahfahed/labs/refs/heads/main/scripts/installdocker.sh -P /tmp

sudo chmod 755 /tmp/installdocker.sh
sudo bash /tmp/installdocker.sh