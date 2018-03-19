# Solution - Breakout Groups

fileLocation <- "http://stat.columbia.edu/~rachel/datasets/nyt2.csv"
df <- read.csv(url(fileLocation))

# Dividing numbers into categories
df$Age_Group <- cut(df$Age, c(-Inf, 18, 24, 34, 44, 54, 64, Inf))
levels(df$Age_Group) <- c("<18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+")

# Single Day: Plot distributions
# Problem: CTR is notoriously small-- small percentage click at all!
d2 <- subset(df, Impressions>0)
d2$CTR <- d2$Clicks/d2$Impressions

library(ggplot2)

# Check assumptions!!
sapply(d2, class)

d2$Gender<-as.factor(d2$Gender)

# Click through by Gender
ggplot(subset(d2, CTR>0), aes(x=CTR, fill=Gender))+
  labs(title="Click-through-Rate Count by Gender")+
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Probability of Click Through Rate: Clicks per Impression") +
  ylab("Count") +
  scale_fill_brewer(palette="Dark2", labels=c("Female", "Male")) +
  # scale_fill_manual(values=c("purple", "orange"), labels=c("Female", "Male")) +
  geom_histogram(binwidth=.025)