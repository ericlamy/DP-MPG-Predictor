library(shiny)

# Fit a Linear Model model with the Motor Trend Car Road data.
mtcars$am <- factor(mtcars$am)
fit <- lm(mpg ~ cyl + hp + wt + am + gear, data = mtcars)

shinyServer(function(input, output) {
    # Get Input Values
    output$transtext <- renderText({input$trans})
    output$cyltext <- renderText({input$cyl})
    output$wttext <- renderText({input$wt})
    output$hptext <- renderText({input$hp})
    output$geartext <- renderText({input$gear})
    #
    # Transform pounds in kilos
    wtkg <- reactive({as.numeric(input$wt) * 0.4536})
    output$wtkgtext <- renderText({round(wtkg(),3)})
    #
    # Predict MPG    
    output$mpgtext <- renderText({
        pred.data <- data.frame(
            am = factor(input$trans), 
            cyl = input$cyl,
            wt = input$wt,
            hp = input$hp,
            gear = input$gear)
        pred.MPG <- round(predict(fit, pred.data), 2)
        pred.MPG
    })
    #
    # Transform estimated MPG in liter/100 km
    output$l100text <- renderText({
        pred.data <- data.frame(
            am = factor(input$trans), 
            cyl = input$cyl,
            wt = input$wt,
            hp = input$hp,
            gear = input$gear)
        pred.l100 <- round(predict(fit, pred.data), 2)
        round(235.215 / pred.l100, 2)
    })
#     l100 <- reactive({as.numeric(outputmpgtext) * 235.215})
#     output$l100text = renderText({round(l100(),2)})
    #
    # Plot histogram of MPG with estimated value
    output$histplot <- renderPlot({
        pred.data <- data.frame(
            am = factor(input$trans), 
            cyl = input$cyl,
            wt = input$wt,
            hp = input$hp,
            gear = input$gear)
        pred.MPG <- predict(fit, pred.data)
        #
        # plot
        hist(mtcars$mpg, main = "MPG Distribution from mtcars Dataset",
             xlab = "mpg", col = "gray", breaks=50,
             xlim = c(10, 40))
        abline(v = pred.MPG, col = "red", lwd = 3)
    })    

}
)
