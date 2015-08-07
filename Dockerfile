FROM nginx
MAINTAINER Mikael Ganehag Brorsson <mikael.brorsson@gmail.com>

RUN \
  apt-get update && \
  apt-get install -y \
	supervisor \
	php5 \
	php5-fpm && \
  \
  \
  echo "====> clean up..." && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  sed -i 's/www-data/nginx/g' /etc/php5/fpm/pool.d/www.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx-default.conf /etc/nginx/conf.d/default.conf
COPY public /var/www/public

CMD ["/usr/bin/supervisord"]
