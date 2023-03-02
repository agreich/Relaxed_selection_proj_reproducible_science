IF YOU READ NOTHING ELSE, READ THIS:
I learned how to code while conducing this project. The quality of code reflects this. It's not super clean, but it's definitely cleaner than it was, and honestly as clean as it is going to get now that I'm out of time to work on this project and moving on to other things.

Main coho bomb results are in this pathway:  "Female GSI and Eggs/Bomb_stuff/Bomb_notebook_subsetcoho_simple.Rmd"
--produces results csv and figure when run (for the coho subsetted dataset)

The main GSI and egg results are in the pathway: 
"Female GSI and Eggs/GSI_and_Eggs/GSI_eggs_allpink_cohoSUB.csv"
--this will spit out csv's with pink and coho GSI and egg results (6 results csv's in total)

The main morpho resutls, within the Male morpho folder:
"Morpho_yr1_pinkcoho.RMD" - pink and coho yr 1 results
"Morpho_yr2_pinks.RMD" - pink yr 2 results
"Simply graphing.R" - final graphs for these
--None of these spit out convenient results csv's yet, but they are relatively well organized code







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



