# Writer: JajunKoo
# Created date: 2019-12-08
# Modified date: 2019-12-08
# This code aims to learn the 'rvest' package.
# Referenced from https://cran.r-project.org/web/packages/rvest/rvest.pdf

library(rvest)
library(dplyr)
library(stringr)

# Read Daily Stock Price of Samsung Eletronics(https://finance.naver.com/item/sise_day.nhn?code=005930)
url <- 'https://finance.naver.com/item/sise_day.nhn?code=005930'

# How many pages there are?
guess_encoding(url)  # figure out what the real encoding is.
end_page <- read_html(url, encoding = 'EUC-KR') %>%  # Parse the HTML page.
  html_node('td.pgRR a') %>%  # Select nodes from and HTML document.
  html_attr('href')  # Extract the 'href' attribute from html.
npage <- str_sub(end_page, str_locate(end_page , 'page=')[,'end'] + 1) %>% as.numeric

# In earnest, read the data.
result <- NULL
for (i in 1:npage) {
  url_page <- str_c(url, '&page=', i)
  result <- rbind(result,
                  read_html(url_page, encoding = 'EUC-KR') %>%
                    html_node('table.type2') %>%
                    html_table())  # Parse an html table into a data frame.
  print(str_c('i = ', i, ' is completed(Total ', npage, ').'))
}
result <- rename(result,
                 date = 날짜,
                 cls_prc = 종가,
                 cmp_pre = 전일비,
                 stt_prc = 시가,
                 hig_prc = 고가,
                 low_prc = 저가,
                 trd_vlm = 거래량
)
result <- filter(result, date != '')
result$date <- as.Date(str_replace_all(result$date, '\\.', '-'))
result$cls_prc <- as.numeric(str_remove_all(result$cls_prc, '\\,'))
result$cmp_pre <- as.numeric(str_remove_all(result$cmp_pre, '\\,'))
result$stt_prc <- as.numeric(str_remove_all(result$stt_prc, '\\,'))
result$hig_prc <- as.numeric(str_remove_all(result$hig_prc, '\\,'))
result$low_prc <- as.numeric(str_remove_all(result$low_prc, '\\,'))
result$trd_vlm <- as.numeric(str_remove_all(result$trd_vlm, '\\,'))

result
