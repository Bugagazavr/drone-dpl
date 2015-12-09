FROM alpine:edge

RUN apk --update add \
  ca-certificates \
  ruby \
  ruby-bundler \
  git \
  ruby-dev && \
  gem install dpl --no-ri --no-rdoc && \
  rm -fr /usr/share/ri

