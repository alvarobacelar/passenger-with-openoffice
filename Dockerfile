FROM phusion/passenger-ruby23

RUN apt-get update && apt-get install libmagick++-dev unzip -y

ENV HOME /root
ENV RAILS_ENV=production 

COPY installopenoffice.sh /tmp/installopenoffice.sh

# Install Libre Office
RUN sh /tmp/installopenoffice.sh && \
    ln -s /opt/libreoffice5.4/program/soffice /bin/soffice && \
    rm -f /etc/service/nginx/down && \
    rm /etc/nginx/sites-enabled/default && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Expose Nginx HTTP service
EXPOSE 80

WORKDIR /home/app/webapp
