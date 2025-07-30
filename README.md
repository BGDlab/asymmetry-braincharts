Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]

This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

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
      - `asymmetry.lifespan.area.under.curve.csv`: Lifespan average area-under-the-curve of asymmetry
      - `asymmetry-epoch-area-under-curve.csv`: Area-under-the-curve of asymmetry by developmental epoch
      - `asymmetry.case.control.csv`: Asymmetry case-control differences in autism spectrum disorder, schizophrenia and Alzheimer's disease
      - `asymmetry.case.control.distribution.changes.csv`: Distribution changes in case centile scores, compared to controls
      - `asymmetry.classes.csv`: Asignment of regions to their respective asymmetry class
      - `LDSC-left-right-comparison.csv`: LDSC derived Left-right genetic correlation estimates
      - `asymmetry.heritability.csv`: Heritability of asymmetry centile scores


## Plotting trajectories and Out-of-sample predictions
The repository includes `tutorial.Rmd`, which shows how to plot the trajectories. It also generates sample data, to test the out-of-sample prediction. 

## Reproducing figures
The following code reproduces key figures from Dorfschmidt et al., 2025:
1. `999.01.plot.bootstrapped.milestones.R`
2. `999.02.milestones.interplay.R`
3. `999.03.regional.case.control.R`
4. `999.04.asymmetry.area.under.curve.R`
5. `999.05.asymmetry.case.control.distribution.changes.R`
6. `999.06.asymmetry.classes.R`
7. `999.07.left.right.genetic.correlation.R`
8. `999.08.asymmetry.heritability.R`


# Requirements
You will need the following R packages:
- gamlss
- ggplot2
- dplyr
- paletteer
- tidyr


You can install missing packages in R with:

```r
install.packages(c("gamlss", "ggplot2", "dplyr", "paletteer", "tidyr"))
```


# Citation
If you use this repository, please cite the following preprint:

Dorfschmidt et al. (2025). Title of the preprint [bioRxiv link if available]


