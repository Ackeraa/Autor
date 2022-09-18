#!/bin/bash
# Get today's horoscope 

echo '<div class="content" style="font-size:20px;font-family:Garamond">'
curl --silent -X POST \
    "https://aztro.sameerkumar.website/?sign=$SIGN&day=today" \
    | sed 's/, "/;;;;\n"/g' \
    | tr -d '"|}|{' \
    | sed -n '2, $p' \
    | sed 's/_/ /g' \
    | sed -r 's/\<./\U&/' \
    | sed 's/;;/<br\/>/g' \
    | sed 's/Current_date: \|Description: //g'
echo '</div>'
