FROM goharbor/nginx-photon:dev
USER root
WORKDIR home
RUN tdnf update -y && tdnf install -y pcre-devel openssl-devel gcc curl perl make glibc-devel linux-api-headers binutils zlib-devel wget coreutils bindutils-9.16.15-1.ph4.x86_64
RUN wget https://openresty.org/download/openresty-1.19.3.1.tar.gz && tar -xzf openresty-1.19.3.1.tar.gz && cd openresty-1.19.3.1 && ./configure && make && make install
#USER nginx
# CMD ["/usr/local/openresty/bin/openresty", "-p", "/root/hello", "-g", "daemon off;"]
#RUN chown -R nginx:nginx /etc/nginx
USER nginx
CMD ["/usr/local/openresty/bin/openresty", "-p", "/etc/nginx", "-g", "daemon off;"]
#CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
