#!/usr/bin/env bash

publist="disqus foursquare tumblr twitter wp-com stocktwit"
echo $(date)

tmpfile="$TMPDIR/gnacstest.tmp"
if [ -e $tmpfile ]; then
    rm $tmpfile
fi

for pub in $publist; do
    echo "Parsing $pub..."
    fn="../data/${pub}_sample.json"
    echo " Records for $pub from $fn..."
    ../gnacs.py -lustrz $pub $fn >> $tmpfile
    echo " Explanation for $pub from $fn..."
    ../gnacs.py -xlustrz $pub $fn >> $tmpfile
    echo " Pretty $pub from $fn..."
    ../gnacs.py -p $fn >> $tmpfile
done

echo "Output: $(cat $tmpfile | wc -l) should be 25176"
echo "GNIP lines: $(cat $tmpfile | grep GNIP | wc -l) should be 4"

if [ -e $tmpfile ]; then
    rm $tmpfile
fi
