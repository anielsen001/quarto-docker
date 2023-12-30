# Docker setup for Quarto

The container contains
- full tex-live distribution
- the most recent quarto version
- python and jupyter
- python tabulate and pandas
- julia

There are three versions available for quarto 1.2.x, 1.3.x and 1.4.x (pre-release). 

## Build

Replace `XX` with `12`, `13` or `14` for the quarto version desired.

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