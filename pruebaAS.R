## A ver si con esto funciona.
git2r::config(
  global = TRUE,
  user.name = "straychild01",
  user.email = "stray.childhood@gmail.com"
)


librerias_a_usar <- c(
  "dplyr",
  "tidyr",
  "jsonlite",
  "googlesheets"
)
pacman::p_load(char=librerias_a_usar, install=T)

gs_auth(new_user = T)

