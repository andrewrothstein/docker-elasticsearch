FROM dockerfile/elasticsearch
MAINTAINER "Andrew Rothstein" andrew.rothstein@gmail.com

RUN ["/elasticsearch/bin/plugin", "-install", "elasticsearch/elasticsearch-cloud-aws/2.4.1"]
