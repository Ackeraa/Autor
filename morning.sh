#!/bin/bash

__dir=$(dirname "$0")
cat $__dir/data/header > $__dir/data/morning.html

#../weather/weather.sh 
#../news/news.sh 
#$__dir/diff.sh

#cat ../weather/weather.html >> morning.html
#cat ../news/news.html >> morning.html
#cat $__dir/data/diff.html >> $__dir/data/morning.html
./diff2html.sh < test >> data/morning.html

echo "</div></body></html>" >> $__dir/data/morning.html
