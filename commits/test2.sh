#!/bin/bash

GITHUB_USERNAME=Ackeraa
GITHUB_PASSWORD=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

curl \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_PASSWORD" \
  https://api.github.com/repos/$GITHUB_USERNAME/todo.nvim/compare/943ba29d3c504f694235ec93d9895a68adf4e552...main
