##

RDS.DIR <- file.path( ".", "RDS" ) ## Where output files are saves

RAW.DIR <- file.path( ".", "CSV" )

#MM.MEASURES = sort(read.csv(paste0(RAW.DIR,'/regions.txt'))[,1])#read.csv(paste0(RAW.DIR,'/phenotypes.txt'))[,1] 
#MM.MEASURES = MM.MEASURES[grep('h.GM',MM.MEASURES)]

DROPCOL = NULL #c(MM.MEASURES[grep('SA\\.',MM.MEASURES)], MM.MEASURES[grep('CT\\.',MM.MEASURES)], MM.MEASURES[grep('surface.area.',MM.MEASURES)],MM.MEASURES[grep('surface.area',MM.MEASURES)],MM.MEASURES[grep('cortical.thicknes.',MM.MEASURES)])

SPREADSHEET <- '240920-L.R.LBCC.csv' #'LBCC.OHBM2024.csv'

THISDATATAG <- 'site240920' # Don't use -

##
## The switch below will not work on Windows, and may have some issues.
## NOTE: It is used in novel-script, to define a 'choosen' expanded-fit for the longitudinal-script
##       There is a fall-back to the unexpanded-fit (ie. model-fit) in case

LINK.TYPE <- c("symlink","hardlink","copy")[1]
##
##  symlink/hardlink only really viable on unix systems
## if on windows, likely must choose copy method
