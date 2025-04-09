FROM registry.access.redhat.com/ubi9/ubi:9.5-1744101466 as base

WORKDIR /tmp/guidellm-build

# Install dependencies
RUN dnf install -y \
    python3.12 \
    python3.12-pip \
    git

RUN git clone https://github.com/neuralmagic/guidellm && cd guidellm
COPY disable_secure_patch /tmp/disable_secure_patch
RUN ls

WORKDIR /tmp/guidellm-build/guidellm
# Apply the patch to disable the ssl verify
RUN git apply /tmp/disable_secure_patch

RUN pip3.12 install .

RUN rm -rf /tmp/guidellm-build

# Create a non-root user
RUN useradd -u 1001 -m guidellm
USER guidellm
WORKDIR /home/guidellm

# Make /home/guidellm is writable only by the user
RUN chmod 700 /home/guidellm