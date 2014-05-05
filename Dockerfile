#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#
 
# Pull base image.
FROM dockerfile/java

# Install ElasticSearch.
 
RUN curl https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz \
    | tar zxvf - -C /opt
RUN ln -s /opt/elasticsearch-1.1.1 /opt/elasticsearch
 
# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
 
VOLUME ["/es-index-data"]
RUN sed -r -i "s/# (path.data: ).*/\1=\/es-index-data/g" /opt/elasticsearch/config/elasticsearch.yml

RUN ["/opt/elasticsearch/bin/plugin", "-install", "elasticsearch/elasticsearch-cloud-aws/2.1.1"]

# Define an entry point.
ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
