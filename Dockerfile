FROM ghcr.io/ba-st/pharo:v13.1.2

WORKDIR /opt/pharo

COPY backend/ /app/backend/

RUN pharo metacello install \
    github://svenvc/NeoJSON/repository BaselineOfNeoJSON

EXPOSE 8081

CMD ["pharo", "st", "/app/backend/start.st"]
