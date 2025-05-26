# Asymmetry Braincharts for the Lifespan

This repository contains code and data to:

1. **Access and visualize left-right regional brain developmental trajectories:**
   - Plot regional and asymmetry trajectories across the lifespan
   - Perform out-of-sample prediction for centile scoring of new user data

2. **Reproduce key figures published in Dorfschmidt et al., 2025 (bioRxiv)**

---

# Contents

- **`models-to-share/regional-models`**  
  Fit and bootstrap objects for left and right regional brain developmental trajectories

- **`models-to-share/asymmetry-models`**  
  Fit and bootstrap objects for asymmetry trajectories

- **`supplementary-tables`**  
  Multiple tables, including:  
  - `milestones.csv`: Milestones of left/right regional brain development  
  - `bootstrap.milestones.csv`: Bootstrapped confidence intervals for developmental milestones  
  - `regional.case.control.csv`: Case-control differences in left/right regional development (autism spectrum disorder, schizophrenia, Alzheimer's disease)  
  - `asymmetry-epoch-area-under-curve.csv`: Area-under-the-curve (AUC) of asymmetry by developmental epoch  
  - `asymmetry.case.control.csv`: Case-control asymmetry differences in the above disorders  
  - `asymmetry.case.control.distribution.changes.csv`: Distribution changes in case centile scores vs controls  

---

# Usage

## Plotting trajectories and out-of-sample prediction

- See `tutorial.Rmd` for a step-by-step tutorial on:  
  - Plotting regional and asymmetry trajectories  
  - Generating sample data and performing out-of-sample centile scoring

## Reproducing figures from Dorfschmidt et al., 2025

Run these scripts to reproduce key published figures:

| Script                                               | Description                                    |
| ---------------------------------------------------- | ---------------------------------------------- |
| `999.01.plot.bootstrapped.milestones.R`              | Plot bootstrapped developmental milestones      |
| `999.02.milestones.interplay.R`                       | Analyze interplay of developmental milestones    |
| `999.03.regional.case.control.R`                      | Regional case-control differences                |
| `999.04.asymmetry.area.under.curve.R`                 | Asymmetry area-under-curve across epochs         |
| `999.05.asymmetry.case.control.distribution.changes.R` | Distribution changes in asymmetry case-control comparisons |

---

# Requirements

Make sure the following R packages are installed:

- `gamlss`
- `ggplot2`
- `dplyr`
- `paletteer`
- `tidyr`

You can install missing packages in R with:

```r
install.packages(c("gamlss", "ggplot2", "dplyr", "paletteer", "tidyr"))
```

# Citation

If you use this repository or the data therein, please cite:

Dorfschmidt et al. (2025). Title of the preprint [link to follow soon]





