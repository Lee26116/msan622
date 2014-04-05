library(ggplot2)
library(shiny)

loadData <- function() {
  data("movies", package = "ggplot2")
# prepare the dataset
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies<-data.frame(movies,genre)
data<-movies[which(movies$budget>0),]
data<-data[which(data$mpaa != ""),]
  return(data)
}

formatter<-function(x){
  return(sprintf("%dM",as.integer(x/1000000)))
}

getPlot <- function(localFrame,highlight="All",colorscheme="Default",
                    genre=NULL,dotsize,alphavalue) {
p<-ggplot(localFrame)+
    geom_point(aes(x=budget,y=rating,colour=mpaa),
               size=dotsize,alpha=alphavalue,position="jitter")+
    ggtitle("IMDB Moive Ratings")+
    xlab("Budget")+
    ylab("IMDB Rating")+
    labs(color="MPAA Ratings")+
    scale_x_continuous(
      expand=c(0,0),
      label=formatter
    )
p <- p + theme(panel.background = element_rect(fill = NA))
p <- p + theme(legend.key = element_rect(fill = NA))
p <- p + theme(panel.grid.major = element_line(color = "grey90"))
p <- p + theme(panel.grid.minor = element_line(color = "grey90", linetype = 3))
p <- p + theme(panel.border = element_blank())
p <- p + theme(legend.direction = "horizontal")
p <- p + theme(legend.justification = c(0, 0))
p <- p + theme(legend.position = c(0, 0))
p <- p + theme(legend.background = element_blank())
p <- p + theme(axis.ticks=element_blank())


if (colorscheme=="Accent"){
  p<-p+scale_color_brewer(palette = "Accent")  
  palette <- brewer_pal(type = "qual", palette = "Accent")(4)
}
else if (colorscheme=="Set1"){
  p<-p+scale_color_brewer(palette = "Set1") 
  palette <- brewer_pal(type = "qual", palette = "Set1")(4)
}
else if (colorscheme=="Set2"){
  p<-p+scale_color_brewer(palette = "Set2") 
  palette <- brewer_pal(type = "qual", palette = "Set2")(4)
}
else if (colorscheme=="Set3"){
  p<-p+scale_color_brewer(palette = "Set3") 
  palette <- brewer_pal(type = "qual", palette = "Set3")(4)
}
else if (colorscheme=="Dark2"){
  p<-p+scale_color_brewer(palette = "Dark2")  
  palette <- brewer_pal(type = "qual", palette = "Dark2")(4)
}
else if (colorscheme=="Pastel1"){
  p<-p+scale_color_brewer(palette = "Pastel1")
  palette <- brewer_pal(type = "qual", palette = "Pastel1")(4)
}
else if (colorscheme=="Pastel2"){
  p<-p+scale_color_brewer(palette = "Pastel2") 
  palette <- brewer_pal(type = "qual", palette = "Pastel2")(4)
}
else{
  p<-p+scale_color_brewer(palette = colorscheme) 
  palette <- brewer_pal(type = "qual", palette = "None")(4)
}

GENRE<-levels(localFrame$genre)
mpaa <- levels(droplevels(localFrame$mpaa))


if (highlight=="All"){
  if (length(genre)==0){
  p <- p + scale_color_manual(values = palette)
  return(p)}
  else{
    palette[which(!GENRE %in% genre)] <- "#EEEEEE"
    p <- p + scale_color_manual(values = palette)
    return(p)
  }
}
  else{
  if (length(genre)==0){
  palette[which(!mpaa %in% highlight)] <- "#EEEEEE"
  p <- p + scale_color_manual(values = palette)
  return(p)
  }
  else{
    palette[which(!mpaa %in% highlight | !GENRE %in% genre)] <- "#EEEEEE"
    p <- p + scale_color_manual(values = palette)
    return(p)  
  }
}
}

globalData <- loadData()

shinyServer(function(input, output) {
  
  cat("Press \"ESC\" to exit...\n")
  localFrame <- globalData
 
  
  output$table <- renderTable(
{
  index<-c("length","budget","rating","votes")
  
  return(summary(localFrame[index]))
},
include.rownames = FALSE
  )

output$scatterplot <- renderPlot(
{
  scatterplot <- getPlot(
    localFrame,
    input$highlight,
    input$colorscheme,
    input$genre,
    input$dotsize,
    input$alphavalue
  )
  
  print(scatterplot)
},
width = 600,
height = 600
)
})

