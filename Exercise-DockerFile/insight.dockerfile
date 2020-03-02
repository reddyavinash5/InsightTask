FROM microsoft/windowsservercore

ARG keyvault_name
COPY ./input.json .

ADD ./Exercise-GetSecrets/GetSecrets.ps1 .
ADD ./Exercise-AddSecrets/AddSecrets.ps1 .

RUN powershell -command Install-Module AzureRM
CMD ./GetSecrets.ps1 $keyvault_name; ./AddSecrets.ps1 $keyvault_name "./input.json"
