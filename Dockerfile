FROM ubuntu:20.04
LABEL maintainer="Aaron Nielsen - apn@apnielsen.com"

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    pandoc \
    pandoc-citeproc \
    curl

RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-full

# get quarto
# ARG QUARTO_VERSION="0.9.522"
# RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
RUN dpkg -i quarto-linux-amd64.deb

# install jupyter
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip
RUN python3 -m pip install jupyter

RUN python3 -m pip install tabulate

RUN python3 -m pip install pandas
