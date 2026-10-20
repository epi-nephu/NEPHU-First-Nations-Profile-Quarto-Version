# Gumunatj Ngarrngatj - NEPHU First Nations Population Profile
# Author: Alana Little, NEPHU (alana.little@austin.org.au)

# ------------------------------------------------------------------------------
# Chart type: simple leaflet map
# ------------------------------------------------------------------------------
f_map_simple <- function(data, geo_variable) {
  
  geo_variable <- rlang::ensym(geo_variable)
  
  figure <- data %>% 
    leaflet(options = leafletOptions(zoomControl = TRUE)) %>%
    #
    addTiles(
      urlTemplate = paste0("https://basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png?key=", api_carto),
      attribution = '&copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors &copy; <a href="https://carto.com">CARTO</a>') %>% 
    #
    addPolygons(fillColor   = pal(data[[geo_variable]]),
                color       = colour_black,
                weight      = 0.75,
                fillOpacity = 0.25,
                #
                label        = lapply(data$hover_text, htmltools::HTML),
                labelOptions = labelOptions(direction = "auto",
                                            style     = list("font-family" = "Karla",
                                                             "font-size"   = "11px",
                                                             "font-weight" = "normal")),
                #
                highlightOptions = highlightOptions(weight       = 2,
                                                    color        = "#666",
                                                    fillOpacity  = 0.5,
                                                    bringToFront = TRUE))
  
  return(figure)

}

