install.packages("hexSticker")

library(hexSticker)
library(lattice)

counts <- c(1,1,2,3,5,8)
outcome <- gl(3,1,9)
treatment <- gl(3,3)
bwplot <- bwplot(counts ~ outcome, xlab=NULL, ylab=NULL, cex=.5,
                 scales=list(cex=.5), par.strip.text=list(cex=.5))
sticker(bwplot, package="kmartinez", p_size=20, s_x=1.05, s_y=.8, s_width=2, s_height=1.5,
        h_fill="gray100", h_color="azure3", p_color = "navyblue")


#, filename="inst/figures/lattice.png"