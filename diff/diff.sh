#!/bin/bash

echo > diff.html

GITHUB_USERNAME=Ackeraa
repos=$(curl https://api.github.com/users/$GITHUB_USERNAME/repos \
	| grep -w clone_url | sed 's/,/\n/g' | gawk '{ print $2 }' \
	| gawk -F/ '{ print $5 }' | sed 's/"//; s/\.git$//')

for repo in ${repos[1, 2]}
do
    commits=$(curl https://api.github.com/repos/$GITHUB_USERNAME/$repo/commits)
    shas=($(echo "$commits" | sed -n 'N; /^  {.*"sha"/p' | gawk '/sha/{print $2}' | sed 's/,//; s/"//g'))
    dates=($(echo "$commits" | sed -n '/"date"/p' | uniq | gawk '{print $2}' | sed 's/"//g'))

    #date=`echo $dates | sed -n '/"$(date +%Y-%m-%d -d yesterday)"/{=;q;}'`

    if [[ ${dates[0]} = '2022-07-28'* ]] # I commit today
    then # find last day's last commit to compare
	last=0
	for date in ${dates[*]}
	do
	    if [[ $date = *'2022-07-28'* ]]
	    then
		last=$[$last + 1]
	    else
		break
	    fi
	done
	if [ $last -ge ${#dates[*]} ] # first day to commit, use first commit to compare
	then
	    last=$[$last - 1]
	fi
    fi

    osha=${shas[1]} 
    nsha=${shas[0]}

    echo "Getting diff from https://github.com/$GITHUB_USERNAME/$repo/compare/$osha...$nsha.diff" 

    curl "https://github.com/$GITHUB_USERNAME/$repo/compare/$osha...$nsha.diff" | ./diff2html.sh >> diff.html

done
