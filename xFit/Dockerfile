FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7138
ENV ASPNETCORE_URLS=http://+:7138


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .

FROM build AS publish
RUN dotnet publish "xFit/xFit.csproj" -c Release -o /app
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
COPY xFit/wwwroot/images /xFit/wwwroot/images



ENTRYPOINT ["dotnet", "xFit.dll"]