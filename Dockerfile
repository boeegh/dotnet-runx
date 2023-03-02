FROM mcr.microsoft.com/dotnet/aspnet:N.0-alpine AS base

RUN addgroup --gid 1737 -S dotnet && adduser --uid 1737 -S dotnet -G dotnet \
  && apk add --no-cache dumb-init

COPY start.sh /bin/start.sh
RUN chmod +x /bin/start.sh

WORKDIR /app
RUN chown dotnet /app

USER dotnet
CMD ["dumb-init", "/bin/start.sh"]