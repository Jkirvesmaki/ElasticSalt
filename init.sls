#makes sure jdk is installed to ensure elasticsearch works
default-jdk:
  pkg.installed

#adds apt-key 
/etc/apt/trusted.gpg.d/elastickey.gpg: 
  file.managed:
    - source: salt://elasticsearch/elastickey.gpg

#adds source for apt-get install
/etc/apt/sources.list.d/elastic-7x.x.list:
  file.managed:
    - source: salt://elasticsearch/elastic-7.x.list

#refreshes apt and installs elasticsearch
install:
  pkg.installed:
    - refresh: true
    - pkgs:
      - elasticsearch

#puts config files in place
/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://elasticsearch/elasticsearch.yml

#ensures elasticsearch is running and enables elasticsearch to run on startup
elasticsearch:
  service.running:
    - enable: True
    - reload: True

#ensures curl is installed
curl:
  pkg.installed

#GET request to localhost:9200 to ensure everything works
'curl localhost:9200':
  cmd.run
