#!/bin/bash
# Get today's horoscope 

SIGN=aries

echo '<div class="content" style="font-size:20px;font-family:Garamond">'
curl --silent -X POST \
    "https://aztro.sameerkumar.website/?sign=$SIGN&day=today" \
    | sed 's/, "/;;;;\n"/g' \
    | tr -d '"|}|{' \
    | sed -n '2, $p' \
    | sed -r 's/\<./\U&/' \
    | sed 's/;;/<br\/>/g'
echo '</div>'
