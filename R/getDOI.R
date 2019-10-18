library(rcrossref)
library(fulltext)
bmcsearch <- function(x,st) {
  df <- bmc_search(query=st,limit=50,offset=x)
  df <- df$records
  return(df)
}

crossrefsearch <- function(x,st) {
  df <- cr_works(query=st,limit=1000,offset=x)
  df <- df$data
  return(df)
}

getDOI <- function(st,limit=1000){
  offsets <- seq(1,limit,50)
  bmc <- purrr::map_df(offsets,function(x) bmcsearch(x,st=st))
  
  offsets <- seq(1,limit,1000)
  crossref <- purrr::map_df(offsets,function(x) crossrefsearch(x,st=st))
  doi <- c(bmc$doi,crossref$doi)

return(doi)
}

