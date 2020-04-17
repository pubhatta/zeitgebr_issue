setwd("C:/Users/Pushpita/Desktop/Circadian CIE project")
library("zeitgebr")
library("ggetho")
library("dplyr")

#Load data
metadata <- data.table(read.csv("Ambulation DD metadata.csv")) %>%
  setkey(id)
data <- data.table(read.csv("Ambulation_DD_long.csv")) %>%
  setkey(id)
dt <- behavr(data, metadata)

#------------------------------------------------------------------------
#Both below give "Error in t/bin_length : non-numeric argument to binary operator"
#Plot actograms
ggetho(dt, aes(z = activity), multiplot = 2) + 
  stat_bar_tile_etho() +
  facet_wrap( ~ uid, ncol = 8)

#Compute chi square periodogram
per_xsq_dt <- periodogram(activity, dt, FUN = chi_sq_periodogram, sampling_rate = 1/hours(1))

#per_xsq_dt <- chi_sq_periodogram(dt$activity,period_range = c(hours(14), hours(34)), 
 #                                sampling_rate = 1/hours(1), alpha = 0.05, 
  #                               time_resolution = hours(0.1))
#The above seems to work and doesn't give an error, but only gives me an observation for each period, not specific to each subject