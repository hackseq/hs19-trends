# Trends in Bioinformatics

## Project Goals
Graphic Visualization of trends in Bioinformatics
  1. Usage of bioinformatic tools and technqiues (ex. sequence alignment, genome assembly, metagenomics etc)
  2. Relationship of tool development within analytical pipelines 
  3. Geographic hotspots for development of bioinformatic tools and techniques 

## Team
* [Diana Lin](https://github.com/dy-lin)
* [Emma Garlock](https://github.com/esgarlock)
* [Jasmine Lai](https://github.com/laijasmine)
* [Raissa Philibert](https://github.com/raiphilibert)
* [Morgana Xu](https://github.com/ODataMine)
* [Lucia Darrow](https://github.com/lmdarrow)
* [Swapna Menon](https://github.com/sm30)
* [Shannon Lo](https://github.com/shannonhlo)
* [Elliot](https://github.com/elliotykf)

## Approach
1. Webscraping using the package `fulltext` package, processing the data in the package `pubchunks` code for this can be found in [`R/Fulltext_Workflow.Rmd`](https://github.com/hackseq/hs19-trends/blob/master/R/FullText_Workflow.Rmd). 
    * We will be looking for: `doi`, `Year of Publication`, `Journal Name`, `publisher`, `author`, `research institution`, `title`, `abstract`. 
    * The keywords used for searching determined by terms in the EDAM ontology database and previous knowledge of the field. 
    * The keywords have been set up in [`raw-data/SearchTerms.csv`](https://github.com/hackseq/hs19-trends/blob/master/raw-data/SearchTerms.csv). We are working on optimizing the [`R/Fulltext_Workflow.Rmd`](https://github.com/hackseq/hs19-trends/blob/master/R/FullText_Workflow.Rmd) file to loop through this CSV. 
    * Due to access issues, we are only looking at papers in `plos` 
1. Visualizing the data with ggplot and other R visualization packages 
1. Potential data analysis if time permits 

## Pre-requisites 
These are the R Packages needed: 
* `fulltext`
* `pubchunks`
* `tidyverse`
* `magrittr`
* `dplyr`
* `purrr`
* `here`
* `future`
* `lubridate`
* `stringr`
* `maps'
* `viridis`
* `rgeos`
* `sf`
* `ggmap`
* `maptools`

These are the Python (`python3`) packages needed:
* `googlemaps`
* `pandas`
* Will also require a geocoding API from [Google](https://developers.google.com/maps/gmp-get-started)

## Usage

### Webscraping
To webscrape, run `database_parallel2.R` in the `R` directory after modifying the `topic` and output filename based on the names in the [`raw-data/SearchTerms.csv`](https://github.com/hackseq/hs19-trends/blob/master/raw-data/SearchTerms.csv). 

### Visualization
Three different types of information will be plotted 
1. General summary plots of topic coverage over time and topic coverage based on journal.
1. Analysis of bigrams (combinations of two words) used in publications to see common phrases and their relationships. Also looking to connect the authors and their subject matters using a sankey diagram. 
1. Geographic mapping of insitutions involved in bioinformatic research. Dynamic heatmaps generated with colours based on the number of active insitutions in the area. Using plotly will be able to hover over points to indentify the insitution. Time permitting we will also add the preferred subject area for the insitutions. We will have global view, as well as specific USA and European maps due to the high number of results in those areas. The file being used to generate visualizations [`R/visualization_map.Rmd`](https://github.com/hackseq/hs19-trends/blob/master/R/visualization_map.Rmd). 
  


