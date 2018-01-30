library(shiny)
library(plotly)
library(ggplot2)


##### SERVER #####

# Define server logic for random distribution application
server <- function(input, output) {
  
  #Generate Black-Scholes values
  BS = function(S,K,T,v,rf,dv) {
    d1 = (log(S/K) + (rf-dv+0.5*v^2)*T)/(v*sqrt(T))
    d2 = d1 - v*sqrt(T)
    bscall = S*exp(-dv*T)*pnorm(d1) - K*exp(-rf*T)*pnorm(d2)
    bsput = -S*exp(-dv*T)*pnorm(-d1) + K*exp(-rf*T)*pnorm(-d2)
    res = c(bscall,bsput)
  }
  
  #Call option price
  output$BScall <- renderText({ 
    #Get inputs
    S = input$stockprice
    K = input$strike
    T = input$maturity
    v = input$volatility
    rf = input$riskfreerate
    dv = input$divrate
    res = round(BS(S,K,T,v,rf,dv)[1],4)
  })
  
  #Put option price
  output$BSput <- renderText({ 
    #Get inputs
    S = input$stockprice
    K = input$strike
    T = input$maturity
    v = input$volatility
    rf = input$riskfreerate
    dv = input$divrate
    res = round(BS(S,K,T,v,rf,dv)[2],4)
  })
  
  #Call plot
  output$plotCall <- renderPlot({
    S = input$stockprice
    K = input$strike
    T = input$maturity
    v = input$volatility
    rf = input$riskfreerate
    dv = input$divrate
    vcall = NULL; vput = NULL
    strikes = seq(K-30,K+30)
    for (k in strikes) {
      vcall = c(vcall,BS(S,k,T,v,rf,dv)[1])
      vput = c(vput,BS(S,k,T,v,rf,dv)[2])
    }
    df = data.frame(strikes,vcall,vput)
    ggplot(df,aes(x=strikes,y=vcall)) + geom_point(color=strikes)
  }, height = 350, width = 600)
  
  #Put plot
  output$plotPut <- renderPlot({
    S = input$stockprice
    K = input$strike
    T = input$maturity
    v = input$volatility
    rf = input$riskfreerate
    dv = input$divrate
    vcall = NULL; vput = NULL
    strikes = seq(K-30,K+30)
    for (k in strikes) {
      vcall = c(vcall,BS(S,k,T,v,rf,dv)[1])
      vput = c(vput,BS(S,k,T,v,rf,dv)[2])
    }
    df = data.frame(strikes,vcall,vput)
    ggplot(df,aes(x=strikes,y=vput)) + geom_point(color=strikes)
  }, height = 350, width = 600)
  
  
}

##### UI #####

ui <- shinyUI(fluidPage(
  
  titlePanel("Black-Scholes-Merton (1973)"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput('stockprice','Stock Price',100),
      numericInput('strike','Strike Price',100),
      sliderInput('maturity','Maturity (years)',min=0.1,max=10,value=1,step=0.01),
      sliderInput('volatility','Volatility',min=0.1,max=0.9,value=0.15,step=0.01),
      sliderInput('riskfreerate','Risk free rate',min=0.0,max=0.5,value=0.01,step=0.01),
      sliderInput('divrate','Dividend rate',min=0.0,max=0.25,value=0.01,step=0.01),
      hr(),
      p('Please refer to following for more details:',
        a("Black-Scholes (1973)", 
          href = "https://en.wikipedia.org/wiki/Black%E2%80%93Scholes_model")),
      hr()
    ),
    
    mainPanel(
      p('Call price'),
      textOutput("BScall"),
      hr(),
      p('Put price'),
      textOutput("BSput"),
      hr(),
      tabsetPanel(
        tabPanel("Calls", plotOutput("plotCall",width="100%")), 
        tabPanel("Puts", plotOutput("plotPut",width="100%")) 
      )
    )
  )  
))

##### Run #####
shinyApp(ui = ui, server = server)
