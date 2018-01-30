# Data Analytics in Finance

## HW for Lecture 6: Handling Data and Interactive Applications

1. Download the table of firms listed on the NYSE, NASDAQ, and AMEX using the **quantmod** package.
2. What is the dimension of your data (rows, columns)?
3. Remove all rows with incomplete data.
4. How many rows of observations do you now have?
5. Create a table of the frequency of IPOs by year to see hot and cold IPO markets. (First, remove all rows with missing IPO data.)
6. Plot IPO Activity with a bar plot. Make sure to label the axes properly. 
7. Plot IPO Activity using the **rbokeh** package to make a pretty line plot. See: https://hafen.github.io/rbokeh/
8. How many industry sectors are there? 
9. Summarize the frequency of firms by sector.
10. Subset the original data to include only finance firms. (Do not exclude rows of missing values.)
11. Sort the firms by market capitalization and print the top 50 finance firms. (Be careful, some of the values are in millions and others in billions.)
12. Install the *DT* package and show the top 50 financial firms using this package.
13. Redisplay the data set for finance firms using **shiny**.
14. Add to the shiny app a feature that lets you select which columns of the data set to display. 

(Turn in the entire HW in a single file, including screen shots if required.)
