FROM menci/archlinuxarm:base-devel

ARG DOTBOT_PROFILE=ipad/arch-utm
ARG USERNAME=mnb3000

RUN /usr/bin/useradd -G wheel -m ${USERNAME}
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/${USERNAME}

RUN sudo pacman --noconfirm -Syyu
RUN sudo pacman --noconfirm -S git python3

RUN git clone https://github.com/mnb3000/dotfiles.git ./.dotfiles
# COPY . ./.dotfiles

WORKDIR /home/${USERNAME}/.dotfiles

RUN bash ./scripts/install.sh

CMD zk[ "/usr/bin/bash" ]
