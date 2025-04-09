FROM registry.access.redhat.com/ubi9/ubi:9.5-1744101466 as base

# Install dependencies
RUN dnf install -y \
    python3.12 \
    python3.12-pip \
    git

RUN pip3.12 install git+https://github.com/neuralmagic/guidellm@main

# Create a non-root user
RUN useradd -u 1001 -m guidellm
USER guidellm
WORKDIR /home/guidellm

# Make /home/guidellm is writable only by the user
RUN chmod 700 /home/guidellm