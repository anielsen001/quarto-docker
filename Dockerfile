FROM ubuntu:20.04
LABEL maintainer="Aaron Nielsen - apn@apnielsen.com"

ENV JULIA_VERSION=1.7.3

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    pandoc \
    pandoc-citeproc \
    curl

RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-full

RUN apt-get update && apt-get install -y --no-install-recommends \
    inkscape make wget zip git software-properties-common unzip

RUN apt-add-repository universe
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    qt5-default

# get quarto
# ARG QUARTO_VERSION="0.9.522"
# RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
RUN curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
RUN dpkg -i quarto-linux-amd64.deb

# Install Julia
RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz

RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# install jupyter
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip
RUN python3 -m pip install jupyter

RUN python3 -m pip install tabulate

RUN python3 -m pip install pandas

RUN python3 -m pip install numpy-quaternion

RUN python3 -m pip install scipy

RUN python3 -m pip install matplotlib