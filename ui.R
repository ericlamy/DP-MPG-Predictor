library(shiny)

# Shiny UI for web application
shinyUI(fluidPage(
    #
    # WepApp Title    
    titlePanel("Miles Per Gallon Predictor"),
    
    sidebarLayout(
        sidebarPanel(
            # Panel text
            h3("Please enter values:"),
            #
            # Slider 1 - Car cylinders
            sliderInput("cyl", "Cylinders",
                        min = 0, max = 12, value = 6),
            helpText("Number of cylinders."),
            #
            # Slider 2 - Car weight
            sliderInput("wt", "Weight (thousand pounds)",
                        min = 0, max = 6, value = 2, step = 0.1),
            helpText("Car weight in thousand pounds."), 
            #
            # Slider 3 - Car horsepower
            sliderInput("hp", "Horsepower",
                        min = 0, max = 1500, value = 200, step = 10),
            #
            # Slider 4 - Number of gear
            sliderInput("gear", "Number of gears",
                        min = 0, max = 7, value = 5),
            #
            # Radio buttons: car transmission type
            radioButtons("trans", "Transmission Type:",
                         choices = list("Manual" = 1, "Automatic" = 0),
                         selected = 1)   
    
        ),
        
        mainPanel(
            tabsetPanel(
                #
                # Panel 1 - Main
                tabPanel("Predictor",
                        # Inputed values
                         h3("You entered the following values:"),
                         h4("Number of cylinders: ", textOutput("cyltext", inline = TRUE)),
                         h4("Car Weight: ", textOutput("wttext", inline = TRUE), " * 1000 pounds. ",
                            "(",textOutput("wtkgtext", inline = TRUE), " (metric) Tons. )"),
                         h4("Car horsepower: ", textOutput("hptext", inline = TRUE)),
                         h4("Number of gears: ", textOutput("geartext", inline = TRUE)),
                         h4("Transmission type: ", textOutput("transtext", inline = TRUE),
                                " (0 - Automatic  1 - Manual)"),
                        # Estimation    
                         h1("Estimated MPG:", textOutput("mpgtext", inline = TRUE), align = "center"),
                         h4("(", textOutput("l100text", inline = TRUE), " liter/100 km )",
                            align = "center"),
                        # Plot
                         h3("Estimated MPG in data set histogram"),
                         plotOutput("histplot")

                ),
                #
                # Panel 2 - documentation
                tabPanel("Documentation",
                         h1("Miles Per Gallon Predictor"),
                         p("This predictor is based on data of 32 cars models from the MTCARS dataset,",
                            "that have been extracted from the MotorTrend US magazine published in 1974."),
                         p("A linear model has been fitted in order to predict new value of gaz consumption,",
                           "based on the values entered in the side panel."),
                         p("The model has a p-value of 6.687e-10 (F-statistic),",
                           " an r-squared value of 84.93 % and a residual standard error of 2.555."),
                         #
                         h1("How to use this application"),
                         p("The use of the predictor is straighforward:"),
                         tags$ol(
                             tags$li("Enter the requested values on the side panel."),
                             tags$li("The predictor gives back the estimated gaz consumption ",
                                     "in (US) Miles Per Gallon and liter per kilometers."),
                             tags$li("On the histogram graph, you can see (red vertical bar) how the",
                                     " car compares with those of the magazine (in MPG term).")
                         )
                )
            )
        )
    )
))
