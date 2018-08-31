FROM fluent/fluentd:v1.2.5-debian-onbuild



RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install \
        fluent-plugin-elasticsearch \
 && sudo gem install \
        fluent-plugin-secure-forward \
 && sudo gem install \
        fluent-plugin-record-reformer \
 && sudo gem install \
        fluent-plugin-rancher \
 && sudo gem install \
        fluent-plugin-kubernetes \
 && sudo gem install \
        fluent-plugin-prometheus \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem