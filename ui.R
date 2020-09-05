library(googlesheets)
library(shiny)
library(highcharter)
library(plotly)
###### ---------------------------------


fluidPage(

#   navbarPage("",
# #             tabPanel("Tell me about yourself",  
#                       img(src = "logo.jpg", height = 90, width = 217),
#                       hr(),
  titlePanel(img(src = "logo.jpg", height = 90, width = 217)),
  fluidRow(
    column(3,
#           h1(img(src = "logo.jpg", height = 90, width = 217)),
           h2("General Data", icon("address-card-o")), 
           p("Fill in the general data related to this mock. You can search by typing directly in the box."), 
           hr(), 
           # interviees dropdown
           uiOutput('e2'), # SEE SERVER.R (it is constructed there and rendered here)
           # interviewers dropdown
           uiOutput('e1'), # SEE SERVER.R (it is constructed there and rendered here)
           shiny::selectInput(inputId = 'type_interviewer', 
                                 choices = c("First year", "Second year", "External", "CDC", "IESE Staff","MiM"),
                                 label = "Type of interviewer")
           ),
    column(5,
           h2("Performance Metrics", icon("bar-chart-o")),
           tabsetPanel(
             tabPanel("You",
                      h3("Tell Me About Yourself"),
                      
                      h5(HTML("Sample Questions:</br>Could you please tell me a bit more about yourself</br>
                                Could you please walk me through your CV?")),
                      hr(),
                      h4("Straight to the point"),
                      HTML("<strong>1 = Poor </strong>- Story was vague, complicated, and/or contained too much information.</br> 
                                <strong>5 = Outstanding </strong> - Story painted a simple, yet powerful picture of the person."),
                      shiny::sliderInput(inputId = "Straight",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Something new"),
                      HTML("<strong>1 = Poor</strong> - Story felt like a summary of the CV without revealing anything new.</br> 
                                <strong>5 = Outstanding </strong> - Provided something significant about him/her that does not appear on his/her CV. For example: about their driving force, passions, aspirations, motivations underpinning important decisions, etc."),
                      shiny::sliderInput(inputId = "New",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Energy"),
                      HTML("<strong>1 = Poor</strong> - Story came across either as completely improvised (i.e. not prepared at all) or like a robotic word-for-word recitation (i.e. well prepared but not yet internalized).</br> 
                                <strong>5 = Outstanding </strong> - Came to life while telling the story.  Story was delivered with conviction and from a place of strong grounding."),
                      shiny::sliderInput(inputId = "Energy",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      shiny::textInput(inputId = "TellMeInput", label = "Other improvements"),
                      
                      hr()
                      
             ),#TabPanel (Tell Me)
             tabPanel("Strengths",
                      h3("Strengths Questions"),
                      
                      h5(HTML("Sample Question:</br>What are your strengths?")),
                      hr(),
                      h4("Vivid Example"),
                      HTML("<strong>1 = Poor</strong> - Answered the question without sharing experience. Did not provide an example or an achievement to give the recruiter a chance to understand him/her at deeper level.</br> 
                        <strong>5 = Outstanding </strong> - Showed a clear moment that demonstrated how s/he acted and/or what impact it had. Provided a specific example of what that behavior, value, or quality looks like in action.</br>
                             Described the impact that it has had on the company / business with tangible results (or data)."),
                      shiny::sliderInput(inputId = "StrengthVivid",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Clear conclusion"),
                      HTML("<strong>1 = Poor</strong> - Showed opinions vs. experience. Did not show authenticity and honesty. Results were not measurable in some way (e.g. quantifiable or some form of qualitative result).</br> 
                                        <strong>5 = Outstanding </strong> - Explained how this strength could be used to the role / company targeted. Talked about ways he/she has been recognized for that strength from peers or managers. Showed self-awareness. Talked about what went well and what could have been better."),
                      shiny::sliderInput(inputId = "StrengthClear",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      shiny::textInput(inputId = "StrengthInput", label = "Other improvements"),
                      hr()
                      
             ),#TabPanel(Weakness)
             tabPanel("Weakness",
                      h3("Weakness Questions"),
                      
                      h5(HTML("Sample Questions: </br>What would you say is one of your weaknesses?</br>
                                            Tell me about 3 of your weaknesses.")),
                      hr(),
                      h4("Vivid Example"),
                      HTML("<strong>1 = Poor</strong> - Answered the question without sharing experience. Did not provide an example or an achievement to give the recruiter a chance to understand him/her at deeper level.</br> 
                        <strong>5 = Outstanding </strong> - Showed a clear moment that demonstrated how s/he acted and/or what impact it had. Provided a specific example of what that behavior, value, or quality looks like in action."),
                      shiny::sliderInput(inputId = "WeaknessVivid",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Clear conclusion"),
                      HTML("<strong>1 = Poor</strong> - Showed opinions vs. experience. Did not show authenticity and honesty.</br> 
                                        <strong>5 = Outstanding </strong> - Showed vulnerability, learning, improvement, or belief that demonstrated how he/she thinks. Showed him/herself striving to be a better person. Showed self-awareness about areas of possible improvement and action plan."),
                      shiny::sliderInput(inputId = "WeaknessClear",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      shiny::textInput(inputId = "WeaknessInput", label = "Other improvements"),
                      hr()
                      
             ),#TabPanel(Weakness)
             tabPanel("Competency Based",
                      h3("Competency based interview question"),
                      
                      h5(HTML("Sample Questions: </br>Tell me about a time when you had to resolve team conflict</br>
                                            Describe a time when you had to persuade a reluctant person to do something</br>
                                            Describe a time when you worked in a really effective team.</br>
                                            Give an example of complex and challenging problem you had to resolve</br>
                                            Describe a time when you had to work with unclear goals or changing priorities")),
                      hr(),
                      h4("STAR Structure"),
                      HTML("<strong>1 = Poor</strong> - Did not respect the content of the STAR method.</br> 
                <strong>5 = Outstanding </strong> - Clearly followed the STAR method, understood how to use the STAR method and applied it to the questions."),
                      shiny::sliderInput(inputId = "STAR",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Impact"),
                      HTML("<strong>1 = Poor</strong> - Story did not reflect impact. Lack of leadership, no results, learnings. Story reflected negatively on the candidate. Spoke negatively about a past employer or a co-worker.</br> 
                <strong>5 = Outstanding </strong> - Story is clear, insightful & impactful. Delivered strong stories with great results and learnings, quantifiable results."),
                      shiny::sliderInput(inputId = "impact",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("To the point story telling"),
                      HTML("<strong>1 = Poor</strong> - Did not answer to the question. Story is too long. Not structured.</br> 
                <strong>5 = Outstanding </strong> - Succinct and to the point. Provided the right amount of data and details. Structured."),
                      shiny::sliderInput(inputId = "succinct",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      shiny::textInput(inputId = "CBIInput", label = "Other improvements"),
                      hr()
                      
                      
             ),#TabPanel (CBI)
             tabPanel("Why",
                      h3("Why are you interested in this organization?"),
                      h5(HTML("Sample Questions: </br>Why are you interested in this company?</br> 
                                            Why should we hire you?")),                      
                      hr(),
                      h4("Company/Sector Specific"),
                      HTML("<strong>1 = Poor</strong> - Did not sound convincing, lacked motivation and enthusiasm. Sounded rehearsed and seems like the candidate uses the same answer to other companies.</br> 
                <strong>5 = Outstanding </strong> - Showed passion with authenticity for the Company/function/role (verbally and through body language). Let the recruiter understand that he/she researched the company and the role, in a very specific way (i.e. I love your products/services, especially. /I resonate with your Company values in this way../I know that your working culture is..and I know I could be at my best here because../The role you are offering aligns with my career vision in the respect of..)."),
                      shiny::sliderInput(inputId = "Specific",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      h4("Robust Why & What"),
                      HTML("<strong>1 = Poor</strong> - Sounded rehearsed and gave standard answers that did not allow the recruiter to gain an understanding of his/her personal drivers and of the contribution he/she could bring to the Company (i.e. 'I want to work here because your company is the market leader' is a very standard answer. It does not give the recruiter any understanding of the candidate).</br> 
                <strong>5 = Outstanding </strong> - Answer is clear, insightful & impactful. Delivered strongly with genuine reasons why he/she thinks he/she is the right person for the job. The candidate provided a robust 'Why' and what they bring to the table was clearly communicated. Was able to clearly communicate the value he/she could bring to the employer."),
                      shiny::sliderInput(inputId = "Robust",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      h4("To The Point"),
                      HTML("<strong>1 = Poor</strong> - Did not answer the question, is too long, and not structured.</br> 
                <strong>5 = Outstanding </strong> - Succinct and to the point. Provided the right amount of data and details. Structured."),
                      shiny::sliderInput(inputId = "ToThePoint",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      shiny::textInput(inputId = "WhyInput", label = "Other improvements"),
                      hr()
             )#tabPanel(Why)
    tabsetPanel(
             tabPanel("Technical",
                      h3("Technical Questions"),
                      
                      h5(HTML("Finance technical questions")),
                      hr(),
                      
                      h5(HTML("Accounting"))
                      h4("Conceptual Understanding"),
                      HTML("<strong>1 = Poor </strong>- Candidate displayed a weak understanding of underlying concepts and/or failed to apply them to questions asked. Weak arithmetic.</br> 
                                <strong>5 = Outstanding </strong> - Candidate displayed robust understanding of underlying concepts and was able to apply them in an effective manner to answer questions. Strong arithmetic."),
                      shiny::sliderInput(inputId = "Straight",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Delivery"),
                      HTML("<strong>1 = Poor</strong> - Vague, long, and unstructured delivery.</br> 
                                <strong>5 = Outstanding </strong> - Succinct and crisp. Provided the right amount details. Well structured."),
                      shiny::sliderInput(inputId = "New",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h5(HTML("Enterprise/Equity Value"))
                      h4("Conceptual Understanding"),
                      HTML("<strong>1 = Poor </strong>- Candidate displayed a weak understanding of underlying concepts and/or failed to apply them to questions asked. Weak arithmetic.</br> 
                                <strong>5 = Outstanding </strong> - Candidate displayed robust understanding of underlying concepts and was able to apply them in an effective manner to answer questions. Strong arithmetic."),
                      shiny::sliderInput(inputId = "Straight",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Delivery"),
                      HTML("<strong>1 = Poor</strong> - Vague, long, and unstructured delivery.</br> 
                                <strong>5 = Outstanding </strong> - Succinct and crisp. Provided the right amount details. Well structured."),
                      shiny::sliderInput(inputId = "New",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h5(HTML("Valuation Methods"))
                      h4("Conceptual Understanding"),
                      HTML("<strong>1 = Poor </strong>- Candidate displayed a weak understanding of underlying concepts and/or failed to apply them to questions asked. Weak arithmetic.</br> 
                                <strong>5 = Outstanding </strong> - Candidate displayed robust understanding of underlying concepts and was able to apply them in an effective manner to answer questions. Strong arithmetic."),
                      shiny::sliderInput(inputId = "Straight",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Delivery"),
                      HTML("<strong>1 = Poor</strong> - Vague, long, and unstructured delivery.</br> 
                                <strong>5 = Outstanding </strong> - Succinct and crisp. Provided the right amount details. Well structured."),
                      shiny::sliderInput(inputId = "New",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h5(HTML("M&A"))
                      h4("Conceptual Understanding"),
                      HTML("<strong>1 = Poor </strong>- Candidate displayed a weak understanding of underlying concepts and/or failed to apply them to questions asked. Weak arithmetic.</br> 
                                <strong>5 = Outstanding </strong> - Candidate displayed robust understanding of underlying concepts and was able to apply them in an effective manner to answer questions. Strong arithmetic."),
                      shiny::sliderInput(inputId = "Straight",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Delivery"),
                      HTML("<strong>1 = Poor</strong> - Vague, long, and unstructured delivery.</br> 
                                <strong>5 = Outstanding </strong> - Succinct and crisp. Provided the right amount details. Well structured."),
                      shiny::sliderInput(inputId = "New",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h5(HTML("LBOs"))
                      h4("Conceptual Understanding"),
                      HTML("<strong>1 = Poor </strong>- Candidate displayed a weak understanding of underlying concepts and/or failed to apply them to questions asked. Weak arithmetic.</br> 
                                <strong>5 = Outstanding </strong> - Candidate displayed robust understanding of underlying concepts and was able to apply them in an effective manner to answer questions. Strong arithmetic."),
                      shiny::sliderInput(inputId = "Straight",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Delivery"),
                      HTML("<strong>1 = Poor</strong> - Vague, long, and unstructured delivery.</br> 
                                <strong>5 = Outstanding </strong> - Succinct and crisp. Provided the right amount details. Well structured."),
                      shiny::sliderInput(inputId = "New",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      h4("Energy"),
                      HTML("<strong>1 = Poor</strong> - Story came across either as completely improvised (i.e. not prepared at all) or like a robotic word-for-word recitation (i.e. well prepared but not yet internalized).</br> 
                                <strong>5 = Outstanding </strong> - Came to life while telling the story.  Story was delivered with conviction and from a place of strong grounding."),
                      shiny::sliderInput(inputId = "Energy",
                                         label = "",
                                         min = 1,
                                         max = 5,
                                         value = 3),
                      
                      
                      
              ),#TabPanel (technical)
           )#TabsetPanel
    ),#columnMiddle
    column(4,
           h3("General attitude and presence"),
           hr(),
           h4("Posture"),
           HTML("<strong>1 = Poor</strong> - Lack of confidence. Passive mindset. Resistant and/or confrontational. Low energy.</br> 
                <strong>5 = Outstanding </strong> - Relaxed and engaged posture. High energy. Confident, but humble. Adopted a collaborative mindset."),
           shiny::sliderInput(inputId = "Posture",
                              label = "",
                              min = 1,
                              max = 5,
                              value = 3),
           
           h4("Pause - Pace of communication"),
           HTML("<strong>1 = Poor</strong> - Rambled. Used filler words like -um-. Never paused to recap or preview making it difficult to follow.</br> 
                <strong>5 = Outstanding </strong> - Breathed with pauses."),
           shiny::sliderInput(inputId = "Pause",
                              label = "",
                              min = 1,
                              max = 5,
                              value = 3),
           
           h4("Responsive body language"),
           HTML("<strong>1 = Poor</strong> - Gestures that distracted from their responses. Rigid or overly controlled.</br> 
                <strong>5 = Outstanding </strong> - Body language that shifted with the conversation. Smiled and opened."),
           shiny::sliderInput(inputId = "BodyLang",
                              label = "",
                              min = 1,
                              max = 5,
                              value = 3),
           shiny::textInput(inputId = "AttitudeInput", label = "Other improvements"),
           hr(),
           h4(HTML("<strong>Please select the type of interview that you have done for this session before hitting the submit button</strong>"),
           # checkboxGroupInput(
           #                    inputId = "Interview_Questions", 
           #                    label = "",
           #                    choices = c("Tell me about yourself" = "Tell_Me",
           #                                "Strength questions" = "Strength",
           #                                "Weakness questions" = "Weakness",
           #                                "Competency questions" = "CBI",
           #                                "Why this company" = "Why_Company")
           #                    ),
              
           checkboxInput("Tell_Me","Tell me about yourself"),
           checkboxInput("Strength","Strength questions"),
           checkboxInput("Weakness","Weakness questions"),
           checkboxInput("CBI","Competency questions"),
           checkboxInput("Why_Company","Why this company"),
           shiny::actionButton(inputId = "submit", label = "Submit", icon = icon("refresh")) 
           #textOutput('submitwait'),
           #textOutput('submitsucess')
    )#columnRight
    
  )#fluidrow
  )#fluidpage

##################### OLD CODE ####################
#     column(4, 
#            h2("Performance Metrics", icon("bar-chart-o")), 
#            p("Helps this candidate understand his weak spots. Please be honest."), 
#            hr(), 
#            h3("Tell me about yourself"),
#            hr(),
#            h4("Straight to the point"),
#            HTML("<strong>1 = Poor </strong>- Story was vague, complicated, and/or contained too much information.</br> 
#                 <strong>5 = Outstanding </strong> - Story painted a simple, yet powerful picture of the person."),
#            shiny::sliderInput(inputId = "Straight",
#                               label = "",
#                               min = 1,
#                               max = 5,
#                               value = 3),
#            
#            h4("Something new"),
#            HTML("<strong>1 = Poor</strong> - Story felt like a summary of the CV without revealing anything new.</br> 
#                 <strong>5 = Outstanding </strong> - Provided something significant about him/her that does not appear on his/her CV. For example: about their driving force, passions, aspirations, motivations underpinning important decisions, etc."),
#            shiny::sliderInput(inputId = "New",
#                               label = "",
#                               min = 1,
#                               max = 5,
#                               value = 3),
#            
#            h4("Energy"),
#            HTML("<strong>1 = Poor</strong> - Story came across either as completely improvised (i.e. not prepared at all) or like a robotic word-for-word recitation (i.e. well prepared but not yet internalized).</br> 
#                 <strong>5 = Outstanding </strong> - Came to life while telling the story.  Story was delivered with conviction and from a place of strong grounding."),
#            shiny::sliderInput(inputId = "Energy",
#                               label = ":",
#                               min = 1,
#                               max = 5,
#                               value = 3),
#            
#            shiny::textInput(inputId = "TellMeInput", label = "Other improvements"),
#            
#            hr()
#   ), 
#     column(4,
#            hr(),
#            h3("General attitude and presence"),
#            hr(),
#            h4("Posture"),
#            HTML("<strong>1 = Poor</strong> - Lack of confidence. Passive mindset. Resistant and/or confrontational. Low energy.</br> 
#                 <strong>5 = Outstanding </strong> - Relaxed and engaged posture. High energy. Confident, but humble. Adopted a collaborative mindset."),
#            shiny::sliderInput(inputId = "Posture",
#                               label = ":",
#                               min = 1,
#                               max = 5,
#                               value = 3),
#            
#            h4("Pause - Pace of communication"),
#            HTML("<strong>1 = Poor</strong> - Rambled. Used filler words like -um-. Never paused to recap or preview making it difficult to follow.</br> 
#                 <strong>5 = Outstanding </strong> - Breathed with pauses."),
#            shiny::sliderInput(inputId = "Pause",
#                               label = ":",
#                               min = 1,
#                               max = 5,
#                               value = 3),
#            
#            h4("Responsive body language"),
#            HTML("<strong>1 = Poor</strong> - Gestures that distracted from their responses. Rigid or overly controlled.</br> 
#                 <strong>5 = Outstanding </strong> - Body language that shifted with the conversation. Smiled and opened."),
#            shiny::sliderInput(inputId = "BodyLang",
#                               label = ":",
#                               min = 1,
#                               max = 5,
#                               value = 3),
#            shiny::textInput(inputId = "AttitudeInput", label = "Other improvements"),
#            hr(),
#            
#            
# #           h2("General improvements", icon("cogs")), 
# #           p("Please give any specific feedback which is relevant to this candidate. The text can be as long as you want."), 
# #           hr(), 
# #           uiOutput('e3'), # SEE SERVER.R (it is constructed there and rendered here)
# #           shiny::textInput(inputId = "other", label = "Other improvements"),
#            shiny::actionButton(inputId = "submit", label = "Submit", icon = icon("refresh")), 
#            textOutput('submitwait'),
#            textOutput('submitsucess')
#            
#            # ,textOutput('txt')
#            
#            )
# ))
#tabPanel("Strength and Weakness",  
#         img(src = "logo.jpg", height = 90, width = 217),
#         hr(),
#         fluidRow(
##           column(4,
#                  h2("General Data", icon("address-card-o")), 
#                  p("Fill in the general data related to this mock. You can search by typing directly in the box."), 
#                  hr(), 
                  # interviees dropdown
                  #uiOutput('e2'), # SEE SERVER.R (it is constructed there and rendered here)
                  # interviewers dropdown
                  #uiOutput('e1'), # SEE SERVER.R (it is constructed there and rendered here)
#                  shiny::selectInput(inputId = 'type_interviewer', 
#                                     choices = c("First year", "Second year", "External", "CDC", "IESE Staff","MiM"),
#                                     label = "Type of interviewer")
#           ),
#           column(4, 
#                  h2("Performance Metrics", icon("bar-chart-o")), 
#                  p("Helps this candidate understand his weak spots. Please be honest."), 
#                  hr(), 
#                  
#                  h3("Strength and Weakness Question"),
#                  hr(),
#                  h4("Vivid Example"),
#                  HTML("<strong>1 = Poor</strong> - Answered the question without sharing experience. Did not provide an example or an achievement to give the recruiter a chance to understand him/her at deeper level.</br> 
#                <strong>5 = Outstanding </strong> - Showed a clear moment that demonstrated how s/he acted and/or what impact it had. Provided a specific example of what that behavior, value, or quality looks like in action."),
#                  shiny::sliderInput(inputId = "vivid",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  h4("Clear conclusion"),
#                  HTML("<strong>1 = Poor</strong> - Showed opinions vs. experience. Did not show authenticity and honesty.</br> 
#                <strong>5 = Outstanding </strong> - Showed vulnerability, learning, improvement, or belief that demonstrated how he/she thinks. Showed him/herself striving to be a better person. Showed self-awareness about areas of possible improvement and action plan."),
#                  shiny::sliderInput(inputId = "clear",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  shiny::textInput(inputId = "SnWInput", label = "Other improvements"),
#                  hr()
#                  
#           ), 
#           column(4,
#                  hr(),
#                  h3("General attitude and presence"),
#                  hr(),
#                  h4("Posture"),
#                  HTML("<strong>1 = Poor</strong> - Lack of confidence. Passive mindset. Resistant and/or confrontational. Low energy.</br> 
#                <strong>5 = Outstanding </strong> - Relaxed and engaged posture. High energy. Confident, but humble. Adopted a collaborative mindset."),
#                  shiny::sliderInput(inputId = "Posture",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  h4("Pause - Pace of communication"),
#                  HTML("<strong>1 = Poor</strong> - Rambled. Used filler words like -um-. Never paused to recap or preview making it difficult to follow.</br> 
#                <strong>5 = Outstanding </strong> - Breathed with pauses."),
#                  shiny::sliderInput(inputId = "Pause",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  h4("Responsive body language"),
#                  HTML("<strong>1 = Poor</strong> - Gestures that distracted from their responses. Rigid or overly controlled.</br> 
#                <strong>5 = Outstanding </strong> - Body language that shifted with the conversation. Smiled and opened."),
#                  shiny::sliderInput(inputId = "BodyLang",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  shiny::textInput(inputId = "AttitudeInput", label = "Other improvements"),
#                  hr(),
#                  
#                  
#                  #           h2("General improvements", icon("cogs")), 
#                  #           p("Please give any specific feedback which is relevant to this candidate. The text can be as long as you want."), 
#                  #           hr(), 
                  #           uiOutput('e3'), # SEE SERVER.R (it is constructed there and rendered here)
                  #           shiny::textInput(inputId = "other", label = "Other improvements"),
#                  shiny::actionButton(inputId = "submit", label = "Submit", icon = icon("refresh")), 
#                  textOutput('submitwait'),
#                  textOutput('submitsucess')
                  
                  # ,textOutput('txt')
                  
#           )
#         )
#), # Strength & Weakness
#tabPanel("Competency Based",  
#         img(src = "logo.jpg", height = 90, width = 217),
#         hr(),
#         fluidRow(
#           column(4,
#                  h2("General Data", icon("address-card-o")), 
#                  p("Fill in the general data related to this mock. You can search by typing directly in the box."), 
#                  hr(), 
#                  # interviees dropdown
##                  #uiOutput('e2'), # SEE SERVER.R (it is constructed there and rendered here)
#                  # interviewers dropdown
#                  #uiOutput('e1'), # SEE SERVER.R (it is constructed there and rendered here)
#                  shiny::selectInput(inputId = 'type_interviewer', 
#                                     choices = c("First year", "Second year", "External", "CDC", "IESE Staff","MiM"),
#                                     label = "Type of interviewer")
#           ),
#           column(4, 
##                  h2("Performance Metrics", icon("bar-chart-o")), 
#                  p("Helps this candidate understand his weak spots. Please be honest."), 
#                  hr(), 
#                  
#                  h3("Competency based interview question"),
##                  hr(),
#                  h4("STAR Structure"),
#                  HTML("<strong>1 = Poor</strong> - Did not respect the content of the STAR method.</br> 
#                <strong>5 = Outstanding </strong> - Clearly followed the STAR method, understood how to use the STAR method and applied it to the questions."),
#                  shiny::sliderInput(inputId = "STAR",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  h4("Impact"),
#                  HTML("<strong>1 = Poor</strong> - Story did not reflect impact. Lack of leadership, no results, learnings. Story reflected negatively on the candidate. Spoke negatively about a past employer or a co-worker.</br> 
#                <strong>5 = Outstanding </strong> - Story is clear, insightful & impactful. Delivered strong stories with great results and learnings, quantifiable results."),
#                  shiny::sliderInput(inputId = "impact",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  h4("To the point story telling"),
#                  HTML("<strong>1 = Poor</strong> - Did not answer to the question. Story is too long. Not structured.</br> 
#                <strong>5 = Outstanding </strong> - Succinct and to the point. Provided the right amount of data and details. Structured."),
#                  shiny::sliderInput(inputId = "succinct",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  shiny::textInput(inputId = "CBIInput", label = "Other improvements"),
#                  hr()
#           ),
#           column(4,
#                  hr(),
#                  h3("General attitude and presence"),
#                 hr(),
#                  h4("Posture"),
#                  HTML("<strong>1 = Poor</strong> - Lack of confidence. Passive mindset. Resistant and/or confrontational. Low energy.</br> 
#                <strong>5 = Outstanding </strong> - Relaxed and engaged posture. High energy. Confident, but humble. Adopted a collaborative mindset."),
#                  shiny::sliderInput(inputId = "Posture",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  h4("Pause - Pace of communication"),
#                  HTML("<strong>1 = Poor</strong> - Rambled. Used filler words like -um-. Never paused to recap or preview making it difficult to follow.</br> 
##                <strong>5 = Outstanding </strong> - Breathed with pauses."),
#                  shiny::sliderInput(inputId = "Pause",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  
#                  h4("Responsive body language"),
#                  HTML("<strong>1 = Poor</strong> - Gestures that distracted from their responses. Rigid or overly controlled.</br> 
#                <strong>5 = Outstanding </strong> - Body language that shifted with the conversation. Smiled and opened."),
#                  shiny::sliderInput(inputId = "BodyLang",
#                                     label = ":",
#                                     min = 1,
#                                     max = 5,
#                                     value = 3),
#                  shiny::textInput(inputId = "AttitudeInput", label = "Other improvements"),
#                  hr(),
#                  
#                  shiny::actionButton(inputId = "submit", label = "Submit", icon = icon("refresh")), 
#                  textOutput('submitwait'),
##                  textOutput('submitsucess')
#                  
#                  )
#         )
#           ) #TabPanel Competency              
#) #navbar
) #close ShinyUI
