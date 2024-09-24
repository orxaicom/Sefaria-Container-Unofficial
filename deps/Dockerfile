FROM debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive
ADD install_dependencies.sh /
RUN chmod +x /install_dependencies.sh && \
    /install_dependencies.sh && \
    rm -rf /install_dependencies.sh /var/lib/apt/lists/*
