---
title       : Influence of seat belt use in road casualties
subtitle    : Developing Data Products
author      : Jorge Irazabal
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

<style type="text/css">
 
body, td {
   font-size: 8px;
}
code.r{
  font-size: 8px;
}
pre {
  font-size: 10px;
}
img {
    max-height: 400px;
}
</style>
<!-- Center image on slide -->
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.min.js"></script>
<script type='text/javascript'>
$(function() {
    $("p:has(img)").addClass('centered');
});
</script>

## Introduction

* This is a study on the influence of the compulsory use of the seat belt.

  * The data is monthly totals of people killed or injured 1969-1984 in Great Britain.
   
  * Compulsory wearing of seat belts was introduced on 31/01/1983.

* The shinny application have two tabs:
   * A chart with the consequences of accidents on the road, shown by type of passenger or driver, allowing to study the influence of the price of oil and / or kilometers traveled
  * A comparative with real data and a prediction that would have occurred if the used of seat belt is not mandatory

--- .class #id 

## Shiny Application

* In the shiny application can select the type of road casualties to study

* Data can be filtered by kilometers traveled and/or the price of petrol to study its influence

* A black line separates the date from which the seat belt is mandatory.

![](images/ShinyApp.jpg)

--- .class #id 
## Comparative


```r
library(datasets);library(ggplot2)
require(stats); require(graphics)
        # Obtain Data previous to 1983
        prevData <- window(UKDriverDeaths, end = 1982+11/12)
        # Predict data for then 24 next months
        fit <- arima(prevData, c(1, 0, 0), seasonal = list(order = c(1, 0, 0)))
        z <- predict(fit, n.ahead = 24)
        # Add predict data to plot
        ts.plot(UKDriverDeaths, z$pred,col = c("black", "red"),
                main="Comparation of real UK Driver Deaths and a prediction without compulsory wearing of seat belts", 
	        xlab="Year", ylab="UK Driver Deaths by Month")
```

![plot of chunk unnamed-chunk-1](assets/fig/unnamed-chunk-1-1.png) 

--- .class #id 


## Conclusions

* The number of deaths and injuries decreases with the compulsory use of the seat belt

   * In the case of drivers killed , the first year down by almost 300 people

   * The obligation to use a seat belt only affects the front seats , making accidents in the rear seats is the same, or higher

* The price of petrol is not significant, it varies from month to month for socioeconomic reasons

* The kilometers are not significant, since cars are becoming more powerful , there are more highways ...
   
   * For further travels 1.800 km compared to 1.982 and 1.983 there is a decrease , but in 1.984 more than 1.982 data
