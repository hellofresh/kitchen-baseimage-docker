FROM phusion/baseimage:0.9.18
MAINTAINER Adham Helal <aa@hellofresh.com>

ENV DEBIAN_FRONTEND=noninteractive

# Install python openssh and curl for test-kitchen
RUN apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common python openssh-server \
                                               
# Install chef for busser and ruby :)
RUN curl -s https://www.getchef.com/chef/install.sh > /tmp/install.sh && \
    sudo sh /tmp/install.sh -d /tmp

# ENV for busser
ENV BUSSER_ROOT         /tmp/verifier
ENV GEM_HOME            /tmp/verifier/gems
ENV GEM_PATH            /tmp/verifier/gems
ENV GEM_CACHE           /tmp/verifier/gems/cache
ENV ruby                /opt/chef/embedded/bin/ruby
ENV gem                 /opt/chef/embedded/bin/gem
ENV gem_install_args    "busser --no-rdoc --no-ri --no-format-executable -n /tmp/verifier/bin --no-user-install"

# Install busser serverspec, ...
COPY ./scripts/busser_install.sh /tmp/busser_install.sh
RUN  /bin/sh /tmp/busser_install.sh

# Update to security package
RUN apt-get update && apt-get -y -o Dpkg::Options::="--force-confdef" \
    dist-upgrade