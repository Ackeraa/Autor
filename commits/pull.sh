#!/bin/bash
GITHUB_USERNAME=Ackeraa
GITHUB_PASSWORD=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
repos=$(curl \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_PASSWORD" \
  https://api.github.com/users/$GITHUB_USERNAME/repos \
  | grep -w clone_url)

for repo in `echo $repos | sed 's/,/\n/g' | gawk '{ print $2 }'` 
do
    echo $repo
done

curl \
  -H "Accept: application/vnd.github+json" \ 
  -H "Authorization: Bearer $GITHUB_PASSWORD" \
  https://api.github.com/repos/$GITHUB_USERNAME/todo/commits
