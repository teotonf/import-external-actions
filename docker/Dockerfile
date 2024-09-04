FROM ubuntu:latest as base
LABEL maintainer "Frederico Bedê <bede.apps@gmail.com>"

RUN apt-get update && apt-get install -y\
  tar\
  wget\
  gnupg\
  unzip
 
ARG PRODUCT=terraform
ARG VERSION=1.9.1

ARG TMP_APPS_DIR=/tmp/apps/install

RUN mkdir -p ${TMP_APPS_DIR}

# Download and install terraform
RUN cd ${TMP_APPS_DIR} && \
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip && \
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS && \
  wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig && \
  wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import && \
  gpg --verify ${PRODUCT}_${VERSION}_SHA256SUMS.sig ${PRODUCT}_${VERSION}_SHA256SUMS && \
  grep ${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS | sha256sum -c && \
  unzip ${TMP_APPS_DIR}/${PRODUCT}_${VERSION}_linux_amd64.zip -d /tmp/apps

FROM ubuntu:latest

ARG USER=guest

RUN apt-get update && apt-get install -y\
  git\
  ca-certificates\
  openssh-client\
  sshpass

COPY ./*.pem /usr/local/share/ca-certificates/

RUN chmod 644 /usr/local/share/ca-certificates/*.pem &&\
  update-ca-certificates

COPY --from=base /tmp/apps/* /usr/local/bin/

# Create a new user
RUN useradd -ms /bin/bash ${USER}

# Switch to the new user
USER ${USER}

WORKDIR /home/${USER}
