FROM debian:buster

RUN apt update\
    && apt install nginx -y\
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/private
COPY ./conf/certificate.cert /etc/ssl/private/certificate.cert
COPY ./conf/certificate.key /etc/ssl/private/certificate.key

WORKDIR /etc/nginx
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN rm -rf sites*\
        conf.d\
        modules*\
        koi-utf\
        koi-win\
        win-utf\
        snippets\
        uwsgi_params\
        scgi_params\
        proxy_params

ENTRYPOINT ["nginx", "-g", "daemon off;"]
