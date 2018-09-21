FROM ruby:2.5.1

ENV RUBY_INC /usr/local/include/ruby-2.5.0/
ENV RUBY_LIB /usr/local/lib

RUN apt-get update && apt-get install unzip && rm -rf /var/lib/apt/lists

WORKDIR /tmp
RUN wget https://github.com/rryqszq4/ngx_ruby/archive/master.zip && unzip master.zip && mv ngx_ruby-master ngx_ruby && \
  wget http://nginx.org/download/nginx-1.6.3.tar.gz && tar xf nginx-1.6.3.tar.gz && \
  rm master.zip nginx-1.6.3.tar.gz

WORKDIR /tmp/nginx-1.6.3
RUN ./configure --user=www --group=www --prefix=/nginx --add-module=/tmp/ngx_ruby && make && make install

COPY nginx.conf /nginx/conf/nginx.conf
ADD main.rb /

RUN useradd -m www

CMD /nginx/sbin/nginx -g "daemon off;"
