FROM centos:7
RUN yum install httpd -y
RUN service httpd start
COPY index.html /var/www/html/

