# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: leaflet map for population densities

f_map_density <- function(data) {
  
  pal <- colorNumeric(palette  = c(colour_gradient_low, colour_gradient_mid, colour_gradient_high),
                      domain   = data$pop_dens,
                      na.color = colour_white)
  
  figure <- leaflet(options = leafletOptions(zoomControl = TRUE)) %>%
    addProviderTiles("CartoDB.Positron") %>% 
    #
    addPolygons(data = data,
                #
                fillColor   = ~pal(pop_dens),
                color       = colour_black,
                weight      = 0.25,
                fillOpacity = 0.5,
                #
                label        = ~density_text,
                labelOptions = labelOptions(direction = "auto",
                                            style     = list("font-size"   = "11px", 
                                                             "font-weight" = "normal")),
                #
                highlightOptions = highlightOptions(weight       = 2,
                                                    color        = "#666",
                                                    fillOpacity  = 0.9,
                                                    bringToFront = TRUE)) %>%
    #
    addLegend(position  = "bottomright",
              values    = data$pop_dens,
              title     = "Population density<br>per square km",
              labFormat = labelFormat(suffix = ""),
              #
              pal     = pal,
              opacity = 1)
  
  return(figure)

}

