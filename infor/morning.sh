#!/bin/bash

__dir=$(dirname "$0")
cat $__dir/header.html > $__dir/morning.html

#../weather/weather.sh 
#../news/news.sh 
../diff/diff.sh

#cat ../weather/weather.html >> morning.html
#cat ../news/news.html >> morning.html
cat ../diff/diff.html >> $__dir/morning.html

echo "</div></body></html>" >> $__dir/morning.html
