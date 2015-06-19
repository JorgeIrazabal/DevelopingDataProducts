library(shiny)
library(datasets)
library(ggplot2)
require(stats); require(graphics)

shinyServer(function(input, output) {
  
  formulaText <- reactive({
          # Get the title with the selected condition
          if (input$type == "DriversKilled") {
                  salida <- 'Drivers killed'
          }
          if (input$type == "Drivers") {
                  salida <- 'Drivers Seriously Injured'
          }
          if (input$type == "front") {
                  salida <- 'Front-seat passengers'
          }
          if (input$type == "rear") {
                  salida <- 'Rear-seat passengers'
          }
          if (input$type == "VanKilled") {
                  salida <- 'Van drivers'
          }
          if (input$type == "all") {
                  salida <- 'All ocupant killed or seriously injured'
          }
          if (input$kms == "TRUE") {
                  salida <- paste(salida,"<br/> Kilometers traveled: ")
                  salida <- paste(salida,input$kmsInfluence)
          }
          if (input$petrol == "TRUE") {
                  salida <- paste(salida,"<br/> Petrol Price: ")
                  salida <- paste(salida,input$petrolInfluence)
          }
          salida
  })
  
  
  output$caption <- renderUI({
    HTML(formulaText())
  })
  
# Plot with the distribution of killed or seriously injured people  
output$dataPlot <- renderPlot( {

  df <- data.frame(Seatbelts)
  # Obtain the year if the data
  df$seq<- seq(1,192)
  df$year<-1969 + floor((df$seq-1)/12)
  # If kms has been selected, filter the data
  if (input$kms == "TRUE") {
    if (input$kmsInfluence == "<12000") {
      df <- subset(df,kms<12000)
    }
    if (input$kmsInfluence == "12000-14000") {
      df <- subset(df,kms>=12000 & kms<14000)
    }
    if (input$kmsInfluence == "14000-16000") {
      df <- subset(df,kms>=14000 & kms<16000)
    }
    if (input$kmsInfluence == "16000-18000") {
      df <- subset(df,kms>=16000 & kms<18000)
    }
    if (input$kmsInfluence == ">18000") {
      df <- subset(df,kms>=18000)
    }
  }
  # If petrol influence has been selected, filter the data
  if (input$petrol == "TRUE") {
    if (input$petrolInfluence == "<0.10") {
      df <- subset(df,PetrolPrice<0.09)
    }
    if (input$petrolInfluence == "0.10-0.12") {
      df <- subset(df,PetrolPrice>=0.09 & PetrolPrice<0.12)
    }
    if (input$petrolInfluence == ">0.12") {
      df <- subset(df,PetrolPrice>=0.12)
    }
  }
  # Load selected people type
  if (input$type == "DriversKilled") {
    finalData <- data.frame(df[,c(1,10)],'Drivers killed')
    yLabel <- 'Drivers killed'
  }
  if (input$type == "Drivers") {
    finalData <- data.frame(df[,c(2,10)],'Drivers Seriously Injured')
    yLabel <- 'Drivers Seriously Injured'
  }
  if (input$type == "front") {
    finalData <- data.frame(df[,c(3,10)],'Front-seat passengers')
    yLabel <- 'Front-seat passengers'
  }
  if (input$type == "rear") {
    finalData <- data.frame(df[,c(4,10)],'Rear-seat passengers')
    yLabel <- 'Rear-seat passengers'
  }
  if (input$type == "VanKilled") {
    finalData <- data.frame(df[,c(7,10)],'Van drivers')
    yLabel <- 'Van drivers'
  }
  if (input$type == "all") {
    finalData <- data.frame(df[,c(1,10)],'Drivers killed')
    finalData <- setNames(finalData,c("Total","Year","Type"))
    auxData <- data.frame(df[,c(2,10)],'Drivers Seriously Injured')
    auxData <- setNames(auxData,c("Total","Year","Type"))
    finalData <- rbind(finalData, auxData)
    auxData <- data.frame(df[,c(3,10)],'Front-seat passengers')
    auxData <- setNames(auxData,c("Total","Year","Type"))
    finalData <- rbind(finalData, auxData)
    auxData <- data.frame(df[,c(4,10)],'Rear-seat passengers')
    auxData <- setNames(auxData,c("Total","Year","Type"))
    finalData <- rbind(finalData, auxData)
    auxData <- data.frame(df[,c(7,10)],'Van drivers')
    auxData <- setNames(auxData,c("Total","Year","Type"))
    finalData <- rbind(finalData, auxData)
    yLabel <- 'All ocupant killed or seriously injured'
  }
  finalData <- setNames(finalData,c("Total","Year","Type"))
  # Show Data
  ggp <- ggplot(finalData, aes(x=Year, y=Total, fill=Type)) + 
    geom_bar(stat="identity",se=FALSE) +
    ylab(yLabel) +    
    xlab("Year")   + 
    geom_vline(xintercept=1982.45)

  print(ggp)
})

output$prdPlot <- renderPlot({
        # Obtain Data previous to 1983
	prevData <- window(UKDriverDeaths, end = 1982+11/12)
        # Draw this data
	plot(prevData); 
        # Predict data for then 24 next months
	fit <- arima(prevData, c(1, 0, 0), seasonal = list(order = c(1, 0, 0)))
	z <- predict(fit, n.ahead = 24)
        # Add predict data to plot
	ts.plot(UKDriverDeaths, z$pred,
	        col = c("black", "red"),main="Comparation of real UK Driver Deaths and a prediction without compulsory wearing of seat belts", 
	        xlab="Year", ylab="UK Driver Deaths by Month")

  })

})
