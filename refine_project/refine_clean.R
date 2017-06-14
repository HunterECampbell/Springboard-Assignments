#load libraries
install.packages("tidyr")
install.packages("dplyr")
library("tidyr")
library("dplyr")

#load csv file
refine_original <- read.csv("https://github.com/hcnureth/Springboard-Assignments/blob/master/refine_project/refine_original.csv")

#this was to alphabetize the company column
refine_clean <- refine_original %>% arrange(company)

#this was to make the company column more readable
refine_clean$company <- gsub("akzo|ak zo|akz0", "akzo", refine_clean$company, ignore.case = TRUE)
refine_clean$company <- gsub("fillips|philips|phillips|phlips|phillps|phllips", "philips", refine_clean$company, ignore.case = TRUE)
refine_clean$company <- gsub("unilever|unilver", "unilever", refine_clean$company, ignore.case = TRUE)
refine_clean$company <- gsub("van houten", "van houten", refine_clean$company, ignore.case = TRUE)

#making two columns out of "Product code / number"
refine_clean <- separate(refine_clean, Product.code...number, c("product_code", "product_number"), sep = "-")

#making a product categories column
refine_clean <- mutate(refine_clean, product_category = ifelse(refine_clean$product_code == "p", "Smartphone", ifelse(refine_clean$product_code == "v", "TV", ifelse(refine_clean$product_code == "x", "Laptop", "Tablet"))))

#moving the product categories column next to the product code and product number columns
refine_clean <- refine_clean[c("company", "product_category", "product_code", "product_number", "address", "city", "country", "name")]

#making one address column
refine_clean <- unite(refine_clean, "full_address", address, city, country, sep = ", ")

#making dummy binary variables for each company
refine_clean <- mutate(refine_clean, company_akzo = ifelse(company == "akzo", 1, 0))
refine_clean <- mutate(refine_clean, company_philips = ifelse(company == "philips", 1, 0))
refine_clean <- mutate(refine_clean, company_unilever = ifelse(company == "unilever", 1, 0))
refine_clean <- mutate(refine_clean, company_van_houten = ifelse(company == "van houten", 1, 0))

#making dummy binary variables for each product category
refine_clean <- mutate(refine_clean, product_smartphone = ifelse(product_category == "Smartphone", 1, 0))
refine_clean <- mutate(refine_clean, product_tv = ifelse(product_category == "TV", 1, 0))
refine_clean <- mutate(refine_clean, product_laptop = ifelse(product_category == "Laptop", 1, 0))
refine_clean <- mutate(refine_clean, product_tablet = ifelse(product_category == "Tablet", 1, 0))
