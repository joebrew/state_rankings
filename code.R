#install.packages('rgdal')
library(rgdal)
root <- getwd()
setwd('data')

states <- readOGR('.', 'cb_2014_us_state_20m')
states <- states[!states$NAME %in% c('District of Columbia', 'Puerto Rico'),]

# Tier
states$tier <- c(1,1,3,3,1,4,3,3,4,3,
                 3,3,1,1,2,2,2,2,2,2,
                 4,2,4,3,1,4,2,1,4,1,
                 1,3,2,4,4,3,2,1,4,2,
                 4,3,3,4,2,1,4,3,1,4)

# Color
colors <- c('blue', 'green', 'yellow', 'red')
colors <- colorRampPalette(c('blue', 'white', 'red'))(4)
colors <- adjustcolor(colors, alpha.f = 0.6)
states$color <- colors[states$tier]

setwd(root)
png('states.png',
    width = 600, 
    height = 600)
plot(states, 
     xlim = c(-124.85, -62),
     ylim = c(24, 50),
     col = states$color,
     border = 'darkgrey', 
     lwd = 0.2)

legend('bottomleft',
       fill = colors,
       legend = paste0('Tier ', 1:4))

title(main = 'Arkansas sucks', cex.main = 2)
dev.off()
