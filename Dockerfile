FROM arm64v8/ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common \
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    libicu66 \
    libssl1.1 \
    libstdc++6 \
    zlib1g \
    zip \
    unzip \
    wget 

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && \ 
    chmod +x ./dotnet-install.sh && \ 
    ./dotnet-install.sh --channel 7.0

ENV DOTNET_ROOT "/root/.dotnet"
ENV PATH "${PATH}:${DOTNET_ROOT}:${DOTNET_ROOT}/tools"

RUN dotnet tool install --global PowerShell

RUN pwsh -c "Install-Module -Name Az -Repository PSGallery -Force"
RUN pwsh -c "Update-Module -Name Az -Force"

RUN az bicep install --target-platform linux-arm64
RUN az bicep upgrade

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-arm64

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]
