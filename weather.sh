#!/bin/bash
# Get weather from wttr.in

echo '<div class="title">'
curl --silent wttr.in/$LOCATION?format=3
echo '</div>'
