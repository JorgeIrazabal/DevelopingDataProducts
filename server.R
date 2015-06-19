library(shiny)

shinyUI(
  navbarPage("Influence of seat belt use in road casualties",
             tabPanel("Introduction",
                      p("This is a study on the influence of the compulsory use of the seat belt in the number of road deaths or seriously injured"),
                      hr(),
                      h3("Instructions"),
                      p("In the Exploratory Analysis tab can you see the number of occupants killed or seriously injured as if it is the driver, passenger types..., allowing to study the influence of the price of petrol or the traveled kilometers."),
                      p(" * Select the group of people to study their casualties"),
                      p(" * In you want study road Kilometers influence, check it and select a range of kilometres"),
                      p(" * In you want study petro price influence, check it and select a range of petrol price"),
                      p(" * Automatically the data group by year is showed"),
                      p(""),
                      p("Comparation tab show the data of drivers killed o seriously injured, and a prediction and a prediction of what would have happened without the mandatory seat belt (be patient, it's slow)"),
                      p(""),
                      p("Data tab contain a reference to the data used")
             ),
             tabPanel("Exploratory Analysis",
                      fluidPage(
                        titlePanel("Road Casualties in Great Britain: 1969 - 1984"),
                        sidebarLayout(
                          sidebarPanel(                                                       
                            radioButtons("type", "Driver or passenger killed or seriously injured :",
                                         c("Drivers Killed" = "DriversKilled",
                                           "Drivers Seriously Injured" = "Drivers",
                                           "Front-seat passengers killed or seriously injured" = "front",
                                           "Rear-seat passengers killed or seriously injured" = "rear",
                                           "Van drivers killed or seriously injured" = "VanKilled",
                                           "All killed or seriously injured" = "all"),selected="all"),                                           
                            checkboxInput("kms", "Distance driven influence"),
                            conditionalPanel(
                              condition = "input.kms == true",
                              selectInput("kmsInfluence", "Distance driven",
                                          list("<12000", "12000-14000", "14000-16000", "16000-18000", ">18000"))
                            ),
                            checkboxInput("petrol", "Petrol price influence"),
                            conditionalPanel(
                              condition = "input.petrol == true",
                              selectInput("petrolInfluence", "Petrol Price",
                                          list("<0.10","0.10-0.12",">0.12"))
                            )
                            
                          ),
                          
                          mainPanel(
                            h3(htmlOutput("caption")),
                            plotOutput("dataPlot")
                            )
                          )
                        )
             ),
             tabPanel("Comparation",
                      p("This is a comparation between the real data (in black) and a prediction if it was not compulsory to use seat belts (in red)"),
                      plotOutput("prdPlot")
             ),
             tabPanel("Data",
                      h2("Road Casualties in Great Britain 1969–84"),
                      hr(),
                      h3("Description"),
                      helpText("It is a time series giving the monthly totals ",
                               "of car drivers in Great Britain killed or ",
                               "seriously injured Jan 1969 to Dec 1984. ",
                               "Compulsory wearing of seat belts was introduced",
                               " on 31 Jan 1983."),
                      h3("Data Format"),
                      p("DriversKilled: Car drivers killed"),
                      p("drivers:       Drivers killed or seriously injured"),
                      p("front:         front-seat passengers killed or seriously injure"),
                      p("rear:          rear-seat passengers killed or seriously injured"),
                      p("kms:           Distance driven"),
                      p("PetrolPrice:   petrol price"),
                      p("VanKilled:     number of van ('light goods vehicle') drivers"),
                      p("law:           0/1: was the law in effect that month?"),
                      
                      h3("Source"),                      
                      p("Harvey, A.C. (1989) Forecasting, Structural Time Series Models and the Kalman Filter. Cambridge University Press, pp. 519Ã¢ÂÂ523"),
                      p("Durbin, J. and Koopman, S. J. (2001) Time Series Analysis by State Space Methods. Oxford University Press. http://www.ssfpack.com/dkbook/"),
                      h3("References"),                      
                      p("Harvey, A.C. (1989) Forecasting, Structural Time Series Models and the Kalman Filter. Cambridge University Press, pp. 519Ã¢ÂÂ523"),
                      p("Durbin, J. and Koopman, S. J. (2001) Time Series Analysis by State Space Methods. Oxford University Press. http://www.ssfpack.com/dkbook/"),
                      textOutput('sumData')
             )
  )
)
