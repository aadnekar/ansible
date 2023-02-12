FROM ubuntu:jammy AS base
WORKDIR /home/temp
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install sudo && \
    apt-get install -y software-properties-common curl git build-essential && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS aadneka
ARG TAGS
RUN addgroup --gid 1000 aadneka
RUN adduser --gecos aadneka --uid 1000 --gid 1000 --disabled-password aadneka
RUN usermod -aG sudo aadneka
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER aadneka
WORKDIR /home/aadneka
COPY --chown=aadneka:aadneka . .

#FROM aadne
#COPY . .
#CMD /bin/bash
#CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]

