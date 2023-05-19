install.packages("data.table")
install.packages("ggplot2")
install.packages("gridExtra")

library(data.table)
library(ggplot2)
library(gridExtra)


### LOOP AS A FUNCTION ###

# Create a data.table
dt <- data.table(A = c("A1", "A1", "A2", "A2", "A3", "A3" ,"A1"),
                 B = c(1, 2, 3, 4, 5, 6, 50),
                 C = c(7, 8, 9, 10, 11, 12, 100))

# STEP 1
# Define a function to sum columns B and C for each value in column A
sum_columns_BC <- function(unique_A) {
  # Create an empty list to store the tables
  result_list <- list()
  
  # Loop over each unique value in column A
  for (val in unique_A) {
    # Subset the data.table based on current value of A
    subset_dt <- dt[A == val, ]
    
    # Sum columns B and C
    summed_dt <- subset_dt[, .(Sum_B = sum(B), Sum_C = sum(C)), by = A]
    
    # Append the table to the result list
    result_list[[val]] <- summed_dt
  }
  
  # Bind all the tables together
  result <- rbindlist(result_list)
  
  # Return the final result
  return(result)
}

# STEP 2
# Get unique values of column A
unique_A <- unique(dt$A)

# STEP 3
# Call the function with unique_A as an argument
result <- sum_columns_BC(unique_A)

# Print the final result
print(result)

###########################
######### CHARTS ##########
# STEP 1
# Function to create bar charts for each value in column A

create_bar_charts <- function(unique_A, data) {
  plots <- list()
  
  for (val in unique_A) {
    subset_dt <- data[A == val, ]
    chart_title <- paste("Bar Chart for", val)
    
    categories <- c("Sum_B", "Sum_C")
    values <- subset_dt[, .(Sum_B, Sum_C)]

    
    df <- data.frame(Category = rep(categories, each = nrow(values)),
                     Value = unlist(values))
    
    chart <- ggplot(df) +
      geom_bar(aes(x = Category, y = Value), stat = "identity", fill = "steelblue") +
      labs(title = chart_title, x = "Category", y = "Value") +
      scale_fill_manual(values = colors)
      
      
    
    #print(chart)
    plots[[val]] <- chart

  }
  #layout <- do.call(grid.arrange, plots)
  #layout <- grid.arrange(grobs = plots, nrow = 1) ## horizontal
  layout <- do.call(grid.arrange, c(plots, nrow = 1))

  return(layout)
}

unique_A <- unique(result$A)
#create_bar_charts(unique_A, result)
layout <- create_bar_charts(unique_A, result)
print(layout)



