usethis::use_data_raw()
usethis::use_pipe()

usethis::use_r("data")
usethis::use_r("utils")

devtools::document()

usethis::use_pkgdown()
usethis::use_github_pages()
usethis::use_github_action("pkgdown")
pkgdown::build_site()
pkgdown::build_articles()
pkgdown::build_home_index(); pkgdown::init_site();pkgdown::preview_site()

#
# usethis::use_article(name = "namibian-hake-biomass-production",
#                      title = "Biomass Production Model: The Namibian Hake Fishery")
# usethis::use_article(name = "state-space-modeling-of-a-salmon-life-cycle-model",
#                      title = "State-space Modeling of A. Salmon Life Cycle Model")
# usethis::use_article(name = "hierarchical-stock-recruitment analysis",
#                      title = "Hierarchical Stock Recruitment Analysis")
# usethis::use_article(name = "hierarchical-exchangeable-cmr",
#                      title = "Hierarchical Exchangeable Binomial Model
#                      for Capture-Mark-Recapture Data")
# usethis::use_article(name = "hierarchical-stock-recruitment",
#                      title = "Hierarchical Stock Recruitment")
#
# usethis::use_article(name = "hierarchical-successive-removal",
#                      title = "Hierarchical Successive Removal")
# usethis::use_article(name = "hierarchical-succesive-removal-with-habitat-and-time-covariates",
#                      title = "Hierarchical Model for Successive Removal Data
#                      with Habitat and Time Covariates")

hexSticker::sticker(imgurl, package="hbm4ecology", p_size=19, s_x=1, s_y=.8, s_width= .69,
        h_fill = "#4da598", h_color = "#000000",
        filename="inst/figures/logo.png")
