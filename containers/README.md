# Containers

Common development environment meant to be used with Docker. Hosted on the GitHub Container Registry and built on top of the openvscode-server image.

Image: `ghcr.io/danielwaltz/vscode:latest`

## Build

```shell
docker build -t danielwaltz/vscode:latest .
```

## Pull

```shell
docker pull ghcr.io/danielwaltz/vscode:latest
```

## Usage

### Docker CLI

```shell
docker run -it \
  --rm \
  --name vscode \
  -p 3000:3000 \
  -v "$PWD":/home/daniel/workspace \
  ghcr.io/danielwaltz/vscode:latest
```

### Docker Compose

```yml
services:
  vscode:
    image: ghcr.io/danielwaltz/vscode:latest
    restart: unless-stopped
    ports:
      - 3000
    volumes:
      - .:/home/daniel/workspace # optionally mount host directories
      - vscode_data:/home
volumes:
  vscode_data:
```
