FROM debian:bookworm-20261005-slim@sha256:7c7b2c966bc9ee8cedfeef67e0e279108992c77681fa595db4a9d65c06ccc587

RUN apt-get update \
    && apt-get install -y git rsync openssh-client \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

ARG CACHEBUST=1 
RUN git clone --recursive https://github.com/koopycat/simple-server-backup.git /backup-script

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["backup"]
