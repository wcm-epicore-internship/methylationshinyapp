library(shiny)
library(tidyverse)
library(ggVennDiagram)
load("all_projects.sample_count_mean.rda")
load("all_projects.sample_count_mean_5x.rda")
load("rrbs_data_for_overlap_plot.rda")
load("errbs_data_for_overlap_plot.rda")
load("rrbs_data_for_overlap_plot_5x.rda")
load("errbs_data_for_overlap_plot_5x.rda")

ui <- fluidPage(
    navbarPage("Comparison of DNA methylation data from RRBS and ERRBS samples",
        tabPanel("≥5x coverage",
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput("overlap5x",
                                     "% Overlap of CG sites covered ≥5x by RRBS and ERRBS samples:", 
                                     min = 1,
                                     max = 100,
                                     value = 50),
                         h5("Click on the gray circle under the blue number on the slider to see the plots. Then drag the slider
                            to adjust the % overlap for RRBS vs. ERRBS with ≥5x coverage.")
                     ),
                 mainPanel(
                     plotOutput("metrics_numberCG5x"),
                     plotOutput("metrics_meanCG5x"),
                     plotOutput("overlap_plot5x")
                 )
    )
    ),
        tabPanel("≥10x coverage",
                 sidebarLayout(
                     sidebarPanel(
                         sliderInput("overlap10x",
                                     "% Overlap of CG sites covered ≥10x by RRBS and ERRBS samples:", 
                                     min = 1,
                                     max = 100,
                                     value = 50),
                         h5("Click on the gray circle under the blue number on the slider to see the plots. Then drag the slider
                            to adjust the % overlap for RRBS vs. ERRBS with ≥10x coverage.")
                     ),
                 mainPanel(
                     plotOutput("metrics_numberCG10x"),
                     plotOutput("metrics_meanCG10x"),
                     plotOutput("overlap_plot10x")
                 )
    )
    )
)
)

server <- function(input, output) {
    output$metrics_numberCG5x <- renderPlot({
        ggplot(q, aes(x=Project, y=Count)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
            coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
            ggtitle("Number of CG units with ≥5x coverage in all projects")
    })
    output$metrics_meanCG5x <- renderPlot({
        ggplot(q, aes(x=Project, y=Mean)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
            coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
            ggtitle("Mean number of CG units with ≥5x coverage in all projects")
    })
    output$overlap_plot5x <- renderPlot({
        rrbsx5 <- r5x %>% filter(r5x$Percent.rrbs >= input$overlap5x)
        rrbsxlist5 <- as.list(rrbsx5$Site)
        errbsx5 <- e5x %>% filter(e5x$Percent.errbs >= input$overlap5x)
        errbsxlist5 <- as.list(errbsx5$Site)
        x <- list(RRBS=rrbsxlist5, ERRBS=errbsxlist5)
        ggVennDiagram(x) + ggtitle(input$overlap5x, "% overlap")
    })
    output$metrics_numberCG10x <- renderPlot({
        ggplot(p, aes(x=Project, y=Count)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
            coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
            ggtitle("Number of CG units with ≥10x coverage in all projects")
    })
    output$metrics_meanCG10x <- renderPlot({
        ggplot(p, aes(x=Project, y=Mean)) + geom_dotplot(binaxis="y", stackdir = "center", dotsize=0.3, aes(fill = Project)) + 
            coord_flip() + stat_summary(fun = median, fun.min = median, fun.max = median, geom = "crossbar", width = 0.5) +
            ggtitle("Mean number of CG units with ≥10x coverage in all projects")
    })
    output$overlap_plot10x <- renderPlot({
        rrbsx10 <- r %>% filter(r$Percent.rrbs >= input$overlap10x)
        rrbsxlist10 <- as.list(rrbsx10$Site)
        errbsx10 <- e %>% filter(e$Percent.errbs >= input$overlap10x)
        errbsxlist10 <- as.list(errbsx10$Site)
        y <- list(RRBS=rrbsxlist10, ERRBS=errbsxlist10)
        ggVennDiagram(y) + ggtitle(input$overlap10x, "% overlap")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
