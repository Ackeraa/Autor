#!/bin/bash
# Get today's code diff.

diff2f=./diff2html.sh

today=$(date -d $(TZ=UTC-8 date -d '-2 day' +%Y-%m-%d) +"%Y-%m-%dT%H:%M:%S%z")
today="2022-09-18T00:00:00+0800"
repos=($(curl --silent "https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100" \
	| grep -w clone_url | sed 's/,/\n/g' | gawk '{ print $2 }' \
	| gawk -F/ '{ print $5 }' | sed 's/"//; s/\.git$//'))
echo "$repos"

for repo in ${repos[*]}
do
    shas=($(curl --silent "https://api.github.com/repos/$GITHUB_USERNAME/$repo/commits?since=$today&per_page=100" \
    	| sed -n '/"sha"/p' \
	| gawk '/sha/{print $2}' \
	| sed 's/,\|"//g'))

    if [ ${#shas[*]} -gt 0 ]; # I commited today
    then
	osha=${shas[-1]} 
	nsha=${shas[0]}
	echo "<h1>$repo</h1>"
	echo "https://github.com/$GITHUB_USERNAME/$repo/compare/$osha...$nsha.diff" 
	curl --silent "https://github.com/$GITHUB_USERNAME/$repo/compare/$osha...$nsha.diff" | $diff2f 
    fi
done
