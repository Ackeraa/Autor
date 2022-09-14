#!/bin/bash
GITHUB_USERNAME=Ackeraa
GITHUB_PASSWORD=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
commits=$(curl \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_PASSWORD" \
  https://api.github.com/repos/$GITHUB_USERNAME/todo.nvim/commits)

shas=$(echo $commits | sed -n 'N; /^  {.*"sha"/p' log | gawk '/sha/{print $2}' | sed 's/,//')
dates=$(echo $commits | sed -n '/"date"/p' log | uniq | gawk '{print $2}')

#date=`echo $dates | sed -n '/"$(date +%Y-%m-%d -d yesterday)"/{=;q;}'`
if [[ ${dates[0]} = *'2022-07-28'* ]] # I commit today
then # find last day's last commit to compare
    last=1
    for date in $dates
    do
	if [[ $date = *'2022-06-30'* ]]
	then
	    last=$[$last + 1]
	else
	    break
	fi
    done
    if [[ $last > ${#dates[*]} ]] # first day to commit, use first commit to compare
    then
    	last=$[$last - 1]
    fi

fi
