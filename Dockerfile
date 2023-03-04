FROM mcr.microsoft.com/dotnet/aspnet:IMAGE_NO AS base

RUN case "IMAGE_NO" in \
  *alpine*) addgroup --gid 1737 -S dotnet && adduser --uid 1737 -S dotnet -G dotnet && apk add --no-cache dumb-init ;; \
  *      ) adduser --disabled-password --gecos "" --uid 1737 dotnet && apt-get update && apt-get install -y dumb-init && cat /etc/passwd ;; \
  esac

COPY start.sh /bin/start.sh
RUN chmod +x /bin/start.sh

WORKDIR /app
RUN chown dotnet /app

USER dotnet
CMD ["dumb-init", "/bin/start.sh"]