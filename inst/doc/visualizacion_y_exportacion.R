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

## ----setup--------------------------------------------------------------------
library(peruocc)

## ----eval = FALSE-------------------------------------------------------------
# # Configurar el directorio raíz del proyecto para artefactos (opcional)
# peruocc_data_dir("mi-carpeta-proyecto")

## -----------------------------------------------------------------------------
# Paso 1: Consulta rápida en memoria (experimental / interactiva)
resultado <- buscar_especies_distrito(
  distrito = "Miraflores",
  departamento = "Lima",
  provincia = "Lima",
  grupo = "flora",
  limite_por_api = 150
)

# Paso 2: Inspeccionar resultados o graficar
summary(resultado$ocurrencias)

# Paso 3: Si los datos son conformes, exportar a disco
# exportar_resultados(resultado)

## ----mapa_fuente_viz, fig.alt = "Mapa de distribución de ocurrencias coloreado por repositorio de origen (GBIF vs iNaturalist)"----
# Visualizar diferenciando aportes de GBIF vs iNaturalist
mapa_fuente <- graficar_ocurrencias(
  resultado_lista = resultado,
  color_por = "source"
)

print(mapa_fuente)

## ----mapa_reino_viz, fig.alt = "Mapa de distribución de ocurrencias coloreado por reino taxonómico (Plantae vs Animalia)"----
# Visualizar distribución por reinos (Plantae, Animalia, Fungi, etc.)
mapa_reino <- graficar_ocurrencias(
  resultado_lista = resultado,
  color_por = "kingdom"
)

print(mapa_reino)

## ----personalizacion_mapa, fig.alt = "Mapa temático personalizado con tema minimal y títulos adicionales de ggplot2"----
library(ggplot2)

mapa_personalizado <- mapa_fuente +
  ggplot2::theme_minimal(base_size = 12) +
  ggplot2::labs(
    title = "Biodiversidad en Miraflores, Lima",
    subtitle = "Ocurrencias consolidadas vía peruocc (GBIF + iNaturalist)",
    caption = "Fuente: Repositorios de Biodiversidad / INEI geoperu"
  )

print(mapa_personalizado)

