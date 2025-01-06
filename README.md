# Docker setup for Quarto

The container contains
- full tex-live distribution
- libreoffice
- the most recent quarto version
- python and jupyter
- python tabulate and pandas
- julia

There are three versions available for quarto 1.2.x, 1.3.x, 1.4.x, 1.5.x. The 1.6.x series is the current release.
The 1.7.x series is the pre-release.

Now uses a virtual environment for python, located at `/opt/venv`

## Build

Replace `XX` with `12`, `13`, `14`, `15`, `16` or `17` for the quarto version desired.

```bash
docker-compose -f docker-compose.yml build quarto-XX
```

To force a build from scratch 
```bash
docker-compose -f docker-compose.yml build --no-cache quarto-XX
```

## Run

```bash
docker-compose -f docker-compose.yml run quarto-XX
```

This will drop you into a bash shell, test the quarto install

```bash
quarto check
```

## Tag and push to docker hub

```bash
docker tag quarto-XX:develop anielsen/quarto-XX-texlive-python-julia:latest
```

```bash
docker push anielsen/quarto-XX-texlive-python-julia:latest
```

## References

- https://www.r-bloggers.com/2022/07/how-to-set-up-quarto-with-docker-part-1-static-content/
- https://github.com/analythium/quarto-docker-examples
