## Print out str so that each line is max 13 characters and no words are broken.
str <- "Four score and seven years ago our fathers brought forth upon this continent a new nation conceived in liberty and dedicated to the proposition that all men are created equal"

wsplit(str) %+/>% nchar %>%
  thread2(fn(x, y, { list(y[[1]], (y[[2]] + x[[2]]) %% 13) })) %>%
  thread(fn(x, y, { list(y[[1]], x[[2]] < y[[2]]) })) %>%
  thread_while(fn(x, isTRUE(x[[2]]))) %//>%
  fn(x, x[[1]]) %/>%
  fn(x, collapse(x, " ")) %>%
  join("\n") %>% cat
