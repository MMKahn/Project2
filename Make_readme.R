#This R script creates the README.md file that upon knitting the Project Rmd,
#will be created and automatically rendered by github into HTML.

rmarkdown::render(input = "Project2.Rmd", output_file = "README.md")
