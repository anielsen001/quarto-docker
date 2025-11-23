# Container setup for Quarto

Works with both `docker` and `podman`. 

The container contains
- full tex-live distribution
- libreoffice
- the most recent quarto version
- python and jupyter
- python tabulate and pandas
- julia
- bibtool

There are three versions available for quarto 1.2.x, 1.3.x, 1.4.x, 1.5.x. The 1.8.x series is the current release.

Now uses a virtual environment for python, located at `/opt/venv`

## Build

Replace `XX` with `12`, `13`, `14`, `15`, `16`, `17`, `18` for the quarto version desired.

```bash
docker-compose -f docker-compose.yml build quarto-XX
```
or
```bash
podman-compose -f docker-compose.yml build quarto-XX
```

To force a build from scratch 
```bash
docker-compose -f docker-compose.yml build --no-cache quarto-XX
```
or
```bash
pdoman-compose -f docker-compose.yml build --no-cache quarto-XX
```

## Run

```bash
docker-compose -f docker-compose.yml run quarto-XX
```
or
```bash
podman-compose -f docker-compose.yml run quarto-XX
```

This will drop you into a bash shell, test the quarto install

```bash
quarto check
```

## Tag and push to github container registry (ghcr)

```bash
docker tag quarto-XX:develop ghcr.io/anielsen001/quarto-docker/quarto-XX-texlive-python-julia:latest
```
or
```bash
podman tag quarto-XX:develop ghcr.io/anielsen001/quarto-docker/quarto-XX-texlive-python-julia:latest
```

```bash
docker push ghcr.io/anielsen001/quarto-docker/quarto-XX-texlive-python-julia:latest
```
or 
```bash
podman push ghcr.io/anielsen001/quarto-docker/quarto-XX-texlive-python-julia:latest
```


for ghcr.io you need to create api keys here as described here 
https://docs.github.com/en/packages/learn-github-packages/connecting-a-repository-to-a-package

## References

- https://www.r-bloggers.com/2022/07/how-to-set-up-quarto-with-docker-part-1-static-content/
- https://github.com/analythium/quarto-docker-examples
