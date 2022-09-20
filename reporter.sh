#!/bin/bash
# Generate report in the morning, noon, night, ..., 
# which shoule be specified in the arguments

outputf=rst.html
configf=config/profile.xml

cat config/header > $outputf

profile=$(cat $configf | tr -d "\n" | grep -o "<$1>.*</$1>")
rss=$(echo "$profile" \
	| grep -o "<rss>.*</rss>" \
	| sed 's/<rss>\|<\/rss>//g' \
	| sed -E 's/ +/ /g')
scripts=$(echo "$profile" \
	| grep -o "<script>.*</script>" \
	| sed 's/<script>\|<\/script>//g')

for script in $scripts
do
    if [ $script == 'rss' ]
    then
        ./$script.sh $rss >> $outputf
    else
        ./$script.sh >> $outputf
    fi
done

cat config/footer >> $outputf
