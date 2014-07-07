FROM andrewrothstein/docker-java
MAINTAINER Andrew Rothstein "andrew.rothstein@gmail.com"

RUN wget -O- https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.tar.gz \
    | tar zxvf - -C /opt
RUN ln -s /opt/elasticsearch-1.2.1 /opt/elasticsearch
RUN ["/opt/elasticsearch/bin/plugin", "-install", "elasticsearch/elasticsearch-cloud-aws/2.2.0"]
 
# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
 
VOLUME ["/es-index-data"]
RUN sed -r -i "s/#(path.data: ).*/\1\/es-index-data/g" /opt/elasticsearch/config/elasticsearch.yml
RUN sed -r -i "s/#(cluster.name: elasticsearch)/\1/g" /opt/elasticsearch/config/elasticsearch.yml

CMD ["/opt/elasticsearch/bin/elasticsearch"]
