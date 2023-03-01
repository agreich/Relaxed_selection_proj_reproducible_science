# Relaxed_selection_proj_reproducible_science
Cleaning up my master's project code so that other people can (more) easily understand what's going on here.

This is where I'll combine all of my code so that my masters project results are easily accessible to my advisors. I hope to leave this project clean and concise, as I leave academia and move on to the next thing.

Apologies in advance. My code is a bit meandering. I learned how to code and use github while analyzing this data. My future data analysis will be cleaner and more methodical, now that I sort of know what I am doing.




Male morphometrics:
Morpho_yr1_pinkcoho.Rmd has been revised and Qc'ed, but where'd I make the final project graphs?? Might be in the "simply graphing" R document

Morpho_yr2_pink is done.

the "Simply.graphing.R" file is associated with the morphometrics graphs. The csv's for this file are created in Morpho_yr1_pinkcoho.Rmd and Morpho_yr2_pinks.Rmd. I wrote csv's for these so that Simply.graphing.R can now be run alone.


Female GSI and eggs:
GSI_eggs_allpink_coho.Rmd contains the pink 2020, pink 2021, and coho full dataset analysis
GSI_eggs_allpink_coho_SUB.Rmd contains the pink 2020, pink 2021, and coho sub dataset analysis
--> this latter Rmd is used for the primary results reporting, where we subsetted our coho. Make sure to clear the environment before running, and don't jump back and forth between the two Rmd's while running code. This is because in the coho analysis, things have the same names in the two Rmd's but reference different datasets (coho full dataset vs. coho sub dataset)


Bomb calorimetry and lipid analysis:
The "bomb_notebook_subsetcoho_simple.RMD" is the version with results, graphs, without misc exploration. Simpler.
- also spits out a csv of results when run: "Bomb_results_cohosub_auto.csv"

The "Bomb_notebook copy.Rmd" has the full female coho dataset
The "Bomb_notebook_subsetcoho copy.Rmd" has the subsetted female dataset.
-results reported in Table 4 are taken from line 268 for the energy results and line 287 for the lipid results, using one-sided Student's t tests.
---SD calculations in that same code block
--includes graphs and experimentations

We used the subsetted female dataset for our primary results.
There's a few csv files associated with this one, mostly to add in covariates. In the future I will just use the raw csv files and do manipulation in R. 



