FROM centos:7
RUN yum install nginx -y
RUN service nginx start
COPY file.txt /var

