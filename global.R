#### This script contains a general function for sending an email. 
#### It will use the mailR package, and take arguments from the results of the mock. 
#### IMPORTANT: The password of the consulting club gmail is stored in a local vector variable 
#### named: credential. This script reads it but it is not hard coded to avoid publishing it online. 
#### If the password changes, another one must be created and uploaded to shinyapps.io (you can also download the bundle from there)
library(htmlTable)
library(mailR)

# the password is stored here in a simple vector. 
# Off course I did not hard-code it, but it is still simple to hack this, so be careful.
load(file = "www/credential.RData")

send_fit_mail <- function(interviewer, 
                                 interviewee, 
                                 data_vector, categories){
  interviewer <- interviewer
  interviewee <- interviewee
  # categories <- c("Time", "Interviewee", "Interviewer", 
  #                 "Type of Interviewer", 
  #                 "Straight to the Point", "Something New", "Energy","Tell Me About Yourself Input", "Vivid Example", 
  #                 "Clear Conclusion", "S&W Input","STAR", 
  #                 "Impact", "To the Point Storytelling", "CBI Input",
  #                 "Posture", "Pause", 
  #                 "Body Language", "Attitude and Presence input")
  
  print(length(categories))
  print(length(data_vector))
  
  print(categories)
  print(data_vector)
  
  # Now, I am making a table with the names of categories and the data vector with results
  d <- htmlTable(data.frame(row.names = categories, 
                            "Results" = data_vector), 
                 align = "r|r", 
                 col.rgroup = c("none", "#ffe4e1")
                 
                 )
  
  # lets send the email! 
  mailR::send.mail(from = "consulting.iese@gmail.com",
            to = c(interviewee, interviewer), 
            subject = "Fit Results",
            body = paste0("<h2>Here are your results for your fit mock</h2></br>", HTML(d)),
            smtp = list(host.name = "smtp.gmail.com", port = 465, 
                        user.name = "consulting.iese@gmail.com", 
                        passwd = as.character(credential), ssl = TRUE),
            authenticate = TRUE,
            html = TRUE,
            send = TRUE)
}


send_fit_mail_test <- function(test = "eduardo.flores@iese.net", psswd = as.character(credential)){
  
  # lets send the email! 
  mailR::send.mail(from = "fitmockiese@gmail.com",
                   to = test, 
                   subject = "TEST",
                   body = "TEST EMAIL",
                   smtp = list(host.name = "smtp.gmail.com", port = 465, 
                               user.name = "fitmockiesteste@gmail.com", 
                               passwd = psswd, ssl = TRUE),
                   authenticate = TRUE,
                   html = TRUE,
                   send = TRUE)
}



