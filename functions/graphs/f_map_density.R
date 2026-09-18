# NEPHU Population Profile - Aboriginal Health
# Author: Alana Little, NEPHU (alana.little@austin.org.au)
# Version 2.0, 15/08/2025
#
# Chart type: leaflet map for population densities

f_map_density <- function(data) {
  
  pal <- colorNumeric(palette  = c(colour_maplow, colour_mapmid, colour_maphigh),
                      domain   = data$pop_dens,
                      na.color = colour_white)
  
  figure <- leaflet(options = leafletOptions(zoomControl = TRUE)) %>%
    #
    addTiles(
      urlTemplate = paste0("https://basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png?key=", api_carto),
      attribution = '&copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors &copy; <a href="https://carto.com">CARTO</a>') %>%
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
                                            style     = list("font-family" = "Karla",
                                                             "font-size"   = "11px", 
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

