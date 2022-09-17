#!/bin/bash
# Get today's horoscope 

__dir=$(dirname "$0")
outputf=$__dir/data/horoscope.html
SIGN=aries

echo '<div class="content" style="font-size:20px;font-family:Garamond">' > $outputf
curl -X POST \
    "https://aztro.sameerkumar.website/?sign=$SIGN&day=today" \
    | sed 's/, "/;;;;\n"/g' \
    | tr -d '"|}|{' \
    | sed -n '2, $p' \
    | sed -r 's/\<./\U&/' \
    | sed 's/;;/<br\/>/g' >> $outputf
echo '</div>' >> $outputf
