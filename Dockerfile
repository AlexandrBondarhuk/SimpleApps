FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# copy csproj and restore as distinct layers
COPY src/NetStandardTestApp.sln .
COPY src/NetStandardTestApp/*.csproj ./NetStandardTestApp/
COPY src/NetStandardTestApp.Tests/*.csproj ./NetStandardTestApp.Tests/	
RUN dotnet restore

# copy everything else and build app
COPY . .

RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/core/runtime:3.1
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "dotnetapp.dll"]
