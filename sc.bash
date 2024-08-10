#!/usr/bin/env bash
while true; do
  ps -ax | grep -v grep | grep nvim-asciidoc-preview > /dev/null && echo "Running..." || echo "Not running."
  sleep 0.1 # Check every 5 seconds
done

