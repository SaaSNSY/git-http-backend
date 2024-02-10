FROM nginx:latest

MAINTAINER Neil Youngman neil.youngman@googlemail.com

# The container listens on port 80, map as needed
EXPOSE 80

# This is where the repositories will be stored, and
# should be mounted from the host (or a volume container)
VOLUME ["/git"]

# We need the following:
# - git-daemon, because that gets us the git-http-backend CGI script
# - fcgiwrap, because that is how nginx does CGI
# - spawn-fcgi, to launch fcgiwrap and to create the unix socket
RUN apt-get update
RUN apt-get install -y git-daemon-run fcgiwrap spawn-fcgi
RUN rm -rf /var/cache/apt/*

COPY nginx.conf /etc/nginx/nginx.conf

# launch fcgiwrap via spawn-fcgi; launch nginx in the foreground
# so the container doesn't die on us; supposedly we should be
# using supervisord or something like that instead, but this
# will do
CMD spawn-fcgi -s /run/fcgi.sock /usr/sbin/fcgiwrap && \
    nginx -g "daemon off;"
