#### -----------------------------------------------------------------------------
#### IMPORTANT: This app is deployed as appName = mock. So, after setting up the account info
#### using rsconnect::setAcountInfo() with the token and secret in shinyapps.io, 
#### you have to run the command like this>
#### rsconnect::deployApp(appName = "fitmock", account = "iese")
####
#### -----------------------------------------------------------------------------
#### ----- PACKAGES AND CODES
#### Load these packages for the functions you need.
library(shiny)
library(googlesheets)
library(dplyr)
library(gmailr)
library(googleAuthR)
library(mailR)
library(plotly)
library(ggplot2)
library(highcharter)
library(googledrive)
source("global.R")


#### google authentification token...
#gm_auth_configure(path = "www/FitMockProject.json")
#gtoken<-gs_auth(new_user = TRUE, cache = FALSE)
#saveRDS(gtoken,"www/gtoken30Oct.rds")
gs_auth(token = "www/gtoken30Oct.rds")



#### -----------------------------------------------------------------------------
#### ----- LOADING STATIC DATA
#### I will load the data that does not change with the app. 
#### It is data already stored in googlesheets. 
#### VERY IMPORTANT: DO NOT CHANGE THE NAMES OF COLUMNS OR WORKSHEETS IN EACH SHEET!!!

#### here are the keys for each googlesheet we will use. 
#### To get a key> go to the sheet and get the share link, then 
#### do> googlesheets::gs_url("url...")
#### that will give you a key to use... 
key_interviewers <- "1fcz_yJBUiHMGsnibUjCHsfbmUF8M6vF5TeDounbIAAU"
key_results <- "13wYFf2y5r5G5NO4UcdVpvVpT24grYkcjeS0o5bh2MJM"

button_choices <- c("Overall Structure",
                    "Situation description", 
                    "Task description",
                    "Action description", 
                    "Results",
                    "Learnings",
                    "Energy and Enthusiasm", 
                    "Rambling")


#### Now, I am using the googlesheets package to load the interviewers sheet
mentors <- gs_key(key_interviewers, lookup = FALSE, visibility = "private") %>% 
  gs_read(ws = "Mentors") # only accessing one worksheet... 

mentees <- gs_key(key_interviewers, lookup = FALSE, visibility = "private") %>% 
  gs_read(ws = "Mentees") # accessing the other worksheet...

#### loading the results sheet (not reading, but keeping the connection open.)
results <- gs_key(key_results, lookup = FALSE, visibility = "private")

#### -----------------------------------------------------------------------------
##### ----------- SERVER
##### This is the collection of data that is "transmitted" in the shiny app to the 
##### user interface file (ui.R)
shinyServer(function(input, output) {
  
  #### ----- RENDERING PARTS OF THE UI 
  #### In this part, we will render some of the UI objects which depend on the information in the 
  #### google sheets (like interviewer email for example). 
  #### Once it is "rendered" in this server side, it will be shown in the UI side.
  #### I will name them "e+number" for element...
  #### -------------------
  
  #### e1 = interviewers drop-down menu
  output$e1 <- renderUI({
    shiny::selectizeInput(inputId = 'interviewer', 
                          choices = c("", mentors$Email),
                          label = "Interviewer (person conducting the mock)", selected = NULL)
  })
  #### e2 = interviewees drop-down menu
  output$e2 <- renderUI({
    shiny::selectizeInput(inputId = 'interviewee', 
                          choices = c("", mentees$Email), 
                          label = "Interviewee", selected = NULL)
  })
  #### e3 = button choices, I take from here so that when we filter to find exact matches to store, they are the same exact phrases
  output$e3 <- renderUI({
    shiny::checkboxGroupInput(inputId = "improvements", label = "Improvements",
                              choices = button_choices,
                              selected = ",")
  })

  #### -----------------------------------------------------------------------------
  #### ----- SAVING RESULTS
  #### When the submit botton is pressed, all the results in each UI element
  #### are recorded in a vector. Then, that is added as a row in the results googlesheet.

  #### The observeEvent changes whenever the submit button is pushed. The results vector is what is stored. 
  observeEvent(input$submit, {
    
    # People were pressing twice because of the lag between pressing and sending email, 
    # so I added this BEFORE the email to keep them waiting...
    Interview_Questions_vector<-c(input$Tell_Me,input$Strength,input$Weakness,input$CBI,input$Why_Company)
    if(sum(Interview_Questions_vector)==0){
      showNotification("Please select the type of interview") 
    }
    else{
    withProgress(message = 'Sending email ... ',{
      
      
#   button_vector <- button_choices %in% c(unlist(input$improvements))
      general_data_vector <- c(as.character(Sys.time()),input$interviewee,input$interviewer, input$type_interviewer)
      Tell_me_vector <-c(input$Straight,input$New,input$Energy,input$TellMeInput)
      Strength_vector <-c(input$StrengthVivid,input$StrengthClear,input$StrengthInput)
      Weakness_vector <-c(input$WeaknessVivid,input$WeaknessClear,input$WeaknessInput)
      CBI_vector <-c(input$STAR,input$impact,input$succinct,input$CBIInput)
      why_vector<-c(input$Specific,input$Robust,input$ToThePoint,input$WhyInput)
      general_attitude_vector <-c(input$Posture, input$Pause, input$BodyLang,input$AttitudeInput)
      
      
      
      
      #             adding a new row here using the googlesheets
      categories_vector <- c("Time","Interviewer","Interviewee", "Type of Interviewer") #This line is used in conjunction with the results_vector for e-mail purpose
      results_vector <- c(general_data_vector) #This helps to compile the information to be send via e-mail
      #The If-Statement helps to input the data at its respective tab(s)            
      if(input$Tell_Me ==TRUE){
        data_to_write <- as.data.frame(t(c(general_data_vector,Tell_me_vector)))
        results_vector <- c(results_vector,Tell_me_vector)
        categories_vector <- c(categories_vector, "<strong> Tell Me About Yourself </strong></br>Straight to the Point", "Something New", "Energy","Tell Me About Yourself Input")
        googlesheets::gs_add_row(gs_key(key_results, 
                                        lookup = FALSE, 
                                        visibility = "private"), 
                                 ws = "Tell_Me", 
                                 input = data_to_write
        )}
      if(input$Strength==TRUE){
        data_to_write <- as.data.frame(t(c(general_data_vector,Strength_vector)))
        results_vector <- c(results_vector,Strength_vector)
        categories_vector <-c (categories_vector, "<strong> Strength Questions </strong></br>Strength - Vivid Example",
                               "Strength - Clear Conclusion", "Strength Input")
        googlesheets::gs_add_row(gs_key(key_results,
                                        lookup = FALSE,
                                        visibility = "private"),
                                 ws = "Strength",
                                 input = data_to_write
        )}
      if(input$Weakness==TRUE){
        data_to_write <- as.data.frame(t(c(general_data_vector,Weakness_vector)))
        results_vector <- c(results_vector,Weakness_vector)
        categories_vector <-c (categories_vector, "<strong> Weakness Questions </strong></br>Weakness - Vivid Example",
                               "Weakness - Clear Conclusion", "Weakness Input")
        googlesheets::gs_add_row(gs_key(key_results,
                                        lookup = FALSE,
                                        visibility = "private"),
                                 ws = "Weakness",
                                 input = data_to_write
        )}
      if(input$CBI==TRUE){
        data_to_write <- as.data.frame(t(c(general_data_vector,CBI_vector)))
        results_vector <- c(results_vector,CBI_vector)
        categories_vector <-c (categories_vector, "<strong> Competency Based Questions </strong></br>STAR",
                               "Impact", "To the Point Storytelling", "CBI Input")
        googlesheets::gs_add_row(gs_key(key_results,
                                        lookup = FALSE,
                                        visibility = "private"),
                                 ws = "CBI",
                                 input = data_to_write
        )}
      if(input$Why_Company==TRUE){
        data_to_write <- as.data.frame(t(c(general_data_vector,why_vector)))
        results_vector <- c(results_vector,why_vector)
        categories_vector <-c (categories_vector, "<strong> Why Company Questions</strong></br>Sector Specific","Robustness","Succinct","Why Company Input")
        googlesheets::gs_add_row(gs_key(key_results,
                                        lookup = FALSE,
                                        visibility = "private"),
                                 ws = "Why_Company",
                                 input = data_to_write
        )}
      #if-statements end here
      googlesheets::gs_add_row(gs_key(key_results, 
                                      lookup = FALSE, 
                                      visibility = "private"), 
                               ws = "General_attitude", 
                               input = as.data.frame(t(c(general_data_vector,general_attitude_vector))))
      results_vector <- c(results_vector,general_attitude_vector)
      categories_vector <-c(categories_vector, "<strong> General Attitude </strong></br>Posture", "Pause", 
                  "Body Language", "Attitude and Presence input")
      ####### GOOGLESHEETS OLD CODE ###########
    #   
    #      results_vector <- c(as.character(Sys.time()), input$interviewee,input$interviewer,
    #                    input$type_interviewer, 
    #                    input$Straight, input$New,
    #                    input$Energy, input$TellMeInput ,input$vivid,
    #                    input$clear, input$SnWInput, input$STAR,
    #                    input$impact, input$succinct, input$CBIInput,
    #                    input$Posture, input$Pause, input$BodyLang,
    #                    input$AttitudeInput)
    # 
    # # adding a new row here using the googlesheets
    # googlesheets::gs_add_row(gs_key(key_results, 
    #                                 lookup = FALSE, 
    #                                 visibility = "private"), 
    #                          ws = "Results", 
    #                          input = results_vector)
    # 
    # sending the email (this function is stored in global.R)
    send_fit_mail(interviewer = as.character(input$interviewee), # sending to this guy
                         interviewee = as.character(input$interviewer), # also sending to this guy
                         data_vector = results_vector,
                         categories = categories_vector)
    })
     }
  })

  
  # Success text (when the email is successfully sent, you get a nice success message)
#  ts <- eventReactive(input$submit, {"Sucess! Data stored sent!"})
  output$submitsucess <- renderText(ts())
  
  
  #### -----------------------------------------------------------------------------
  #### ------- OUTPUTS FOR THE COMPARISON CHARTS
  #### This is to compare results, on the second tab. 
  #### First, we start importing data when the second action button is clicked
# ch <- eventReactive(input$compare, {
#   gs_key(key_results, lookup = FALSE, visibility = "private") %>% 
#       gs_read(ws = "Results")
#     })
  
  # ##### Second, we will render the highchart object
  # output$hc_comparison <- renderHighchart({
  #   
  #   # here are the results for this mock, taken from the inputs
  #   real_results <- c(input$Straight, input$New,
  #                     input$Energy, input$communication)
  #   
  #   # now, we are going to average out all the results for all the mocks.
  #   # we "select" the columns we want, then summarise them all by mean (average)
  #   results_df <- ch() %>% 
  #     dplyr::select("Structure", "Impact", "Succent", 
  #                   "Synthesis", "Communication") %>% 
  #     dplyr::summarise_all(.funs = "mean")
  #   
  #   # now I transpose the data.frame, so that columns are rows (just makes it easier to manipulate).
  #   results_df <- as.data.frame(t(results_df))
  #   names(results_df) <- "score"
  #   
  #   # now, we build the highchart
  #   highchart() %>% 
  #     hc_chart(type = "column") %>% 
  #     hc_add_series(data = results_df$score, 
  #                   name = "Average", 
  #                   color = "#9C2625") %>% 
  #     hc_add_series(data = real_results, 
  #                   name = "This Mock", 
  #                   color = "#c35f33") %>%
  #     hc_xAxis(categories = as.character(row.names(results_df))) %>%
  #     hc_exporting(enabled = TRUE)
  # })

})