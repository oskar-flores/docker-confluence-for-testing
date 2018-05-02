FROM alpine:3.7
MAINTAINER @aruizca - Angel Ruiz

ARG JDK_URL

ENV GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc \
    GLIBC_VERSION=2.27-r0 \
    ATLAS_SDK_VERSION=6.3.10

# Install glibc and others
RUN set -ex && \
    apk -U upgrade && \
    apk add libstdc++ curl ca-certificates bash wget && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ) && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

# Download and unarchive the Java Development Kit
RUN mkdir -p /opt/jdk && \
    wget -O /tmp/jdk.tar.gz ${JDK_URL} && \
    tar -xf /tmp/jdk.tar.gz --strip 1 --directory /opt/jdk && \
    rm /tmp/jdk.tar.gz

# Set Java environment
ENV JAVA_HOME=/opt/jdk \
    PATH=${JAVA_HOME}/bin:${PATH}

# Expose HTTP 
EXPOSE 1990

# Install Atlassian SDK
RUN wget -O /tmp/atlassian-plugin-sdk-$ATLAS_SDK_VERSION.tar.gz https://packages.atlassian.com/maven/repository/public/com/atlassian/amps/atlassian-plugin-sdk/$ATLAS_SDK_VERSION/atlassian-plugin-sdk-$ATLAS_SDK_VERSION.tar.gz && \
    tar -xf /tmp/atlassian-plugin-sdk-$ATLAS_SDK_VERSION.tar.gz --directory /tmp && \
    ln -s /tmp/atlassian-plugin-sdk-$ATLAS_SDK_VERSION/bin/atlas-* /usr/local/bin && \
    rm /tmp/atlassian-plugin-sdk-$ATLAS_SDK_VERSION.tar.gz

COPY entrypoint.sh  /tmp/entrypoint.sh
CMD ["/tmp/entrypoint.sh"]