#!/usr/bin/env zsh

while inotifywait -qq --event modify $(find ~/Devel/Personal/micro/featherboa -name '*.py' -print )
  do
    ./send.sh
  done

