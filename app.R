library(shiny)
library(tidyverse)
library(ggVennDiagram)
load("all_projects.sample_count_mean.rda")
load("all_projects.sample_count_mean_5x.rda")
load("dataforoverlaps.rda")

ui <- fluidPage(
  titlePanel("Comparison of Methylation Data from RRBS and ERRBS"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("cov", 
                  label = "Choose a CpG Coverage Cut-off",
                  choices = c("10X", "5X"),
                  selected = "10X"),
      sliderInput("overlap",
                  "% Overlap of CpG sites covered ≥5x or ≥10x by RRBS and ERRBS samples:", 
                  min = 0,
                  max = 100,
                  value = 75),
      h5("Click and drag the circle under the blue number on the slider to adjust the % overlap for RRBS vs. ERRBS with ≥5x or
         ≥10x coverage.")
      ),
      mainPanel(
        plotOutput("metrics_numberCG"),
        plotOutput("metrics_meanCG"),
        plotOutput("overlap_plot")
      )
  )
  
)

server <- function(input, output) {

  output$metrics_numberCG <- renderPlot({
    if(input$cov=="5X"){
      ggplot(q, aes(x=Project, y=Count)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
        coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
        ggtitle("Number of CpG units with ≥5X CpG Coverage in all projects")
    } else {
      ggplot(p, aes(x=Project, y=Count)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
        coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
        ggtitle("Number of CpG units with ≥10X CpG Coverage in all projects")  
    }
  })
  
  output$metrics_meanCG <- renderPlot({
    if(input$cov=="5X"){
      ggplot(q, aes(x=Project, y=Mean)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
        coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
        ggtitle("Mean Coverage of CpG units with ≥5x CpG Coverage in all projects")
    } else {
      ggplot(p, aes(x=Project, y=Mean)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
        coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
        ggtitle("Mean Coverage of CpG units with ≥10x CpG Coverage in all projects")
    }
  })
  
  output$overlap_plot <- renderPlot({
    if(input$cov=="5X"){
      rrbsxlist5 <- r.5x %>% filter(Percent.rrbs >= input$overlap) %>% select(Site) %>% as.list()
      errbsxlist5 <- e.5x %>% filter(Percent.errbs >= input$overlap) %>% select(Site) %>% as.list()
      x <- list(RRBS=rrbsxlist5[[1]], ERRBS=errbsxlist5[[1]])
      ggVennDiagram(x) + ggtitle(paste0(input$overlap, "% overlap")) + theme(legend.position="none")
    } else {
      rrbsxlist10 <- r.10x %>% filter(Percent.rrbs >= input$overlap) %>% select(Site) %>% as.list()
      errbsxlist10 <- e.10x %>% filter(Percent.errbs >= input$overlap) %>% select(Site) %>% as.list()
      y <- list(RRBS=rrbsxlist10[[1]], ERRBS=errbsxlist10[[1]])
      ggVennDiagram(y) + ggtitle(paste0(input$overlap, "% overlap")) + theme(legend.position="none")
    }
  })

}

# Run the application 
shinyApp(ui = ui, server = server)
