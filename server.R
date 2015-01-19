library(shiny)
library(quantmod)
library(car)

shinyServer(
  function(input, output) {
  
    output$ostock <- renderPrint(input$stock)
    output$odate1 <- renderPrint({c(input$datebegin,input$dateend)})

    output$plotClose <- renderPlot({
      StockPrices <- getSymbols(input$stock, src = "yahoo", 
                                from = input$datebegin,
                                to = input$dateend,
                                auto.assign = FALSE)        
      StockPrices <- StockPrices[,paste(input$stock,".Adjusted",sep="")]
      chartSeries(StockPrices, theme = chartTheme("white"))
    })
    
    output$plotReturns <- renderPlot({
      StockPrices <- getSymbols(input$stock, src = "yahoo", 
                                from = input$datebegin,
                                to = input$dateend,
                                auto.assign = FALSE)        
      PriceAdjusted <- StockPrices[,paste(input$stock,".Adjusted",sep="")]
      DailyReturns <- diff(log(PriceAdjusted))
      barChart(DailyReturns, theme = "white")
    })
    
    output$plotQQ <- renderPlot({
      StockPrices <- getSymbols(input$stock, src = "yahoo", 
                                from = input$datebegin,
                                to = input$dateend,
                                auto.assign = FALSE)        
      PriceAdjusted <- StockPrices[,paste(input$stock,".Adjusted",sep="")]
      DailyReturns <- as.numeric(diff(log(PriceAdjusted)))[-1]
      qqnorm(DailyReturns, main = "Normal Q-Q Plot",
             xlab = "Theoretical Quantiles", ylab = "Sample Quantiles")
      qqline(DailyReturns, col=2)
      })
    
    output$plotHist <- renderPlot({
      StockPrices <- getSymbols(input$stock, src = "yahoo", 
                                from = input$datebegin,
                                to = input$dateend,
                                auto.assign = FALSE)        
      PriceAdjusted <- StockPrices[,paste(input$stock,".Adjusted",sep="")]
      DailyReturns <- diff(log(PriceAdjusted))
      DailyReturns <- as.numeric(DailyReturns[-1])
      hist(DailyReturns, prob=TRUE)
      x=seq(from=min(DailyReturns),to=max(DailyReturns),length.out=500)
      curve(dnorm(x, mean=mean(DailyReturns), sd=sd(DailyReturns)), add=TRUE, col=4)
    })
    
})









# shinyServer(
#   function(input, output) {
#   }
# )

# shinyServer(
#   function(input, output) {
#     output$oid1 <- renderPrint({input$id1})
#     output$oid2 <- renderPrint({input$id2})
#     output$odate <- renderPrint({input$date})
#   }
# )

# -----------------------------------
# diabetesRisk <- function(glucose) glucose / 200
# 
# shinyServer(
#   function(input, output) {
#     output$inputValue <- renderPrint({input$glucose})
#     output$prediction <- renderPrint({diabetesRisk(input$glucose)})
#   }
# )

# -----------------------------------

# library(UsingR)  # bolo treba nainstaolvat tuto kniznicu
# data(galton)
# 
# shinyServer(
#   function(input, output) {
#     output$newHist <- renderPlot({
#       hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
#       mu <- input$mu
#       lines(c(mu, mu), c(0, 200),col="red",lwd=5)
#       mse <- mean((galton$child - mu)^2)
#       text(63, 150, paste("mu = ", mu))
#       text(63, 140, paste("MSE = ", round(mse, 2)))
#     })
#     
#   }
# )