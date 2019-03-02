* Through the sandbox, give the learner a Linux VM to set up.
* Set up the build agent.
* Configure it to the build pipeline.
* Build it. See the results. See the artifact and the dashboard.

-----

Notes from spike:

1. Create agent pool (Project settings => Agent pools)
1. Create PAT (https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-linux?view=azure-devops#authenticate-with-a-personal-access-token-pat)
1. 

```azurecli
az group create --name test1 --location eastus
```

```azurecli
az vm create \
  --name myVM \
  --resource-group test1 \
  --image UbuntuLTS \
  --location eastus \
  --size Standard_DS2_v2 \
  --admin-username azureuser \
  --generate-ssh-keys
```

```azurecli
az vm extension set \
  --resource-group test1 \
  --vm-name myVM \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
  --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```

```azurecli
IPADDRESS=$(az vm show \
  --name myVM \
  --resource-group test1 \
  --show-details \
  --query [publicIps] \
  --output tsv)
```

```bash
echo $IPADDRESS
137.135.86.42
```

```bash
#!/bin/bash
# username = $1

sudo apt-get update
sudo apt-get install curl --yes

mkdir /home/$1/Downloads

curl https://vstsagentpackage.azureedge.net/agent/2.147.1/vsts-agent-linux-x64-2.147.1.tar.gz > /home/$1/Downloads/vsts-agent-linux-x64-2.147.1.tar.gz

mkdir /home/$1/myagent
cd /home/$1/myagent
tar zxvf ~/Downloads/vsts-agent-linux-x64-2.147.1.tar.gz

./bin/installdependencies.sh

curl https://dot.net/v1/dotnet-install.sh > dotnet-install.sh
chmod u+x dotnet-install.sh
./dotnet-install.sh -c Current
#echo '# Add dotnet to PATH' >> ~/.bashrc
#echo 'export PATH="/home/$1/.dotnet:$PATH"' >> ~/.bashrc
ln -s /home/$1/.dotnet/dotnet /usr/bin/dotnet

./config.sh
```

(TODO: Convert these to ./config.sh arguments)

* server url: https://dev.azure.com/tpetchel0251
* auth: pat
* pat: [your token]
---
* agent pool: test1
* agent name: myVM
* work folder: _work

### Enable the service

(Knowledge needed: what choices do I have? (interactive vs. service)

```bash
sudo ./svc.sh install
sudo ./svc.sh start
```

(See it light up in the web UI)

### Test it out

```bash
git checkout master
```

```bash
git checkout -b custom-pool
```

```yml
pool: test1

variables:
  #BuildPlatform: 'any cpu'
  BuildConfiguration: 'Release'

steps:
- script: dotnet nuget locals all --clear
  displayName: 'Clear local NuGet cache'

- script: dotnet restore src
  displayName: 'dotnet restore src'

- script: dotnet build src --configuration $(BuildConfiguration)
  displayName: 'dotnet build src --configuration $(BuildConfiguration)'

- task: PublishBuildArtifacts@1
  displayName: 'Publish Artifact: drop'
```

Reference: https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema#pool
