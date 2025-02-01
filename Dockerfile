ARG BASE_IMAGE=bash:devel-alpine3.21

FROM ${BASE_IMAGE}

ARG DOTBOT_PROFILE=ipad/alpine-utm
ARG DOTBOT_TARGET=alpine
ARG USERNAME=mnb3000

WORKDIR /home/${USERNAME}

# RUN git clone --recursive https://github.com/mnb3000/dotfiles.git ./.dotfiles
COPY . ./.dotfiles

WORKDIR /home/${USERNAME}/.dotfiles

RUN bash ./scripts/prebuild.sh

RUN [ "bash", "-c", "chsh -s /bin/bash" ]
RUN chown -R ${USERNAME} ../

USER ${USERNAME}
RUN mkdir -p ../.config

RUN bash ./scripts/install.sh

CMD [ "/bin/zsh" ]
