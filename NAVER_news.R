# Writer: JajunKoo
# Created date: 2019-12-15
# Modified date: 2019-12-15
# This code aims to analysis 'NAVER news'.

# load packages
library(rvest)
library(stringr)
library(KoNLP)
library(wordcloud)

# read news from NAVER.
npage <- 10

n_news <- lapply(seq(1, npage*10, by = 10),
                 function(start) {
  url <- str_c('https://search.naver.com/search.naver?&where=news&query=%EB%B6%80%EC%82%B0%EC%9D%80%ED%96%89&sm=tab_pge&sort=0&photo=0&field=0&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:all&mynews=0&cluster_rank=41&refresh_start=0&start=',
               start)
  rh <- read_html(url, encoding = 'UTF-8')
  title <-  html_nodes(rh, xpath = '//ul[@class="type01"]/li/dl/dt/a') %>% html_text()
  source <- html_nodes(rh, xpath = '//ul[@class="type01"]/li/dl/dd/span[@class="_sp_each_source"]') %>%
    html_text()
  content <- html_nodes(rh, xpath = '//ul[@class="type01"]/li/dl/dd[2]') %>% html_text()
  data.frame(title, source, content)
})
n_news <- do.call(rbind, n_news)

n_news$title <- str_squish(str_replace_all(n_news$title, '[[:punct:][:digit:]]', ' '))
n_news$content <- str_squish(str_replace_all(n_news$content, '[[:punct:][:digit:]]', ' '))

head(n_news)

useNIADic()
out <- extractNoun(n_news$content)
out_table <- do.call(c, out) %>% table()
out_table <- sort(out_table[str_length(names(out_table)) > 1], decreasing = T)

wordcloud(words=names(out_table), freq=out_table, min.freq=5, 
          random.order=F, random.color=T, colors=brewer.pal(8,"Dark2"))
