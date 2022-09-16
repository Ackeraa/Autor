#!/bin/bash

echo > night.html

../news/news.sh 

cat ../news/news.html >> night.html
