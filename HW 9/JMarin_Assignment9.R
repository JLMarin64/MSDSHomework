---
title: "test"
author: "Jonathan Marin"
date: "March 4, 2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```





```{r HarryPotter echo = TRUE, include = TRUE}

library(rvest)
library(dplyr)
library(stringr)
library(tidyr)
library(splitstackshape)
library(sqldf)


url <- 'http://www.imdb.com/title/tt1201607/fullcredits?ref_=tt_ql_1'

webpage <- read_html(url)

HarryPotterCrew <- html_nodes(webpage,'table.cast_list')

theCrew <- html_text(HarryPotterCrew)

theCrew <- gsub('\n          \n          \n ','', theCrew)
theCrew <- gsub('^"" ','',theCrew)
theCrew <- gsub('[:...:]','\t',theCrew)
theCrew <- gsub('\t\t\t','\t',theCrew)
theCrew <- gsub('             \t             \n            ','\t ', theCrew)
theCrew <- gsub('\n                      \n\n              \n          \n      ', '\n ', theCrew)
theCrew <- gsub('^ .*','',theCrew)
theCrew <- gsub('^\n','',theCrew)
theCrew <- gsub(" \n  \n  \n  ",' ',theCrew)
theCrew <- gsub(' /  \n            ', '/',theCrew)
theCrew <- gsub('\n  \n ','\n' , theCrew)
theCrew <- gsub('^ ', '', theCrew)
theCrew <- gsub('\n ', '\n', theCrew)
theCrew <- gsub('Rest of cast listed alphabetically\t','',theCrew)
theCrew <- gsub('Peter G\t Reed\t', 'Peter G. Reed\t', theCrew)
theCrew <- strsplit(theCrew, '\n')

theCrew <- as.data.frame(theCrew)

colnames(theCrew)[1] <- "Actor"



theCrew <- cSplit(theCrew, "Actor", "\t")

colnames(theCrew)[1] <- "Actor"
colnames(theCrew)[2] <- "Character"

Names <- as.data.frame(theCrew$Actor)

theCrew$LastName <- gsub("^.* ","",theCrew$Actor)
theCrew$FirstName <- gsub("\\s[^ ]+$","",theCrew$Actor, perl = TRUE)

output <- sqldf("select FirstName, LastName as Surname, Character from theCrew")

head(output, 10)

```

