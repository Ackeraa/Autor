#!/bin/bash
agent="Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.0.3705; .NET CLR 1.1.4322)"
content=$(curl \
    -H "User-Agent: $agent" \
    https://www.solidot.org/index.rss)
echo "$content" | grep -E '(title>|description>)' > log
