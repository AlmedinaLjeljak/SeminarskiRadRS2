#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["xFit_rabbit/xFit_rabbit.csproj", "xFit_rabbit/"]
RUN dotnet restore "xFit_rabbit/xFit_rabbit.csproj"
COPY . .
WORKDIR "/src/xFit_rabbit"
RUN dotnet build "xFit_rabbit.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "xFit_rabbit.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "xFit_rabbit.dll"]