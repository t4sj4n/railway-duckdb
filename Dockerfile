FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Essentials
RUN apt-get update && apt-get install -y \
    ttyd curl sudo net-tools socat netcat unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# DuckDB installieren (per Install-Skript)
RUN curl https://install.duckdb.org | sh && \
    mv /root/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb && \
    chmod +x /usr/local/bin/duckdb

# Benutzer anlegen
#RUN useradd -m -s /bin/bash duckdb && echo "duckdb ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY start.sh /start.sh
RUN chmod +x /start.sh

#USER duckdb
#WORKDIR /home/duckdb

CMD ["/start.sh"]

EXPOSE 7681
EXPOSE 4214
