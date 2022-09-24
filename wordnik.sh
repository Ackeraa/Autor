#!/bin/bash
# Get word of the day from wordink.com

WORDNIK_KEY=4sau21q1ax1zvuhbfoq2lljocy9lcp480fxh9cj84lgnhheya
content=$(curl https://api.wordnik.com/v4/words.json/wordOfTheDay?api_key=$WORDNIK_KEY)
echo $content
echo "<h2>"
echo "$content" | grep -P -o '"word":".*?"' | sed 's/"word":"\|"//g'
echo "</h2><div class='content'>"
echo "$content" | grep -P -o '"text":".*?"' | sed 's/"text":"\|"//g'
echo "</div>"
