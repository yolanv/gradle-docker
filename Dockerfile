FROM openjdk:11-slim

MAINTAINER yolanv <yolanvloeberghs@gmail.com>

ENV GRADLE_VERSION=5.4.1
ENV GRADLE_HOME=/opt/gradle
ENV GRADLE_FOLDER=/root/.gradle

# Change to tmp folder
WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y wget

# Download and extract gradle to opt folder
RUN wget --no-check-certificate https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt \
    && ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle \
    && rm -f gradle-${GRADLE_VERSION}-bin.zip

# Add executables to path
RUN update-alternatives --install "/usr/bin/gradle" "gradle" "/opt/gradle/bin/gradle" 1 && \
    update-alternatives --set "gradle" "/opt/gradle/bin/gradle" 

# Create .gradle folder
RUN mkdir -p $GRADLE_FOLDER

# Mark as volume
VOLUME  $GRADLE_FOLDER

# Change to root folder
WORKDIR /root