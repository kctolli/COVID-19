basis <- "DAILY" #"once", "WEEKLY, "MONTHLY"

task_name <- "owid"

loc <- "D:\\COVID-project\\read-data\\OWID.R" 

time <- "01:30"

# Create a new task

system(sprintf('schtasks /create /sc %s /tn %s /tr "%s" /st %s', basis, task_name, loc, time))

# To check you may open the scheduled tasks

# system("control schedtasks")