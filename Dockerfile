# Reference
# https://omnetpp.org/download/

# Start from Ubuntu 24.04
FROM ubuntu:24.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    xz-utils \
    python3-venv \
    ca-certificates \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

# Create nixbld group and users (required for Nix even in single-user mode)
RUN groupadd -r nixbld && \
    for i in $(seq 1 10); do useradd -r -g nixbld -G nixbld -d /var/empty -s /sbin/nologin nixbld$i; done

# Install Nix manually with proper setup
RUN mkdir -p /nix && \
    curl -L https://releases.nixos.org/nix/nix-2.32.0/nix-2.32.0-x86_64-linux.tar.xz | tar -xJ && \
    cd nix-2.32.0-x86_64-linux && \
    ./install --no-daemon

# Make sure environment is set up for Nix
ENV USER root
ENV PATH /nix/var/nix/profiles/default/bin:/root/.nix-profile/bin:$PATH

# Source Nix environment and test installation
RUN . /root/.nix-profile/etc/profile.d/nix.sh && nix-shell -p hello --run "hello"

# Example: test installation
RUN . /root/.nix-profile/etc/profile.d/nix.sh && nix --version

# Create a python virtual env
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Activate the virtual environment and install packages
RUN /opt/venv/bin/pip install --upgrade pip setuptools wheel && \
    /opt/venv/bin/pip install opp-env

CMD ["/bin/bash"]
