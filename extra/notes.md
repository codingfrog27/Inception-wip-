NEW NOTES



going better, think im close, only wordpress seems to not work yet

could study changes

but rn 1 the health check for wordpress is wrong
and 2 it should listen to TCP port 9000 for nginx








php-fpm in WordPress container → listen on TCP 9000

nginx container → proxy_pass to wordpress:9000

nginx container → listen on 443

WordPress container healthcheck → check port 9000 TCP listening OR skip HTTP curl

nginx container healthcheck → check HTTP on port 443












debconf: delaying package configuration, since apt-utils is not installed

DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/


writing new private key to '/etc/nginx/ssl/inception.key

ERROR: for mariadb  Cannot start service mariadb: network inception not found
ERROR: No containers to start
ERROR: 1



! wordpress Warning manifest for wordpress:user not found: manifest unknown: manifest unknown                                                     1.1s 
 ! nginx Warning     manifest for nginx:user not found: manifest unknown: manifest unknown   