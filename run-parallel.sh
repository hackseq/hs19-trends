#!/bin/bash

# get the topics
awk -F "," '{print $1}' <(tail -n +2 raw-data/SearchTerms.csv) |  sort -u | tr '\n' ',' | xargs -d ',' -n 1 -P 11 R/database_parallel2.R 


# awk -F "," '{print $1}' <(tail -n +2 raw-data/SearchTerms.csv) |  sort -u | tr '\n' ',' | xargs -d ',' -n 1 
