#!/bin/bash
rm -f /run/php/php7.4-fpm.sock
exec php-fpm7.4 -F
