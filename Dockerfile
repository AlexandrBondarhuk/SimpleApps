# https://hub.docker.com/_/microsoft-dotnet-core
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers

COPY src/*.sln .
COPY Sources/NetCoreWebApp/*.csproj ./NetCoreWebApp/


RUN dotnet restore

# copy everything else and build app
COPY src/NetCoreWebApp/. ./NetCoreWebApp/


WORKDIR /source/NetCoreWebApp/
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/core/runtime:3.1
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "netcorewebapp.dll"]