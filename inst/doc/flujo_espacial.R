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

# Obtener la geometría oficial de un distrito
distrito_sf <- obtener_poligono_distrito(
  distrito = "Machupicchu",
  departamento = "Cusco",
  provincia = "Urubamba"
)

distrito_sf

## -----------------------------------------------------------------------------
# Obtener polígono provincial unificado
provincia_sf <- obtener_poligono_provincia(
  provincia = "Tambopata",
  departamento = "Madre de Dios"
)

provincia_sf

