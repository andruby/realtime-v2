FROM buildpack-deps:xenial

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# Install Node.js
WORKDIR /tmp
RUN wget https://nodejs.org/dist/v7.3.0/node-v7.3.0.tar.gz && \
    tar -xzvf node-v7.3.0.tar.gz && \
    cd node-v7.3.0 && \
    ./configure && \
    make && \
    make install
RUN rm -r /tmp/node-v7.3.0*

# Install Ruby & foreman
RUN apt-get update
RUN apt-get install -y ruby-full
RUN gem install foreman

ADD . /app
WORKDIR /app

# Install app dependencies
RUN npm install

CMD foreman start
