# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: simple leaflet map

f_map_simple <- function(data, geo_variable) {
  
  geo_variable <- rlang::ensym(geo_variable)
  
  figure <- data %>% 
    leaflet(options = leafletOptions(zoomControl = TRUE)) %>%
    #
    addProviderTiles("CartoDB.Positron") %>% 
    #
    addPolygons(fillColor   = pal(data[[geo_variable]]),
                color       = colour_black,
                weight      = 0.75,
                fillOpacity = 0.5,
                #
                label        = lapply(data$hover_text, htmltools::HTML),
                labelOptions = labelOptions(direction = "auto",
                                            style     = list("font-size"   = "11px",
                                                             "font-weight" = "normal")),
                #
                highlightOptions = highlightOptions(weight       = 2,
                                                    color        = "#666",
                                                    fillOpacity  = 0.9,
                                                    bringToFront = TRUE))
  
  return(figure)

}

