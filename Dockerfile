#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM docker.io/java:openjdk-7-jdk

ENV ES_VER 1.5.2
ENV ES_CLOUD_AWS_VER 2.5.0

ENV ES_PKG_NAME elasticsearch-${ES_VER}

# Install ElasticSearch.
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/${ES_PKG_NAME}.tar.gz && \
  tar xvzf ${ES_PKG_NAME}.tar.gz && \
  rm -f ${ES_PKG_NAME}.tar.gz && \
  mv /${ES_PKG_NAME} /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Install plugins...
RUN /elasticsearch/bin/plugin -i elasticsearch/elasticsearch-cloud-aws/${ES_CLOUD_AWS_VER}
RUN ["/elasticsearch/bin/plugin", "-l"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200 9300
