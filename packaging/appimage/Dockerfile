FROM ubuntu:18.04
WORKDIR /root
COPY docker-deps.sh ./
RUN ./docker-deps.sh
COPY build-from-source.sh org.nuspell.Nuspell.desktop ./
ENV CC=gcc-8 CXX=g++-8
RUN ./build-from-source.sh
