FROM dockerfile/elasticsearch
MAINTAINER "Andrew Rothstein" andrew.rothstein@gmail.com

RUN ["/elasticsearch/bin/plugin", "-i", "elasticsearch/elasticsearch-cloud-aws/2.4.1"]
RUN ["/elasticsearch/bin/plugin", "-l"]
