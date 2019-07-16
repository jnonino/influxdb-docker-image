FROM influxdb
LABEL maintainer="Julian Nonino <noninojulian@gmail.com>"

# Install InfluxDB
#RUN curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add - && \
#    source /etc/lsb-release && \
#    echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list && \
#    apt-get update && \
#    apt-get install influxdb && \
#    rm -rf /etc/influxdb/influxdb.conf

# Copy Configuration
RUN rm -rf /etc/influxdb/influxdb.conf
COPY influxdb.conf /etc/influxdb/influxdb.conf
ENV INFLUXDB_CONFIG_PATH /etc/influxdb/influxdb.conf

# Copy CollectD DB Types
COPY types.db /usr/share/collectd/types.db

# Expose Ports
#   - 2003: The default port that runs the Graphite service
#   - 4242: The default port that runs the OpenTSDB service
#   - 8086: client-server communication over InfluxDB’s HTTP API
#   - 8088: RPC service for backup and restore 
#   - 8089: The default port that runs the UDP service
#   - 25826: The default port that runs the Collectd service
EXPOSE 2003 4242 8086 8088 8089 25826

ENTRYPOINT ["/entrypoint.sh"]
CMD ["influxd"]