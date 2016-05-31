which_ <- function(bools) {
  bools %>% lzip(seq_along(.), .) %:/>% second %/>% first
}



`1` <- first <- function(xs) { xs[[1]] }
`2` <- second <- function(xs) { xs[[2]] }
`3` <- third <- function(xs) { xs[[3]] }
`4` <- fourth <- function(xs) { xs[[4]] }
last <- function(xs) { xs[[length(xs)]] }
init <- function(xs) { xs[-length(xs)] }
dropn <- function(xs, n) { tail(xs, -n) }
final <- function(xs) { xs[-1] }

reduce <- function(xs, f, init) { Reduce(f, xs, init) }

reduce1 <- function(xs, f) { reduce(xs, f, 1) }

fmap <- function(f, xs) { map(xs, function(y) { function(x) { f(x, y) }}) }


`%|all%` <- `%|%` <- compose_all <- function(x, y) {
  if (is.null(x) || is.na(x) || length(x) == 0) { y } else { x }
}
`%|0%` <- compose_zero <- function(x, y) { if (length(x) == 0) { y } else { x } }
`%|null%` <- `%||%` <- compose_null <- function(x, y) { if(is.null(x)) { y } else { x } }
`%|na%` <- `%|||%` <- compose_na <- function(x, y) { if(is.na(x)) { y } else { x } }

lget <- `%:%` <- function(xs, accessor) {
  if (is.function(accessor)) { accessor(xs) }
  else { reduce(accessor, `[[`, xs) }
}

lens <- function(accessor) curry(accessor = accessor)

lset <- function(xs, accessor, val) {
  #TODO: allow function composition to return index.
  if (is.function(accessor)) { stop("Cannot set with a function accessor.") }
  xs[[index(xs, accessor)]] <- val
  xs
}
`%<-%` <- function(lens, val) {
  # If you have lget return a lens class that stores the original list as metadata, then %<-% can work as an infix.
  assign(extract_variable(lens), lset(extract_object(lens), extract_accessor(lens), val))
}


lexists <- `%?%` <- function(xs, accessor) {
  !is.null(errors_are_null(get(xs, accessor)))
}


# lc <- list(a = list(b = list(c = seq(3)), d = list(e = seq(4))))

index <- function(xs, accessors) {
  out <- vector("list", length(accessors))
  for (i in seq_along(accessors)) {
    out[[i]] <- which(names(xs) == accessors[[i]]) %|% accessors[[i]]
    xs <- xs[[accessors[[i]]]]
  }
  unlist(out)
}
# index(lc, list("a", "b", "c", 3))
# [1] 1 1 1 3


# lget(lc, `1` %.% `2` %.% `1` %.% `3`)
# [1] 3
# lc %:% (`1` %.% `2` %.% `1` %.% `3`)
# [1] 3
# lget(lc, list("a", "b", "c", 3))
# [1] 3
# lc %:% list("a", "b", "c", 3)
# [1] 3


# meetups %:% c("location", "coords") %::% c("latitude", "longitude")
# lget(meetups, view = c("location", "coords"), extract = c("latitude", "longitude"))


# # ld <- lset(lc, `1` %.% `2` %.% `1` %.% `3`, 20)
# # lget(ld, `1` %.% `2` %.% `1` %.% `3`)
# # [1] 3

# # ld <- (lc %:% (`1` %.% `2` %.% `1` %.% `3`) %<-% 20)
# # ld %:% (`1` %.% `2` %.% `1` %.% `3`)
# # [1] 20

# # le <- lset(lc, list("a", "b", "c", 3), 20)
# # lget(le, list("a", "b", "c", 3))
# # [1] 20

# # le <- lc
# # le %:% list("a", "b", "c", 3) %<-% 20
# # lget(le, list("a", "b", "c", 3))
# # [1] 20

# # lf <- lc
# # lf %:% (`1` %.% `2` %.% `1` %.% `3`) %<-% 20
# # lf %:% (`1` %.% `2` %.% `1` %.% `3`)
# # [1] 20

flip <- function(f) { function(...) { do.call(f, rev(list(...))) } }
# subtract(3, 5)
# -2
# flip(subtract)(3, 5)
# 2


with_errors_as <- errors_are <- function(are, exp) {
  tryCatch(exp, error = function(e) are)
}
errors_are_na <- function(exp) { errors_are(NA, exp) }
errors_are_null <- function(exp) { errors_are(NULL, exp) }
errors_are_false <- function(exp) { errors_are(FALSE, exp) }
errors_are_warnings <- function(exp) { tryCatch(exp, error = function(e) warning(e)) }


accumulate <- function(xs, f) {
  outs <- list(head(xs, 1))
  f2 <- function(...) {
    out <- f(...)
    outs <<- append(outs, out)
    out
  }
  reduce(xs, f2)
  outs
}
# accumulate(seq(5), sum)
# # cumsum <- curry(accumulate, f = sum)


flatten <- function(xs) { as.list(unlist(xs)) }

compact <- function(xs) {
  filter(xs, function(x) !is.null(x) || !suppressWarnings(is.na(x)))
}

collapse <- function(str, collapse = "") {
  paste0(str, collapse = collapse)
}

join <- function(l, join = "") {
  collapse(unlist(l), collapse = join)
}


stretch <- function(xs, n) { rep(xs, each = n) }
ldouble <- curry(stretch, n = 2)
ltriple <- curry(stretch, n = 3)

interleave <- function(xs, ys) { flatten(zip(xs, ys)) }

interpose <- function(xs, item) {
  interleave(xs, rep(item, length(xs)))
}

frequencies <- function(xs) {
  xs %>% unlist %>% rle %>% {
    setNames(.$lengths, .$values)
  }
}

symdiff <- symmetric_difference <- function(xs, ys) {
  c(setdiff(xs, ys), setdiff(ys, xs))
}

chunk <- chunk <- function(xs, n) { unname(split(xs, ceiling(seq_along(xs) / n))) }
# # R-EXP> chunk(seq(10), 3)
# # [[1]]
# # [1] 1 2 3

# # [[2]]
# # [1] 4 5 6

# # [[3]]
# # [1] 7 8 9

# # [[4]]
# # [1] 10

partition <- function(xs, f) {
  filtered <- filter(xs, f)
  list(filtered, setdiff(xs, filtered))
}
# # partition(seq(10), is_even)
# # [[1]]
# # [1]  2  4  6  8 10

# # [[2]]
# # [1] 1 3 5 7 9


named <- function(xs) {
  !is.null(names(xs))
}

unnamed <- Negate(named)

sort_keys <- function(xs) {
  if (unnamed(xs)) { return(xs) }
  xs[sort(names(xs))]
}

sort_keys_by <- function(xs, by_f) {
  if (unnamed(xs)) { return(xs) }
  xs[sort_by(names(xs), by_f)]
}


# # S = [x**2 for x in range(10)]

# # S <- map(seq(10), curry(`^`, e1 = 2))


# # V = [2**i for i in range(13)]

# # V <- map(seq(13), curry(`^`, 2))


# # M <- [x for x in S if x % 2 == 0]

# # M <- filter(S, function(x) x %% 2 == 0)
# # M <- filter(S, curry(`%%`, 2) %>% curry(`==`, 0))


# # words = 'The quick brown fox jumps over the lazy dog'.split()
# # stuff = [[w.upper(), w.lower(), len(w)] for w in words]

lsplit <- function(str) { strsplit(str, "")[[1]] }
wsplit <- function(str) { strsplit(str, " ")[[1]] }
# # words <- wsplit('The quick brown fox jumps over the lazy dog')
# # stuff <- map(words, function(w) { list(toupper(w), tolower(w), length(w)) })


dec <- function(x) x - 1
inc <- function(x) x + 1

div <- function(x, y) x %% y == 0

self_map <- function(xs, f) { f(xs, stretch(xs, length(xs))) }

# # # Euler 1
# # 1000 %>% dec %>% seq %/>% curry(div, y = c(3, 5)) %_/>% or %\>% which %_>% `+`

# # # Euler 2
# # fib <- infseq({result <- 0; b <- 1; function() { c(result, b) %<-% c(b, result + b) }})
# # fib %>% take_while(curry(`<=`, e2 = 4000000)) %:>% is_even %_>% `+`

# # # Euler 3
# # roots <- . %>% sqrt %>% floor %>% seq(2, .)
# # isPrime <- function(n) { n %>% dec %>% roots %:>% curry(div, x = n) %>% null }
# # largest_prime_factor <- function(n) { roots(n-1) %:>% (curry(div, x = n) %&.% isPrime) %\>% max }
# # largest_prime_factor(600851475143)

# # # Euler 4
# # is_palindrome <- . %>% as.character %>% lsplit %>% { rev(.) == . } %>% all
# # self_map(seq(100, 999), `*`) %>% unique %:>% is_palindrome %>% max

grepv <- function(str, pattern) { grep(pattern, str, value = TRUE) }

filterassign <- function(data, filter, value) {
  data[filter(data)] <- value 
}

`%:<>%` <- function(lhs, rhs) {
  filterassign(lhs, rhs[[1]], rhs[[2]])
}

# p %:<>% list(is.infinite, NA)

#TODO: dplyr can do first, last, filter

#TODO: map and reduce for infinite lists
