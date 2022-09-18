#!/bin/bash
# Get today's code diff.

diff2f=./diff2html.sh
GITHUB_USERNAME=Ackeraa

today=$(TZ=UTC-8 date +%Y-%m-%d)
repos=($(curl --silent https://api.github.com/users/$GITHUB_USERNAME/repos \
	| grep -w clone_url | sed 's/,/\n/g' | gawk '{ print $2 }' \
	| gawk -F/ '{ print $5 }' | sed 's/"//; s/\.git$//'))

for repo in ${repos[6]}
do
    commits=$(curl --silent https://api.github.com/repos/$GITHUB_USERNAME/$repo/commits)
    shas=($(echo "$commits" | sed -n 'N; /^  {.*"sha"/p' | gawk '/sha/{print $2}' | sed 's/,//; s/"//g'))
    dates=($(echo "$commits" | sed -n '/"date"/p' | uniq | gawk '{print $2}' | sed 's/"//g'))

    if [[ ${dates[0]} = *"$today"* ]] # I commited today
    then # find last day's last commit to compare
	last=0
	for date in ${dates[*]}
	do
	    if [[ $date = *"$today"* ]]
	    then
		last=$[$last + 1]
	    else
		break
	    fi
	done
	if [ $last -eq ${#dates[*]} ] # repo was just created today, use first commit to compare
	then
	    last=$[$last - 1]
	fi
	osha=${shas[$last]} 
	nsha=${shas[0]}
	echo "<h1>$repo</h1>"
	curl --silent "https://github.com/$GITHUB_USERNAME/$repo/compare/$osha...$nsha.diff" | $diff2f
    fi
done
