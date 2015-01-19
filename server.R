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

