# syntax=docker/dockerfile:1

FROM ubuntu
WORKDIR /app
COPY *.c .
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y bash
RUN apt-get install -y git
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update
RUN apt-get install -y python3.7
RUN gcc -o dummyserv dummy_serv.c
CMD ./dummyserv
EXPOSE 8080
