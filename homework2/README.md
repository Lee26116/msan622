Homework 2: Interactivity
==============================

| **Name**  | Li Tan  |
|----------:|:-------------|
| **Email** | ltan@dons.usfca.edu |

## Instructions ##

The following packages must be installed prior to running this code:

- `ggplot2`
- `shiny`

To run this code, please enter the following commands in R:

```
library(shiny)
shiny::runGitHub('msan622', 'Lee26116', 'homework2')
```

This will start the `shiny` app. See below for details on how to interact with the visualization.

## Discussion ##

My work was done by two parts: plot and shiny set up.

-Plot:
First of all, I followed the instructions to filter out some unuseful data from the dataset. 
Secondly, I generated a scatter plot with "ggplot2" package and did the following customizings:
1. removing the gray background as well as changingthe horizontal$vertical lines into gray because the unchosen dots would be set into gray as well, thus I need a white background.
2. removing the thick bars from both x and y axis
3. adding titles and changing the x, y and panel names
4. converting panel display from vertical into horizontal and placing it to the left buttom of the plot
5. changing the values on x-axis into "number+M"

-Shiny Set Up
There are five components in terms of Shiny set up. I will talk them respectively.
1. Radio Button
I applied radio button for MPAA ratings, such that users can choose either one of the MPAA rating categories or all of them (there is an "All" option). The unchosen dots will turn to gray
2. Check Box Group Input
I applied this issue for movie genres, thus by selecting one or more genres, users can visualize how they distributed: the budget and IMDD Rating of each genre. If no genre is chosen, then the plot will display all the categories.
3. Select Input
I did this for colour scheme. Users can choose their desired colour set to visualize the plot. Defaultly, the coulor set is "Default".
4. Slide Input
I used slide input on tuning the dot size and dot alpha. For dot size, it's ranging from 1 to 10, and dot alpha from 0.1 tp 1 with step set to 0.1.
5. Table plot
I also add a table for this plot, displaying some other statistics, such as movie's length, budget, rating and votes. Users can get specific information about these variables, such as its minimum, maximum, etc.

