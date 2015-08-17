FROM ubuntu:trusty
MAINTAINER Sandro Mello <sandromll@gmail.com>

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
   wget \
   git \
   apt-transport-https \
   build-essential \
   ca-certificates \
   libio-socket-ssl-perl \
   libdigest-hmac-perl \
   libdigest-hmac-perl \
   libterm-readkey-perl \
   libterm-readkey-perl \
   libdate-manip-perl \
   libdate-manip-perl \
   libmail-imapclient-perl \
   libssl-dev
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN perl -MCPAN -e "install 'Mail::IMAPClient'" && \
    perl -MCPAN -e "install 'Term::ReadKey'" && \
    perl -MCPAN -e "install 'IO::Socket::SSL'" && \
    perl -MCPAN -e "install 'Digest::HMAC_MD5'" && \
    perl -MCPAN -e "install 'URI::Escape'" && \
    perl -MCPAN -e "install 'File::Copy::Recursive'" && \
    perl -MCPAN -e "install 'IO::Tee'" && \
    perl -MCPAN -e "install 'Unicode::String'" && \
    perl -MCPAN -e "install 'Data::Uniqid'" && \
    perl -MCPAN -e "install 'Authen::NTLM'" && \
    perl -MCPAN -e "install 'JSON::WebToken'" && \
    perl -MCPAN -e "install 'LWP/UserAgent.pm'" && \
    perl -MCPAN -e "install 'LWP::Protocol::https'" && \
    perl -MCPAN -e "install 'Crypt::OpenSSL::RSA'"
    
WORKDIR /
ADD Migrator-6b319ccce4a6-Automatos.p12 /
RUN git clone https://github.com/sandromello/imapsync.git
RUN cd imapsync \
   && make \
   && make install

ENTRYPOINT ["imapsync"]
