FROM ubuntu:24.10
RUN apt-get update && apt-get install -y \
    mysql-client \
    bash \
    && rm -rf /var/lib/apt/lists/*           

WORKDIR /usr/src/app                          

COPY ./libraryApp/ .                             

ENTRYPOINT ["bash", "entrypoint.sh"]                 