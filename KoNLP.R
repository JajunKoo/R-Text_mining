# Writer: JajunKoo
# Created date: 2019-12-05
# Modified date: 2019-12-05
# This code aims to learn the 'KoNLP' package.
# Referenced from http://https://cran.r-project.org/web/packages/KoNLP/vignettes/KoNLP-API.html

# load packages
library(KoNLP)  # Korean NLP Package

# Use dictionary
useNIADic()     # use Insighter and Woorimalsam dictionary
useSejongDic()  # use Sejong noun dictionary
useSystemDic()  # use system default dictionary

# Get dictionary
get_dictionary(dic_name = 'user_dic')  # dic_name: woorimalsam, insighter, sejong, user_dic

# Build dictionary
buildDictionary(ext_dic = c('sejong', 'woorimalsam', 'insighter'),
                user_dic = data.frame(term="족발", tag='ncn'),
                replace_usr_dic = T)

statDic()  # Summary of dictionaries

# Noun Extractor
txt <- '롯데마트가 판매하고 있는 흑마늘 양념 치킨이 논란이 되고 있다.'
extractNoun(txt)

# POS Tagger
SimplePos09(txt)  # POS tagging by using 9 KAIST tags
SimplePos22(txt)  # POS tagging by using 22 KAIST tags

# Hannanum morphological analyzer interface function
MorphAnalyzer(txt)

# Example (1)




txt <- readLines("hiphop.txt")
head(txt)



txt <- str_replace_all(txt, "\\W", " ")
nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word <- filter(df_word, nchar(word) >= 2)
top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top_20

pal <- brewer.pal(8,"Dark2")  # Dark2 색상 목록에서 8개 색상 추출

wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 2,          # 최소 단어 빈도
          max.words = 200,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(4, 0.3),     # 단어 크기 범위
          colors = pal)          # 색깔 목록

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 2,            # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(4, 0.3),       # 단어 크기 범위
          colors = pal)            # 색상 목록


twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")
nouns <- extractNoun(twitter$tw)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word <- filter(df_word, nchar(word) >= 2)
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top20

order <- arrange(top20, freq)$word               # 빈도 순서 변수 생성

ggplot(data = top20, aes(x = word, y = freq)) +  
  ylim(0, 2500) +
  geom_col() + 
  coord_flip() +
  scale_x_discrete(limit = order) +              # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3)     # 빈도 표시

pal <- brewer.pal(8,"Dark2")       # 색상 목록 생성

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록

pal <- brewer.pal(9,"Blues")[5:9]  # 색상 목록 생성

wordcloud(words = df_word$word,    # 단어
          freq = df_word$freq,     # 빈도
          min.freq = 10,           # 최소 단어 빈도
          max.words = 200,         # 표현 단어 수
          random.order = F,        # 고빈도 단어 중앙 배치
          rot.per = .1,            # 회전 단어 비율
          scale = c(6, 0.2),       # 단어 크기 범위
          colors = pal)            # 색상 목록
