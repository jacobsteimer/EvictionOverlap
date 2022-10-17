> library(readxl)
> X2021Evictions <- read_excel("~/Oct 22/2021Evictions.xlsx")
> View(X2021Evictions)
> library(tidyverse)
> library(dplyr)
> FirstDefs <- X2021Evictions %>% filter(Pty == "DFT")
> SecondEvictionDefs <- read_excel("SecondEvictionDefs.xlsx")
> FirstDefsNamed <- FirstDefs %>% mutate(fullname = paste(firstname, lastname, sep = " "))
> SecDefsNamed <- SecondEvictionDefs %>% mutate(fullname = paste(firstname, lastname, sep = " "))
> FirstJustNames <- FirstDefsNamed %>% select(fullname)
> SecondJustNames <- SecDefsNamed %>% select(fullname)
> Overlap <- Reduce(intersect, list(FirstJustNames, SecondJustNames))
# Result = first/last names that overlap (no address)
# Resulted with 3660 observations, from FirstDefs of 18851

> FirstZIPed <- FirstDefs %>% mutate(nameZIPed = paste(firstname, lastname, Zip, sep = " "))
> SecondZIPed <- SecondEvictionDefs %>% mutate(nameZIPed = paste(firstname, lastname, Zip, sep = " "))
> FirstJustZIPed <- FirstZIPed %>% select(nameZIPed)
> SecondJustZIPed <- SecondZIPed %>% select(nameZIPed)
> OverlapZIP <- Reduce(intersect, list(FirstJustZIPed, SecondJustZIPed))
# Result = names + ZIPs that overlap 
# Resulted with 2827 observations, from FirstDefs of 18851

> FZIPNoDups <- FirstZIPed %>% distinct(`Case ID`, .keep_all = TRUE)
> SZIPNoDups <- SecondZIPed %>% distinct(`Case ID`, .keep_all = TRUE)
> JustFZIPNoDUp <- FZIPNoDups %>% select(nameZIPed)
> JustSZIPNoDup <- SZIPNoDups %>% select(nameZIPed)
> OlapZIPNoDup <- Reduce(intersect, list(JustFZIPNoDUp, JustSZIPNoDup))
# Result = names + ZIPs (no duplicated IDs) that overlap 
# Resulted with 2569 observations, from FZIPNoDups of 16483


