## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = TRUE,
  fig.width = 8,
  fig.height = 5.5,
  fig.align = "center",
  out.width = "100%",
  dpi = 300,
  fig.retina = 2
)

## ----setup--------------------------------------------------------------------
library(peruocc)
library(sf)
library(ggplot2)

## ----crear_poligono-----------------------------------------------------------
# Coordenadas de los vértices del polígono (WGS84: Longitud, Latitud)
coordenadas <- matrix(
  c(
    -77.04, -12.06,
    -77.00, -12.06,
    -77.00, -12.02,
    -77.04, -12.02,
    -77.04, -12.06
  ),
  ncol = 2,
  byrow = TRUE
)

# Construir el objeto sf con proyección geográfica EPSG:4326 (WGS84)
mi_zona_estudio <- sf::st_as_sf(
  sf::st_sfc(sf::st_polygon(list(coordenadas)), crs = 4326)
)

print(mi_zona_estudio)

## ----consulta_poligono--------------------------------------------------------
resultado_personalizado <- buscar_especies_poligono(
  poligono = mi_zona_estudio,
  nombre = "Area_Estudio_Costa",
  grupo = "flora",
  limite_por_api = 25
)

## ----resumen_datos------------------------------------------------------------
# Resumen de registros por base de datos
print(resultado_personalizado$resumen)

# Vista previa de las primeras ocurrencias
head(resultado_personalizado$ocurrencias[, c("scientificName", "source", "eventDate", "decimalLatitude", "decimalLongitude")])

## ----mapa_fuente, fig.alt = "Mapa de distribución de ocurrencias de flora en área de estudio personalizada coloreado por repositorio de origen (GBIF vs iNaturalist)"----
mapa_fuentes <- graficar_ocurrencias(
  resultado_lista = resultado_personalizado,
  color_por = "source"
)

print(mapa_fuentes)

## ----mapa_reino, fig.alt = "Mapa de distribución de ocurrencias de flora en área de estudio personalizada coloreado por reino taxonómico"----
mapa_reinos <- graficar_ocurrencias(
  resultado_lista = resultado_personalizado,
  color_por = "kingdom"
)

print(mapa_reinos)

## ----ejemplo_buffer-----------------------------------------------------------
# 1. Definir coordenadas del punto central (WGS84: Longitud, Latitud)
punto_sitio <- sf::st_sfc(sf::st_point(c(-72.545, -13.163)), crs = 4326) # Valle de Urubamba / Machu Picchu

# 2. Proyectar a UTM Zona 18S (EPSG:32718) para calcular un buffer métrico exacto de 3 km
buffer_3km <- sf::st_buffer(sf::st_transform(punto_sitio, 32718), dist = 3000)

# 3. Consultar directamente (peruocc retransforma automáticamente a WGS84)
# resultado_buffer <- buscar_especies_poligono(
#   poligono = buffer_3km,
#   nombre = "Buffer_3km_Urubamba",
#   grupo = "flora",
#   limite_por_api = 50
# )

## ----consulta_archivo---------------------------------------------------------
# 1. Guardar el polígono temporalmente como archivo GeoJSON
ruta_capa <- file.path(tempdir(), "mi_reserva.geojson")
sf::st_write(mi_zona_estudio, ruta_capa, quiet = TRUE, delete_dsn = TRUE)

# 2. Consultar directamente pasando la ruta del archivo
resultado_desde_archivo <- buscar_especies_poligono(
  poligono = ruta_capa,
  nombre = "Reserva_Local",
  grupo = "flora",
  limite_por_api = 15
)

# 3. Exportar resultados con manifiesto de reproducibilidad en directorio temporal
archivos_exportados <- exportar_resultados(resultado_desde_archivo, dir_salida = tempdir())

