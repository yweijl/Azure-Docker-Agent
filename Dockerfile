FROM arm64v8/ubuntu:22.04
RUN apt update
RUN apt upgrade -y
RUN apt install -y \
    libicu70 \
    curl \ 
    git \
    jq \
    zip \
    unzip \
    wget \
    libc6 \
    libgcc1 \
    libgcc-s1 \
    libgssapi-krb5-2 \
    libicu70 \
    liblttng-ust1 \
    libssl3 \
    libstdc++6 \
    libunwind8 \ 
    zlib1g 


RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh && \ 
    chmod +x ./dotnet-install.sh && \ 
    ./dotnet-install.sh --channel 7.0

ENV DOTNET_ROOT "/root/.dotnet"
ENV PATH "${PATH}:${DOTNET_ROOT}:${DOTNET_ROOT}/tools"

RUN dotnet tool install --global PowerShell --version 7.2

RUN pwsh -c "Install-Module -Name Az -Repository PSGallery -Force"
RUN pwsh -c "Update-Module -Name Az -Force"

RUN az bicep install --target-platform linux-arm64
RUN az bicep upgrade

# Can 'linux-arm64', 'linux-arm'.
ENV TARGETARCH=linux-arm64

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

# RUN useradd agent
# RUN chown agent ./
# USER agent

ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT [ "./start.sh" ]
