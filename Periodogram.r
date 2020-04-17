rm(list=ls())
#setwd("C:/Users/Pushpita/Desktop/Circadian CIE project")
library("zeitgebr")
library("ggetho")
library("dplyr")

#Load data
metadata <- data.table(read.csv("Ambulation DD metadata.csv")) %>%
setkey(id)
data <- data.table(read.csv("Ambulation_DD_long.csv")) %>%
setkey(id)

# time should be named `t`
setnames(data,'time', 't')
dt <- behavr(data, metadata)


#------------------------------------------------------------------------
#Both below give "Error in t/bin_length : non-numeric argument to binary operator"
#Plot actograms
ggetho(dt, aes(z = activity), multiplot = 2) + 
  stat_bar_tile_etho() +
  # uid does not exist. you can make it in META, e.g. by merging conditions...
  facet_wrap( ~ id, ncol = 8)

#Compute chi square periodogram
per_xsq_dt <- periodogram(activity, 
                          dt,
                          FUN = chi_sq_periodogram, 
                          # this argument is named resample_rate
                          resample_rate = 1/hours(1))

