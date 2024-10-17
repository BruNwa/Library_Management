FROM ubuntu:24.10

RUN apt-get update && apt-get install -y \
    mysql-client \
    bash \
    vim-tiny \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY ./libraryApp/ .
RUN chmod +x /usr/src/app/entrypoint.sh
ENTRYPOINT ["bash", "/usr/src/app/entrypoint.sh"]                 