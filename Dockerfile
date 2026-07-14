FROM debian:bookworm-20260713-slim

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
