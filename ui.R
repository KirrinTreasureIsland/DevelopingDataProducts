library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Stock prices and normality of returns"),
  sidebarPanel(
    h4('Stock'),
    selectInput("stock","Stock name (symbol):", c("Amazon (AMZN)"="AMZN","Google (GOOG)"="GOOG", "Toyota Motor Corp. (TM)"="TM", "Yahoo (YHOO)"="YHOO"),"AMZN"),
    h4('Time period for data'),
    dateInput("datebegin","From:",'2014/01/02'),
    dateInput("dateend", "To:", '2015/01/01'),
    submitButton('Submit'),
    br(),
    h4('Documentation'),
    p('The application displays the stock prices for a selected stock, and analyses the daily returns. Some financial models assume that the returns have a normal distribution. However, in practice we often encounter the data with so called fat tails - the extreme values (extremely high profit or high loss) occur with a higher probability compared to what would be predicted by a normal distribution. This application allows the user to see the distribution of the returns for selected data.'),
    p('The user selects a stock from the drop-down list. By clicking on a time field, a calendar pops up and makes it possible to customize the time range for the data. The default values are prices of the Amazon stock during the year 2014.'),
    p('After selecting the data, the user need to click the ', em('Submit'), 'button'),
    p('The output consists of repeating the imputted values, time plot of stock prices and daily returns, and two plots for testing the normality of the returns - histogram with fitted normal density and normal QQ plot.')

  ),
  mainPanel(
    h3('Input Data'),
    p('This section simply reviews the data selected by the user, which will be used in the computations below'),
    h4('Selected stock'),
    verbatimTextOutput("ostock"),
    h4('Selected time interval'),
    verbatimTextOutput("odate1"),
    h3('Stock prices'),
    p('The graph below displys the stock prices at the end of the trading days during the selected time interval.'),
    plotOutput("plotClose"),
    p('Note that these prices are so called', em('adjusted close prices'),'. During the course of a trading day, many things can happen to affect a stock price. Along with good and bad news relating to the operations of a company, any sort of distribution that is made to investors will also affect stock price. These distributions can include cash dividends, stock dividends and stock splits.'),
    p('For more details see, for example,',  a("investopedia website",     href='http://www.investopedia.com/ask/answers/06/adjustedclosingprice.asp', target='_blank'), '(from which also the paragraph above was taken)'),
    h3('Daily Returns'),
    p('The returns are computed as', code('log((price today)/(price yesterday))'), '. Below, there is a graph of time evolution of these returns.'),
    plotOutput("plotReturns"),
    h4('Testing normality of returns'),
    p('In some financial models - including the famous ', a('Black-Scholes model', href='http://en.wikipedia.org/wiki/Black%E2%80%93Scholes_model', target='_blank'),' - are assumed to have a normal distribution. To test this assumption on the selected data, we show a normal QQ-plot of the returns and histogram with fitted normal distribution density curve.'),
    p('For a histogram, the fitted normal distribution density curve (shown in blue colour) should fit the histogram well, if the data come from a normal distribution.'),
    plotOutput("plotHist"),
    p('However, a departure from a normality may not be so clearly visible, as on the following graph of a normal QQ plot.'),
    p('In case of a normal distribution, the graph on a normal QQ plot would be a line. What we can observe often for stock returns, are symmetric distributions with fat tails - in this case the left tail of the QQ plot is below the line and the right tail of the plot is above the line, which is indicated by red on the plot.'),
    plotOutput("plotQQ"),
    p('One can read more on interpretation of QQ plots for example', a('on Statistic Mentor site', href='http://www.statisticsmentor.com/2012/11/04/r-shape-of-the-normal-q-q-plot-for-skewed-distributions', target='_blank'),'.')
    )
))

