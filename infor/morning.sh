#!/bin/bash

cat header.html > morning.html

#../weather/weather.sh 
#../news/news.sh 
#../diff/diff.sh

#cat ../weather/weather.html >> morning.html
#cat ../news/news.html >> morning.html
#cat ../diff/diff.html >> morning.html
../commits/pull.sh
cat ../commits/diff.html >> morning.html

echo "</div></body></html>" >> morning.html
