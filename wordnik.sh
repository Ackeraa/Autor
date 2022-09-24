#!/bin/bash
# Get word of the day from wordink.com

WORDNIK_KEY=4sau21q1ax1zvuhbfoq2lljocy9lcp480fxh9cj84lgnhheya
content=$(curl https://api.wordnik.com/v4/words.json/wordOfTheDay?api_key=$WORDNIK_KEY)
echo "<div class='title'>"
echo "$content" | grep -P -o '"word":".*?"' | sed 's/"word":"\|"//g'
echo "</div><div class='content'>"
echo "$content" | grep -P -o '"text":".*?"' | sed 's/"text":"//g; s/"/<br\/><br\/>/g'
echo "</div>"
