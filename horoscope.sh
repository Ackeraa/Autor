#!/bin/bash
# Get today's horoscope 

__dir=$(dirname "$0")
horoscopef=$__dir/data/horoscope.html
SIGN=aries

echo '<div class="content"><pre>' > $horoscopef
curl -X POST \
    "https://aztro.sameerkumar.website/?sign=$SIGN&day=today" \
    | sed 's/, "/\n"/g' | tr -d '"|}|{' \
    | sed -n '2, $p' >> $horoscopef
echo '</div></p>' >> $horoscopef
