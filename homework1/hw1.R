library(ggplot2) 
library(reshape)
data(movies) 
data(EuStockMarkets)

# extract 'budget' column
budget<-movies$budget

# select qualified rows
myrow<-movies[which(budget <= 0 ),]

#generate 'genre' vector
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

# add 'genre' into dataset
movies['genre']<-genre

# Transform the 'EuStockMarkets' dataset to a time series
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))

# Plot 1: Scatterplot
budget<-movies$budget
rating<-movies$rating
p<-ggplot(movies)+
  geom_point(aes(x=budget,y=rating),colour="green")+
  ggtitle("Scatter Plot")+
  xlab("Budget")+
  ylab("Rating")+
  theme(axis.ticks=element_blank(),
       axis.text=element_text(size=12))
print (p)
ggsave(p, file="hw1-scatter.png")

# Plot 2: Bar Chart
p<-ggplot(movies)+
  geom_bar(aes(x=factor(genre),group = factor(genre),
               fill = factor(genre)))+
  ggtitle("Bar Plot")+
  xlab("Genre")+
  ylab("Count")+
  theme(legend.position="none",axis.ticks=element_blank(),
        panel.grid.major.x=element_blank(),panel.grid.minor.y=element_blank(),
        axis.text.x=element_text(size=12))
print (p)
ggsave(p, file="hw1-bar.png")

# Plot 3: Small Multiples
formatter<-function(x){
  return(sprintf("%dM",as.integer(x/1000000)))
}
p<-ggplot(movies,width=18)+
  geom_point(aes(x=budget,y=rating,fill=genre,colour=genre))+
  facet_wrap(~genre)+
  ggtitle("Mutiple Scatterplot")+
  xlab("Budget")+
  ylab("Rating")+
  theme(axis.ticks=element_blank(),axis.text.x=element_text(size=8))+
  scale_x_continuous(
    expand=c(0,0),
    label=formatter
  )
  
print (p)
ggsave(p, file="hw1-multiples.png")

# Plot 4: Multi-Line Chart
p<-ggplot(eu,aes(x=time,colour="Index"))+
  geom_line(aes(y=DAX,colour="DAX"))+
  geom_line(aes(y=SMI,colour="SMI"))+
  geom_line(aes(y=CAC,colour="CAC"))+
  geom_line(aes(y=FTSE,colour="FTSE"))+
  ggtitle("Mutiple Line Plot")+
  xlab("Year")+
  ylab("Price")+
  theme(axis.ticks=element_blank(),axis.text.x=element_text(size=12))

ggsave(p, file="hw1-multiline.png")

