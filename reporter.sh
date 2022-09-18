#!/bin/bash
# Generate report in the morning, noon, night, ..., 
# which shoule be specified in the arguments
echo "FIUC $ENV"
__dir=$(dirname "$0")
outputf=$__dir/data/$1.html
configf=$__dir/config/$1

cat $__dir/config/header > $outputf

scripts=$(cat $configf | tr -d "\n" | grep -o "<script>.*</script>" | sed 's/<script>\|<\/script>//g' | tr -s ' ')
for script in $scripts
do
    $__dir/$script.sh $1
    cat $__dir/data/$script.html >> $outputf
done


cat $__dir/config/footer >> $outputf
