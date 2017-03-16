# This is based on itzg/minecraft-server

FROM java:8

MAINTAINER Luke Merry <lmerry@gmail.com>

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1234 minecraft
RUN adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \
	wget -c https://addons-origin.cursecdn.com/files/2389/790/FTBBeyondServer_1.0.1.zip && \
	unzip FTBBeyondServer_1.0.1.zip && \
	rm FTBBeyondServer_1.0.1.zip && \
	bash -x FTBInstall.sh && \
	chown -R minecraft /tmp/feed-the-beast


USER minecraft

EXPOSE 25565

ADD start.sh /start

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start

ENV MOTD A Minecraft (FTB Beyond 1.0.1) Server Powered by Docker
ENV LEVEL world
ENV JVM_OPTS -Xms2048m -Xmx4096m
