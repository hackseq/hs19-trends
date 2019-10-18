# hs19-trends

## Project goals
Graphic Visualization of trends in Bioinformatics
  1. Usage of bioinformatic tools and technqiues (ex. sequence alignment, genome assembly, metagenomics etc)
  2. Relationship of tool development within analytical pipelines 
  3. Geographic hotspots for development of bioinformatic tools and techniques 

## Team
Diana Lin
Emma Garlock
Jasmine Lai
Raissa Philibert
Morgana Xu
Lucia Darrow
Swapna Menon

## Approach
1. Webscraping using the package Fulltext package, processing the data in the package pubchunks. We will be looking for: "doi", "refDois", "Year of Publication", "Journal Name", "publisher", "author", "research insitution", "title", "keywords", "abstract". The keywords used for searching determined by terms in the EDAM ontology database and previous knowledge of the field. 
2. Visualizing the data with ggplot and other R visualization packages 
3. Potential data analysis if time permits 

## Pre-requisites 
These are the R Packages needed: 
fulltext
pubchunks
tidyverse
magrittr
dplyr
purrr
here

## Usage
In the R folder, go to FullText_Workflow.Rmd for template and use raw-data>journals.csv for list of journals to be searched. Data output can be found in the data folder. 




