#!/bin/bash
# Generate report in the morning, noon, night, ..., 
# which shoule be specified in the arguments

outputf=rst.html
configf=config/$1

cat config/header > $outputf

scripts=$(cat $configf | tr -d "\n" | grep -o "<script>.*</script>" | sed 's/<script>\|<\/script>//g' | tr -s ' ')
for script in $scripts
do
    ./$script.sh $1 >> $outputf
done

cat config/footer >> $outputf
