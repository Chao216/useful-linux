#!/bin/bash
time=`date +%Y/%m/%d@%H:%M:%S`
git add *
git commit -m "this is automatically pushed by push script $time"
git push origin main

echo "an auto push $time"
