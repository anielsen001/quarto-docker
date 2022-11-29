# Docker setup for Quarto

The container contains
- full tex-live distribution
- the most recent quarto version
- python and jupyter


## Build

```bash
docker-compose -f docker-compose.yml build develop
```

## Run

```bash
docker-compose -f docker-compose.yml run develop
```

This will drop you into a bash shell, test the quarto install

```bash
quarto check
```

## References

- https://www.r-bloggers.com/2022/07/how-to-set-up-quarto-with-docker-part-1-static-content/
- https://github.com/analythium/quarto-docker-examples