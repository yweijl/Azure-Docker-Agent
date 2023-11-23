# Azure-Docker-Agent

An Azure self hosted agent configured for docker with ARM64 architecture for Linux/Mac

## Installed packages

- .NET 7
- Powershell
- Azure Powershell
- Azure CLI
- Azure Bicep

## Build and run Docker Image

Use the following command to build the image  
`docker build --tag "azp-agent:linux" --file "./dockerfile" .`

To Run the image  
`docker run -e AZP_URL="<Azure DevOps instance>" -e AZP_TOKEN="<Personal Access Token>" -e AZP_POOL="<Agent Pool Name>" -e AZP_AGENT_NAME="Docker Agent - Linux" --name "azp-agent-linux" azp-agent:linux`

For more information on how to run the docker agent see [Azure-docker-agent](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops)
or [Configure Self-Hosted](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops)
