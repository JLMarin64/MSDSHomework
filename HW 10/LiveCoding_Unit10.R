# Lecture Assignment Material

fileLocation <- "http://stat.columbia.edu/~rachel/datasets/nyt1.csv"
df <- read.csv(url(fileLocation))

# Dividing numbers into categories
df$Age_Group <- cut(df$Age, c(-Inf, 18, 24, 34, 44, 54, 64, Inf))
levels(df$Age_Group) <- c("<18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+")

# Single Day: Plot distributions
# Problem: CTR is notoriously small-- small percentage click at all!
d1 <- subset(df, Impressions>0)
d1$CTR <- d1$Clicks/d1$Impressions

library(ggplot2)

# Impressions by age group
ggplot(subset(d1, Impressions>0), aes(x=Impressions, fill=Age_Group))+
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_histogram(binwidth=1)

# Click through by age group
ggplot(subset(d1, CTR>0), aes(x=CTR, fill=Age_Group))+
  labs(title="Click-through Rate by Age Group (05/01/2012)")+
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_histogram(binwidth=.025) +
  xlab("Probability of Click Through Rate: Clicks per Impression") +
  ylab("Count") +
  scale_fill_brewer(palette="Dark2", labels=c("Female", "Male")) +
  # scale_fill_manual(values=c("purple", "orange"), labels=c("Female", "Male")) +
  geom_histogram(binwidth=.025)