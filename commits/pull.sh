GITHUB_USERNAME=Ackeraa
GITHUB_PASSWORD=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
curl "https://api.github.com/users/$GITHUB_USERNAME/repos?access_token=$GITHUB_PASSWORD" | grep -w clone_url
