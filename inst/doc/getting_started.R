## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 8,
  fig.height = 5.5,
  fig.align = "center",
  out.width = "100%",
  dpi = 300,
  fig.retina = 2
)

## -----------------------------------------------------------------------------
library(peruocc)

## ----eval = FALSE-------------------------------------------------------------
# # Configurar carpeta de salida personalizada (opcional)
# peruocc_data_dir("mi-carpeta-proyecto")

## -----------------------------------------------------------------------------
resultado_cusco <- buscar_especies_distrito(
  distrito = "Cusco",
  departamento = "Cusco",
  provincia = "Cusco",
  grupo = "flora",            # "flora", "fauna" o NULL
  limite_por_api = 150
)

## -----------------------------------------------------------------------------
resultado_urubamba <- buscar_especies_provincia(
  provincia = "Urubamba",
  departamento = "Cusco",
  grupo = "fauna",
  limite_por_api = 200
)

## -----------------------------------------------------------------------------
resultado_jaguar <- buscar_especies_distrito(
  distrito = "Tambopata",
  departamento = "Madre de Dios",
  provincia = "Tambopata",
  nombre_cientifico = "Panthera onca",
  limite_por_api = 50
)

## -----------------------------------------------------------------------------
names(resultado_cusco)
#> [1] "unidad_sf"   "ocurrencias" "resumen"     "parametros"

## -----------------------------------------------------------------------------
# Vista previa de las primeras ocurrencias
head(resultado_cusco$ocurrencias[, c("scientificName", "source", "eventDate", "decimalLatitude", "decimalLongitude")])

## -----------------------------------------------------------------------------
# Visualizar mapa coloreando por repositorio de origen (GBIF vs iNaturalist)
mapa <- graficar_ocurrencias(resultado_cusco, color_por = "source")
print(mapa)

## -----------------------------------------------------------------------------
# Exportar resultados a un directorio (por ejemplo, temporal para la viñeta)
archivos <- exportar_resultados(resultado_cusco, dir_salida = tempdir())

