FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Essentials
RUN apt-get update && apt-get install -y \
    ttyd curl sudo && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# DuckDB installieren (per Install-Skript)
RUN curl https://install.duckdb.org | sh && \
    mv /root/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb && \
    chmod +x /usr/local/bin/duckdb

# Benutzer anlegen
RUN useradd -m -s /bin/bash duckdb && echo "duckdb ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER duckdb
WORKDIR /home/duckdb

EXPOSE 7681

CMD ["ttyd", "--writable", "duckdb"]
