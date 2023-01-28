FROM ubuntu:jammy AS base
ARG TAGS
WORKDIR /usr/local/bin
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y software-properties-common && apt-add-repository -y ppa:ansible/ansible && apt-get install -y curl git ansible build-essential
COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml"]