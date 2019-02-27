# Docker PHP-FPM 7.3 & Nginx 1.15.9 on Alpine Linux
Example PHP-FPM 7.3 & Nginx 1.15.9 setup for Docker, build on [Alpine Linux](http://www.alpinelinux.org/).

### Reference:

* [TrafeX/docker-php-nginx][1]: nginx and php configures.
* [NGINX built with BoringSSL & TLSv1.3][2]: nginx 1.15.9 mainline docker image
* [PHP Repositories for Alpine - by CODECASTS][3]:  Up-to-date, PHP 7.3 packages for Alpine Linux
* [Setting up nginx and PHP-FPM in Docker with Unix Sockets][4]: switch to using Unix sockets by modifing nginx.conf


#### nginx.conf

```nginx 
http {
  .......
  # site.conf
    upstream _php { 
    server unix:/var/www/html/tmp/docker.sock;
    }
  .......
  server {  
      location ~ \.php$ {
                try_files $uri =404;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                #fastcgi_pass  127.0.0.1:9000;
                fastcgi_pass _php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                fastcgi_param SCRIPT_NAME $fastcgi_script_name;
                fastcgi_index index.php;
                include fastcgi_params;
      }

```

[1]: https://github.com/TrafeX/docker-php-nginx
[2]: https://github.com/nginx-modules/docker-nginx-boringssl
[3]: https://github.com/codecasts/php-alpine
[4]: https://medium.com/@shrikeh/setting-up-nginx-and-php-fpm-in-docker-with-unix-sockets-6fdfbdc19f91
