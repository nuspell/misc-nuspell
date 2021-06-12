FROM ubuntu:18.04
WORKDIR /root
COPY docker-deps.sh ./
RUN ./docker-deps.sh
COPY build-from-source.sh org.nuspell.Nuspell.desktop ./
# ENV CC=gcc-7 CXX=g++-7
RUN ./build-from-source.sh
