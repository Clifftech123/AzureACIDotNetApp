FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env
WORKDIR /app


# Copy 


COPY . . /app/

# Build and publish a release version

RUN dotnet publish -c Release -o out


# Build runtime image

FROM mcr.microsoft.com/dotnet/aspnet:9.0 
WORKDIR /app
COPY --from=build-env /app/out .



# set the evnironment variable to make the app listen on port 0.0.0.0:80

ENV ASPNETCORE_URLS="http://0.0.0.0:80"


# EXPOSE the port 80

EXPOSE 80


# Run the app

ENTRYPOINT ["dotnet","AzureACIDotNetApp.dll"]