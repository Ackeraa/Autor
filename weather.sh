#!/bin/bash
# Get weather from wttr.in

LOCATION=Beijing
__dir=$(dirname "$0")
outputf=$__dir/data/weather.html

echo "<h2>" > $outputf
curl wttr.in/$LOCATION?format=3 >> $outputf
echo "</h2>" >> $outputf
