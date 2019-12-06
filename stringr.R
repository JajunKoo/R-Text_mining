# Writer: JajunKoo
# Created date: 2019-12-07
# Modified date: 2019-12-07
# This code aims to learn the 'stringr' package.
# Referenced from https://cran.r-project.org/web/packages/stringr/stringr.pdf
library(stringr)  # Simple, Consistent Wrappers for Common String Operations

# Join multiple strings into a single string. (=paste, paste0)
str_c('Letter: ', letters)
str_c('Letter', letters, sep = ': ')
str_c(letters, ' is for', '...')
str_c(letters[-26], ' comes before ', letters[-1])
str_c(letters, collapse = '')
str_c(letters, collapse = ', ')
str_c(1:3, c('!','?','+'), sep = '', collapse = '')

# The length of a string. (=nchar)
str_length(letters)
str_length(NA)
str_length(factor('abc'))
str_length(c('i', 'like', 'programming', NA))

# Extract and replace substrings from a character vector. (=substr, substring)
hw <- 'Hadley Wickham'
str_sub(hw, 1, 6)
str_sub(hw, end = 6)
str_sub(hw, 8, 14)
str_sub(hw, 8)
str_sub(hw, c(1, 8), c(6, 14))
str_sub(hw, -1)  # Negative indices
str_sub(hw, -7)
str_sub(hw, end = -7)
# Alternatively, you can pass in a two colum matrix, as in the output from str_locate_all
pos <- str_locate_all(hw, '[aeio]')[[1]]
str_sub(hw, pos)
str_sub(hw, pos[, 1], pos[, 2])
# Vectorisation
str_sub(hw, seq_len(str_length(hw)))
str_sub(hw, end = seq_len(str_length(hw)))
# Replacement form
x <- 'BBCDEF'
str_sub(x, 1, 1) <- 'A'; x
str_sub(x, -1, -1) <- 'K'; x
str_sub(x, -2, -2) <- 'GHIJ'; x
str_sub(x, 2, -2) <- ''; x
# If you want to keep the original if some argument is NA, use omit_na = TRUE
x1 <- x2 <- x3 <- x4 <- 'AAA'
str_sub(x1, 1, NA) <- 'B'
str_sub(x2, 1, 2) <- NA
str_sub(x3, 1, NA, omit_na = TRUE) <- 'B'
str_sub(x4, 1, 2, omit_na = TRUE) <- NA
x1; x2; x3; x4

# Duplicate and concatenate strings within a character vector.
fruit <- c('apple', 'pear', 'banana')
str_dup(fruit, 2)
str_dup(fruit, 1:3)
str_c('ba', str_dup('na', 0:5))

# Trim whitespace from a string.
str_trim(' String with trailing and leading white space\t')
str_trim('\n\nString with trailing and leading white space\n\n')
str_squish(' String with trailing,  middle, and leading white space\t')
str_squish('\n\nString with excess,  trailing and leading white space\n\n')

# Extract words from a sentence.
sentences <- c('Jane saw a cat', 'Jane sat down')
word(sentences, 1)
word(sentences, 2)
word(sentences, -1)
word(sentences, 2, -1)
# Also vectorised over start and end
word(sentences[1], 1:3, -1)
word(sentences[1], 1, 1:4)
# Can define words by other separators
str <- 'abc.def..123.4568.999'
word(str, 1, sep = fixed('..'))
word(str, 2, sep = fixed('..'))

# Vectorised over string and pattern. (=grep, grepl)
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "a"); str_which(fruit, "a"); str_subset(fruit, "a")
str_detect(fruit, "b"); str_which(fruit, "b"); str_subset(fruit, "b")
str_detect(fruit, "^a"); str_which(fruit, "^a"); str_subset(fruit, "^a")
str_detect(fruit, "a$"); str_which(fruit, "a$"); str_subset(fruit, "a$")
str_detect(fruit, "[aeiou]"); str_which(fruit, "[aeiou]"); str_subset(fruit, "[aeiou]")
# Also vectorised over pattern
str_detect("aecfg", letters); str_which("aecfg", letters); str_subset("aecfg", letters)
# Returns TRUE if the pattern do NOT match
str_detect(fruit, "^p", negate = TRUE)
str_which(fruit, "^p", negate = TRUE)
str_subset(fruit, "^p", negate = TRUE)
# Missings never match
str_detect(c("a", NA, "b"), ".")
str_subset(c("a", NA, "b"), ".")
str_which(c("a", NA, "b"), ".")
