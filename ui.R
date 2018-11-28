library(googlesheets)
library(shiny)
library(highcharter)
library(plotly)
###### ---------------------------------


shinyUI(

  navbarPage("",
             tabPanel("Interview Mock",  
                      img(src = "logo.jpg", height = 90, width = 217),
                      hr(),
  fluidRow(
    column(4,
           h2("General Data", icon("address-card-o")), 
           p("Fill in the general data related to this mock. You can search by typing directly in the box."), 
           hr(), 
           # interviees dropdown
           uiOutput('e2'), # SEE SERVER.R (it is constructed there and rendered here)
           # interviewers dropdown
           uiOutput('e1'), # SEE SERVER.R (it is constructed there and rendered here)
           shiny::selectInput(inputId = 'type_interviewer', 
                                 choices = c("First year", "Second year", "External", "Career Services"),
                                 label = "Type of interviewer")
           ),
    column(4, 
           h2("Performance Metrics", icon("bar-chart-o")), 
           p("Helps this candidate understand his weak spots. Please be honest."), 
           hr(), 
           h3("STAR Structure"),
           HTML("<strong>1 = Poor </strong>- A full review of the STAR method required, doesn't respect the structure.</br> 
                <strong>4 = Outstanding </strong> - clearly follows the STAR method, understand how to use the STAR method and apply it to the asked questions"),
           shiny::sliderInput(inputId = "Structure",
                              label = "",
                              min = 1,
                              max = 4,
                              value = 3),
           hr(), 
           h3("Impact"),
           HTML("<strong>1 = Poor</strong> - Stories do not reflect impact; Lack of leadership, no results, learnings; stories reflect negatively on the candidate,.</br> 
                <strong>4 = Outstanding </strong> - Clear, insightful & impactful; Strong stories with great results and learnings; Quantifiable results"),
           shiny::sliderInput(inputId = "Impact",
                              label = "",
                              min = 1,
                              max = 4,
                              value = 3),
           hr(),
           h3("To the Point story telling"),
           HTML("<strong>1 = Poor</strong> - Doesn't answer to the question asked, rambling, stories are too long.</br> 
                <strong>4 = Outstanding </strong> - Succent and to the point, provides the right amonut of data and details, structured."),
           shiny::sliderInput(inputId = "Succent",
                              label = ":",
                              min = 1,
                              max = 4,
                              value = 3),
           h3("Communication"),
           HTML("<strong>1 = Poor</strong> - Low energy, lacks confidence; mindset is passive, resistant and/or confrontational; missing or unstructured conclusion; never pauses to recap or preview making it difficult to follow.</br> 
                <strong>4 = Outstanding </strong> - High energy, confident, but humble; adopts a collaborative mindset; consistently communicates by first stating key message then outlining before diving into details."),
           shiny::sliderInput(inputId = "communication",
                              label = ":",
                              min = 1,
                              max = 4,
                              value = 3)
  ), 
    column(4, 
           h2("General improvements", icon("cogs")), 
           p("Please give any specific feedback which is relevant to this candidate. The text can be as long as you want."), 
           hr(), 
           uiOutput('e3'), # SEE SERVER.R (it is constructed there and rendered here)
           shiny::textInput(inputId = "other", label = "Other improvements"),
           shiny::actionButton(inputId = "submit", label = "Submit", icon = icon("refresh")), 
           textOutput('submitwait'),
           textOutput('submitsucess')
           
           # ,textOutput('txt')
           
           )
)),
tabPanel("Results",  
         img(src = "logo.jpg", height = 90, width = 267),
         hr(),
         
         sidebarLayout(
           sidebarPanel(
            p("Compare your results here."),
             shiny::actionButton(inputId = "compare", label = "Compare", icon = icon("bullseye"))
             ),
           mainPanel(
             highchartOutput("hc_comparison")
           )
         )
) # tab panel

)
)