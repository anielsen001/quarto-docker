FROM registry.gitlab.com/islandoftex/images/texlive:latest

LABEL maintainer="Aaron Nielsen - apn@apnielsen.com"

ENV JULIA_VERSION=1.7.3
ENV PANDOC_VERSION=3.1.9
ARG QUARTO_VERSION="1.3.450"

RUN apt-get update

RUN apt-get install -y --no-install-recommends ca-certificates
RUN update-ca-certificates 

RUN apt-get install -y --no-install-recommends curl

# Get a more recent version of pandoc
RUN curl -o pandoc-amd64.deb -L https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb
RUN dpkg -i pandoc-amd64.deb

#RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ="America/New_York" apt-get install -y --no-install-recommends \
#    texlive-full

RUN apt-get update && apt-get install -y --no-install-recommends \
    inkscape make wget zip git software-properties-common unzip

#RUN apt-add-repository universe
#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
#    qt5-default

# get quarto
RUN curl -o quarto-linux-amd64.deb -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb
#RUN curl -LO https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.340/quarto-1.3.340-linux-amd64.deb
#RUN curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
RUN dpkg -i quarto-linux-amd64.deb

# Install Julia
RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz

RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# install jupyter
RUN apt-get update && \ 
    apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev \
    python3-tk

RUN python3 -m pip install --break-system-packages jupyter jupyter-cache

RUN python3 -m pip install --break-system-packages tabulate

RUN python3 -m pip install --break-system-packages pandas

RUN python3 -m pip install --break-system-packages numpy-quaternion

RUN python3 -m pip install --break-system-packages scipy

RUN python3 -m pip install --break-system-packages matplotlib