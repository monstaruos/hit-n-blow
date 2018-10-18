#!/bin/sh

docker run --rm -t -i -v $(pwd):/hit-n-blow ruby:2.5.1-slim /hit-n-blow/hit-n-blow.rb
