FROM alpine:3.13.2

ADD setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

ADD mysql-config /etc/cont-init.d/00-configure-mysql
ADD mysql /etc/services.d/mysql

ADD php-fpm /etc/services.d/php-fpm
ADD php.ini /etc/php7/php.ini
ADD www.conf /etc/php7/php-fpm.d/www.conf

ADD nginx-config /etc/cont-init.d/00-configure-nginx
ADD wordpress.conf /etc/nginx/conf.d/wordpress.conf

ENV MYSQL_ROOT_PASSWORD=toor
ENV MYSQL_DATABASE=mdatabase
ENV MYSQL_USER=muser
ENV MYSQL_PASSWORD=mpassword

EXPOSE 80

VOLUME /var/www

ENTRYPOINT ["/init"]

CMD ["nginx", "-g", "daemon off;"]
