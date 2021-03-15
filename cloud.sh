#!/bin/bash
echo Removing general waste
sudo apt autoremove --purge snapd -y
sudo apt remove libreoffice-* -y
sudo apt autoremove -y

echo Installing common tools
sudo apt update && sudo apt upgrade -y
sudo apt install openssh-server python3-virtualenv python3-pip jq python2 -y
touch ~/.Xauthority

echo Installing docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y
echo Docker is now installed

echo Installing Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo Finished installing Azure CLI

echo Installing AWS CLI
cd /tmp && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install && rm -rf /tmp/aws awscliv2.zip
echo Finished installing AWS CLI

echo Installing GCP SDK
sudo apt-get install apt-transport-https ca-certificates gnupg -y && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && sudo apt-get update && sudo apt-get install google-cloud-sdk -y
echo Finished installing GCP SDK

echo Installing ScoutSuite
sudo apt install python3-virtualenv python3-pip -y
printf '#!/bin/bash\nvirtualenv -p python3 venv && source venv/bin/activate && pip install scoutsuite\nscout --help\n/bin/bash\n' | sudo tee /usr/bin/startscout && sudo chmod +x /usr/bin/startscout
echo Finished. To start ScoutSuite remember to run "startscout" for each terminal you want ScoutSuite in.

echo Installing AWSPX
cd /opt && sudo git clone https://github.com/FSecureLABS/awspx.git && cd awspx && sudo ./INSTALL && cd
echo Finished. To use awspx, su to root and run 'awspx -h' to get started. Default browser is available at http://localhost:80

echo Installing CloudSplaining
pip3 install --user cloudsplaining
echo Finished. Run cloudsplaining with "cloudsplaining --help" to get started

echo Installing CS-Suite
cd && git clone https://github.com/SecurityFTW/cs-suite
printf '#!/bin/bash\ncd ~/cs-suite && virtualenv -p python2.7 venv && source venv/bin/activate && pip install -r requirements.txt --user && cd ~/cs-suite && python cs.py -h\n' | sudo tee /usr/bin/startcs && sudo chmod +x /usr/bin/startcs
echo Finished. To start CS Suite remember to run "startcs" for each terminal you want CS Suite in.

startscout
exit
startcs
exit
cloudsplaining --help
