FROM ngnix:alpine
COPY ./ngnix.comf /etc/ngnix/ngnix.conf
COPY ./webpage/.html /usr/share/ngnix/html
EXPOSE 80
CMD ["ngnix", "-g", "daemon off;"]
