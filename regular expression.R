# Writer: JajunKoo
# Created date: 2019-12-07
# Modified date: 2019-12-07
# This code aims to learn the 'Regular Expressions as used in R'.
# Referenced from https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html

library(stringr)

fruit <- c("apple", "banana", "pear", "pinapple")
str_subset(fruit, '[ei]')  # []: matches any single character in []

numerics <- c('123','17-April','I-II-III', 'R 3.0.1')
str_subset(numerics, '[0-9]')  # [0-9]: matches any digit
str_subset(numerics, '[^0-9]')  # [^0-9]: exclude elements which contain only digits

# [[:lower:]]: Lower-case letters in the current locale.
# [[:upper:]]: Upper-case letters in the current locale.
# [[:alpha:]]: Alphabetic characters: [:lower:] and [:upper:].
# [[:digit:]]: Digits: 0 1 2 3 4 5 6 7 8 9.
# [[:alnum:]]: Alphanumeric characters: [:alpha:] and [:digit:].
# [[:punct:]]: Punctuation characters: ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~.
# [[:graph:]]: Graphical characters: [:alnum:] and [:punct:].
# [[:blank:]]: Blank characters: space and tab, and possibly other locale-dependent characters such as non-breaking space.
# [[:space:]]: Space characters: tab, newline, vertical tab, form feed, carriage return, space and possibly other locale-dependent characters.
# [[:print:]]: Printable characters: [:alnum:], [:punct:] and space.

str_subset(numerics, '[[:lower:]]')
str_remove_all(numerics, '[[:punct:]]')
