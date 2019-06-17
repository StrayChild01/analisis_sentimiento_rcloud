# Esto es para usar github en rstudio.cloud
git2r::config(
  global = TRUE,
  user.name = "straychild01",
  user.email = "stray.childhood@gmail.com"
)

# Para abrir la URL de datos.gob.sv
library(httr)
# Para trabajar con el json que regresa la API
library(jsonlite)
# Para transformar el json rectangular
library(reshape2)

# Se limitan los datos para probar
# limite_datos <- "limit=5"
limite_datos <- ""
url_base <- "http://datos.gob.sv"
# URL de la API de los datos
url_ehpm_2017 <- "http://datos.gob.sv/api/3/action/datastore_search?resource_id=fe8842f0-fdf8-4c6b-9e5a-bc3adc5c97be"

# Unimos las dos cadenas de caracteres
url_ehpm_2017 <- paste(url_ehpm_2017, limite_datos, sep="&")

# Se abre la URL:
# Si se necesita autentificación, se usa:
# GET(url, authenticate(username,password, type = "basic"))
datos_ehpm <- GET(url_ehpm_2017)

# Esto regresa lo siguiente:
# Response [http://datos.gob.sv/api/3/action/datastore_search?resource_id=fe8842f0-fdf8-4c6b-9e5a-bc3adc5c97be&limit=5]
# Date: 2019-06-16 22:38
# Status: 500
# Content-Type: application/json;charset=utf-8
# Size: 176 B

# Extraemos el texto de la petición, en este caso es un JSON
datos_ehpm_texto <- content(datos_ehpm, "text")

# Convertimos el texto a entidades de JSON
datos_ehpm_json <- fromJSON(datos_ehpm_texto, flatten = TRUE)

datos_ehpm_df <- as.data.frame(datos_ehpm_json$result$records)

for (x in 1:8750) {
  #try {
    siguiente_fetch <- "http://datos.gob.sv/api/3/action/datastore_search?resource_id=fe8842f0-fdf8-4c6b-9e5a-bc3adc5c97be&offset="
    offset<-x*100
    url_ehpm_2017 <- paste(siguiente_fetch, offset, sep="")
    print(url_ehpm_2017)
    datos_ehpm <- GET(url_ehpm_2017)
    datos_ehpm_texto <- content(datos_ehpm, "text")
    datos_ehpm_json <- fromJSON(datos_ehpm_texto, flatten = TRUE)
    datos_ehpm_df <- rbind(datos_ehpm_df, as.data.frame(datos_ehpm_json$result$records))
  #}
  #except {
  #  print("Hubo un problema")
  #  x <- 8750
  #}
}

