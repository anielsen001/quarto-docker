# Docker setup for Quarto

The container contains
- full tex-live distribution
- the most recent quarto version
- python and jupyter
- python tabulate and pandas
- julia


## Build

```bash
docker-compose -f docker-compose.yml build quarto
```

To force a build from scratch 
```bash
docker-compose -f docker-compose.yml build --no-cache quarto
```

## Run

```bash
docker-compose -f docker-compose.yml run quarto
```

This will drop you into a bash shell, test the quarto install

```bash
quarto check
```

## Tag and push to docker hub

```bash
docker tag quarto:develop anielsen/quarto-texlive-python-julia:latest
```

```bash
docker push anielsen/quarto-texlive-python-julia:latest
```

## References

- https://www.r-bloggers.com/2022/07/how-to-set-up-quarto-with-docker-part-1-static-content/
- https://github.com/analythium/quarto-docker-examples