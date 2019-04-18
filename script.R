install.packages("twitteR")
install.packages("RCurl")
install.packages("tm")
install.packages("wordcloud")
require('twitteR')
require('RCurl')
require(tm)
require(wordcloud)

consumer_key <- "#"
consumer_Secret <- "#"
access_token <- "#"
access_secret <- "#"

setup_twitter_oauth(consumer_key , consumer_Secret , access_token  , access_secret)

LFC_tweets <- searchTwitter("IK", n=1, lang = "en")
str(LFC_tweets)
LFC_tweets[1:3]

himearth <-searchTwitter('earthquake+himalaya', lang ="en", n= 15 , resultType = "recent")
class(himearth)
himearth_text <- sapply(himearth, function(x)x$getText())

str(himearth_text)

himcorpus <- VCorpus(VectorSource(himearth_text))
himcorpus
inspect(himcorpus)

him_clean <- tm_map(himcorpus, removePunctuation)
him_clean <-tm_map(him_clean,content_transformer(tolower))
him_clean <-tm_map(him_clean,removeWords,stopwords("english"))
him_clean <- tm_map(him_clean,removeNumbers)
him_clean <- tm_map(him_clean,stripWhitespace)
him_clean <- tm_map(him_clean,removeWords,c("himalaya","earthquake"))

wordcloud(him_clean)
wordcloud(him_clean,random.order = F)
wordcloud(him_clean,random.order = F, scale =c(3,.1) ,colors =rainbow(50)) 
