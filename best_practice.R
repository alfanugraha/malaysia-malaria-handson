# step 1.2

usethis::use_r("risk_index")       # R/risk_index.R  — core model
usethis::use_r("plot")             # R/plot.R         — visualisation

dir.create("data/raw",        recursive = TRUE)
dir.create("data/processed",  recursive = TRUE)
dir.create("outputs/maps",    recursive = TRUE)
dir.create("outputs/figures", recursive = TRUE)

# step 1.3

usethis::use_readme_md()

# Spatial data files can be huge — never commit raw rasters
usethis::use_git_ignore(c(
  "data/raw/",
  "*.tif", "*.shp", "*.dbf", "*.prj", "*.shx",  # spatial files
  ".Rhistory", ".RData"
))


# step 2.1

renv::init()

install.packages(c("terra", "sf", "geodata",
                   "ggplot2", "tidyterra", "patchwork"))
renv::snapshot()

# step 3.1

usethis::use_git()

usethis::use_github(private = FALSE)
usethis::use_github(organisation = "CEH-group", private = FALSE)

# Anyone clones this with:
#
# git clone https://github.com/yourname/malaria-risk-demo
#
# Then inside the project: `renv::restore()` — identical environment."


Editted one


