## Asymmetry braincharts for the lifespan

# This repository contains code to:

(1) Access and visualize left-right regional brain developmental trajectories
 - Plot regional and asymmetry trajectories across age
 - Perform out-of-sample prediction so users can centile-score their own data

(2) Produce a number of key figures published in Dorfschmidt et al. 2025, bioRxivs. 


# Contents
 - `models-to-share/regional-models` contains the fit and bootstrap objects for left and right regional trajectories
 - `models-to-share/asymmetry-models` contains the fit and bootstrap objects for the asymmetry trajectories
 - `supplementary-tables` contains multiple tables, including:
      - `milestones.csv`: Milestones of left/right regional brain development
      - `bootstrap.milestones.csv`: Boostrapped confidence intervals around milestones of left/right regional brain development
      - `regional.case.control.csv`: Left/right regional case-control differences in autism spectrum disorder, schizophrenia and Alzheimer's disease
      - `asymmetry-epoch-area-under-curve.csv`: Area-under-the-curve of asymmetry by developmental epoch
      - `asymmetry.case.control.csv`: Asymmetry case-control differences in autism spectrum disorder, schizophrenia and Alzheimer's disease
      - `asymmetry.case.control.distribution.changes.csv`: Distribution changes in case centile scores, compared to controls
      - `asymmetry-epoch-area-under-curve.csv`: Area-under-the-curve of asymmetry by developmental epoch


## Plotting trajectories and Out-of-sample predictions
The repository includes `tutorial.Rmd`, which shows how to plot the trajectories. It also generates sample data, to test the out-of-sample prediction. 

## Reproducing figures
The following code reproduces key figures from Dorfschmidt et al., 2025:
(1) `999.01.plot.bootstrapped.milestones.R`
(2) `999.02.milestones.interplay.R`
(3) `999.03.regional.case.control.R`
(2) `999.04.asymmetry.area.under.curve.R`
(2) `999.05.asymmetry.case.contro.distribution.changes.R`


# Requirements
You will need the following R packages:
- `gamlss`
- `ggplot2`
- `dplyr`
- `paletteer`
- `tidyr`

# Citation
If you use this repository, please cite the following preprint:


