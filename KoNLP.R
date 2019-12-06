# Writer: JajunKoo
# Created date: 2019-12-05
# Modified date: 2019-12-07
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
