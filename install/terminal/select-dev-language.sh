#!/bin/bash

# Install default programming languages
LANGS="${PEGASUS_FIRST_RUN_LANGUAGES:-$OMAKUB_FIRST_RUN_LANGUAGES}"
if [[ -n "$LANGS" ]]; then
  languages=$LANGS
else
  AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi

if [[ -n "$languages" ]]; then
  for language in $languages; do
    case $language in
    Ruby)
      mise use --global ruby@latest
      mise settings add idiomatic_version_file_enable_tools ruby
      mise x ruby -- gem install rails --no-document
      ;;
    Node.js)
      mise use --global node@lts
      ;;
    Go)
      mise use --global go@latest
      ;;
    PHP)
      sudo dnf -y install php php-{cli,curl,intl,mbstring,opcache,pgsql,mysqlnd,pdo,xml,zip}
      php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
      php composer-setup.php --quiet && sudo mv composer.phar /usr/local/bin/composer
      rm composer-setup.php
      ;;
    Python)
      mise use --global python@latest
      ;;
    Elixir)
      mise use --global erlang@latest
      mise use --global elixir@latest
      mise x elixir -- mix local.hex --force
      ;;
    Rust)
      bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
      ;;
    Java)
      mise use --global java@latest
      ;;
    esac
  done
fi
