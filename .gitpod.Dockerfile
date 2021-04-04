FROM nixpkgs/nix

RUN echo "nix.binaryCaches = [ \"https://nixcache.reflex-frp.org\" ];" > /etc/nixos/configuration.nix
RUN echo "nix.binaryCachePublicKeys = [ \"ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=\" ];" >> /etc/nixos/configuration.nix

RUN mkdir /build
RUN chmod 777 /build
RUN nix-env -f https://github.com/obsidiansystems/obelisk/archive/master.tar.gz -iA command
