## A ver si con esto funciona.
use_git_config(user.name = "Jane", user.email = "jane@example.org")


librerias_a_usar <- c(
  "dplyr",
  "tidyr",
  "jsonlite",
  "googlesheets"
)
pacman::p_load(char=librerias_a_usar, install=T)

gs_auth(new_user = T)

