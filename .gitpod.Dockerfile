FROM nixos/nix

RUN set -ex && apk --no-cache add sudo
RUN echo "sandbox = true" > /etc/nix/nix.conf
RUN echo "binary-caches = https://cache.nixos.org https://nixcache.reflex-frp.org" >> /etc/nix/nix.conf
RUN echo "binary-cache-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" >> /etc/nix/nix.conf
RUN echo "binary-caches-parallel-connections = 40" >> /etc/nix/nix.conf

RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    # passwordless sudo for users in the 'sudo' group
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers
RUN mkdir /build
RUN chmod 777 /build
RUN nix-env -f https://github.com/obsidiansystems/obelisk/archive/master.tar.gz -iA command
