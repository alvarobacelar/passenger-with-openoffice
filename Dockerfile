FROM phusion/passenger-ruby23

RUN apt-get update && apt-get install libmagick++-dev unzip -y

ENV HOME /root
ENV RAILS_ENV=production 

COPY installopenoffice.sh /tmp/installopenoffice.sh

# Install Libre Office
RUN sh /tmp/installopenoffice.sh && ln -s /opt/libreoffice5.4/program/soffice /usr/local/soffice

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Expose Nginx HTTP service
EXPOSE 80

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

WORKDIR /home/app/webapp

VOLUME /home/app/webapp

RUN chown -R app:app /home/app/webapp

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

