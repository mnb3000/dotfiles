variable "USERNAME" {
    default = "mnb3000"
}

variable "APP" {
    default = "dotfiles-image"
}

variable "RELEASE" {
    default = "testing"
}

variable "ARCH_BASE_IMAGE" {
  default = "menci/archlinuxarm:base-devel"
}

variable "ALPINE_BASE_IMAGE" {
  default = "bash:devel-alpine3.21"
}

variable "DEBIAN_BASE_IMAGE" {
  default = "debian:testing-slim"
}

variable "UBUNTU_BASE_IMAGE" {
  default = "ubuntu:22.04"
}

# target "docker-metadata-action" {}

target "_common" {
  args = {
    USERNAME = "${USERNAME}"
  }
  dockerfile = "Dockerfile"
}

target "_common-arm" {
  platforms = ["linux/aarch64"]
}

target "docker-metadata-action" {}

target "all-arm" {
  inherits = ["_common", "_common-arm", "docker-metadata-action"]
  name = "${distro}"
  tags = ["${USERNAME}/${APP}:${distro}-${RELEASE}"]
  args = {
    DOTBOT_TARGET = distro
  }
  matrix = {
    distro = ["arch", "alpine", "alpine-minimal", "debian-minimal"]
  }
}

target "all-x86" {
  inherits = ["_common", "docker-metadata-action"]
  name = "${distro}"
  tags = ["${USERNAME}/${APP}:${distro}-${RELEASE}"]
  args = {
    DOTBOT_TARGET = distro
  }
  matrix = {
    distro = ["ubuntu-minimal", "alpine-webvm", "debian-webvm"]
  }
}

target "arch" {
  inherits = ["_common", "_common-arm", "docker-metadata-action"]
  args = {
    DOTBOT_TARGET = "arch"
    DOTBOT_PROFILE = "utm/arch-utm"
    BASE_IMAGE = ARCH_BASE_IMAGE
  }
}

target "alpine" {
  inherits = ["_common", "_common-arm", "docker-metadata-action"]
  args = {
    DOTBOT_TARGET = "alpine"
    DOTBOT_PROFILE = "utm/alpine-utm"
    BASE_IMAGE = ALPINE_BASE_IMAGE
  }
}

target "alpine-minimal" {
  inherits = ["_common", "_common-arm", "docker-metadata-action"]
  args = {
    DOTBOT_TARGET = "alpine"
    DOTBOT_PROFILE = "minimal/alpine"
    BASE_IMAGE = ALPINE_BASE_IMAGE
  }
}

target "debian-minimal" {
  inherits = ["_common", "_common-arm", "docker-metadata-action"]
  args = {
    DOTBOT_TARGET = "debian"
    DOTBOT_PROFILE = "minimal/debian"
    BASE_IMAGE = DEBIAN_BASE_IMAGE
  }
}

target "ubuntu-minimal" {
  inherits = ["_common", "docker-metadata-action"]
  args = {
    DOTBOT_TARGET = "ubuntu"
    DOTBOT_PROFILE = "minimal/ubuntu"
    BASE_IMAGE = UBUNTU_BASE_IMAGE
  }
  platforms = ["linux/amd64"]
}

target "alpine-webvm" {
  inherits = ["_common", "docker-metadata-action"]
  args = {
    DOTBOT_TARGET = "alpine"
    DOTBOT_PROFILE = "webvm/alpine"
    BASE_IMAGE = ALPINE_BASE_IMAGE
  }

  platforms = ["linux/386"]
}

target "debian-webvm" {
  inherits = ["_common", "docker-metadata-action"]
  args = {
    DOTBOT_TARGET = "debian"
    DOTBOT_PROFILE = "webvm/debian"
    BASE_IMAGE = "i386/${DEBIAN_BASE_IMAGE}"
  }

  platforms = ["linux/386"]
}
