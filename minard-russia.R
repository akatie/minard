
# Wilkinson, Leland. The Grammar of Graphics. Second. Springer, 2005. Print.
# Data for Mindard's graph, copied from Table 20.1 of Wilkinson

lonc <- c(24.0, 25.3, 26.4, 26.8, 27.7, 27.6, 28.5, 28.7, 29.2, 30.2, 
          30.4, 30.4, 32.0, 33.2, 34.3, 34.4, 36.0, 37.6, 36.6, 36.5)

latc <- c(55.0, 54.7, 54.4, 54.3, 55.2, 53.9, 54.3, 55.5, 54.4, 55.3,
          54.5, 53.9, 54.8, 54.9, 55.2, 55.5, 55.5, 55.8, 55.3, 55.0)

city <- c("Kowno", "Wilna", "Smorgoni", "Molodexno", "Gloubokoe", "Minsk", 
          "Studienska", "Polotzk", "Bobr", "Witebsk", "Orscha", "Mohilow", 
          "Smolensk", "Dorogobouge", "Wixma", "Chjat", "Mojaisk", "Moscou", 
          "Tarantino", "Malo-jarosewli")

cities <- data.frame(lonc, latc, city, stringsAsFactors = F)

lont <- c(37.6, 36.0, 33.2, 32.0, 29.2, 28.5, 27.2, 26.7, 25.3)
temp <- c(0, 0, -9, -21, -11, -20, -24, -30, -26)
date <- c("Oct 18", "Oct 24", "Nov 9", "Nov 14", 
          "", "Nov 28", "Dec 1", "Dec 6", "Dec 7")

temps <- data.frame(lont, temp, date, stringsAsFactors = F)


lonp <- c(24.0, 24.5, 25.5, 26.0, 27.0, 28.0, 28.5, 29.0, 30.0, 30.3, 
          32.0, 33.2, 34.4, 35.5, 36.0, 37.6, 37.7, 37.5, 37.0, 36.8, 
          35.4, 34.3, 33.3, 32.0, 30.4, 29.2, 28.5, 28.3, 27.5, 26.8, 
          26.4, 25.0, 24.4, 24.2, 24.1, 24.0, 24.5, 25.5, 26.6, 27.4, 
          28.7, 28.7, 29.2, 28.5, 28.3, 24.0, 24.5, 24.6, 24.6, 24.2, 24.1)

latp <- c(54.9, 55.0, 54.5, 54.7, 54.8, 54.9, 55.0, 55.1, 55.2, 55.3, 
          54.8, 54.9, 55.5, 55.4, 55.5, 55.8, 55.7, 55.7, 55.0, 55.0, 
          55.3, 55.2, 54.8, 54.6, 54.4, 54.3, 54.2, 54.3, 54.5, 54.3, 
          54.4, 54.4, 54.4, 54.4, 54.4, 55.1, 55.2, 54.7, 55.7, 55.6, 
          55.5, 55.5, 54.2, 54.1, 54.2, 55.2, 55.3, 55.8, 55.8, 54.4, 54.4)

survivors <- c(340000, 340000, 340000, 320000, 300000, 280000, 240000, 
               210000, 180000, 175000, 145000, 140000, 127100, 100000, 
               100000, 100000, 100000, 98000, 97000, 96000, 87000, 55000, 
               37000, 24000, 20000, 20000, 20000, 20000, 20000, 12000, 
               14000, 8000, 4000, 4000, 4000, 60000, 60000, 60000, 40000, 
               33000, 33000, 33000, 30000, 30000, 28000, 22000, 22000, 
               6000, 6000, 6000, 6000)

direction <- c(rep("A", 16), rep("R", 19), rep("A", 6), 
               rep("R", 4), rep("A", 3), rep("R", 3))

group <- c(rep("I", 16+19), rep("II", 6+4), rep("III", 3+3))

surv <- data.frame(lonp, latp, survivors, direction, group, 
                   stringsAsFactors = F)


# setup base plot
library(ggplot2); library(ggthemes)

p <- ggplot() + theme_void(base_size = 8)

# plot marching path
p1 <- 
  p +
  coord_equal() +
  geom_path(data=surv,
            mapping=aes(lonp, latp, color = direction, 
                group = group,
                size = survivors), lineend = "round") +
  scale_size(range = c(0.1, 15)) + 
  scale_color_manual(values = c("#DFC17E", "#252523")) +
  geom_text(data = cities,
            mapping = aes(lonc, latc, label = city), size = 2) +
  scale_y_continuous(limits = c(53, 60)) +
  scale_x_continuous(limits = c(20, 40)) +
  labs(x="", y="") +
  theme(legend.position = "")

# plot temperatures
p2 <- 
  p + 
  coord_fixed(ratio = .1) +
  geom_line(temps, 
            mapping = aes(lont, temp)) +
  geom_text(temps, 
            mapping = aes(lont, temp - 2, 
                          label = paste(temp, date)),
            size = 2) +
  scale_x_continuous(limits = c(20, 40)) +
  labs(x = "", y = "")

# combine plots
library(grid); library(gridExtra)

grid.arrange(p1, p2, heights = c(2, 1))






