FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
#COPY src/NetStandardTestApp.sln .
#COPY src/NetStandardTestApp/*.csproj ./
#COPY src/NetStandardTestApp.Tests/*.csproj ./

#RUN dotnet restore 

# Copy everything else and build
#COPY . ./
#RUN dotnet publish -c Release -o out
#########################################

# copy csproj and restore as distinct layers
COPY *.sln .
COPY src/NetStandardTestApp/*.*.csproj ./NetStandardTestApp/
COPY src/NetStandardTestApp.Tests/*.*.csproj ./NetStandardTestApp.Tests/
	
RUN dotnet restore

# copy everything else and build app
COPY NetStandardTestApp/. ./NetStandardTestApp/
COPY NetStandardTestApp.Tests/. ./NetStandardTestApp.Tests/

WORKDIR /app/NetStandardTestApp

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "NetStandardTestApp.dll"]