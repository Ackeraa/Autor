#!/bin/bash
# Getting news

__dir=$(dirname "$0")
agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)"

# Solidot 
content=$(curl \
    -H "User-Agent: $agent" \
    https://www.solidot.org/index.rss)

echo "$content" | grep -E '(title>|description>)' \
                | sed -E 's/title>/h2>/g; 
                          s/<description>/<div class="news">/g; 
                          s/\/description>/\/div>/g; s/\[|\]//g;
                          s/<\!//g; s/></</g' > $__dir/data/news.html 
