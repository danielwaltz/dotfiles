FROM gitpod/openvscode-server:latest

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		ca-certificates \
		curl \
		file \
		git \
		openssh-client \
		procps \
		zsh \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /usr/bin/zsh daniel

RUN mkdir -p /home/linuxbrew/.linuxbrew \
	&& chown -R daniel:daniel /home/linuxbrew

USER daniel
ENV HOME=/home/daniel

RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

RUN brew update \
	&& brew install chezmoi \
	&& brew cleanup -s \
	&& rm -rf "${HOME}/.cache/Homebrew"

RUN chezmoi init --apply danielwaltz

USER daniel
