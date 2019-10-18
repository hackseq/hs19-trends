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
1. Webscraping using the package Fulltext package, processing the data in the package pubchunks code for this can be found in R>Fulltext_Workflow.Rmd. We will be looking for: "doi", "refDois", "Year of Publication", "Journal Name", "publisher", "author", "research insitution", "title", "keywords", "abstract". 
  1.1 The keywords used for searching determined by terms in the EDAM ontology database and previous knowledge of the field. 
  1.2 The keywords have been set up in raw-data>SearchTerms.csv. We are working on optimizing the R>Fulltext_Workflow.Rmd file to loop through this CSV. 
  1.3 Journals available to us "plos", "bmc", "crossref", "entrez", "arxiv", "biorxiv", "europmc", "scopus", or "ma". 
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




