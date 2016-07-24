## Funtools <a href="https://travis-ci.org/peterhurford/funtools"><img src="https://img.shields.io/travis/peterhurford/funtools.svg"></a> <a href="https://codecov.io/github/peterhurford/funtools"><img src="https://img.shields.io/codecov/c/github/peterhurford/funtools.svg"></a> <a href="https://github.com/peterhurford/funtools/tags"><img src="https://img.shields.io/github/tag/peterhurford/funtools.svg"></a>

**Make R functions more fun!**


#### Piping

Funtools continues to emphasize the left-to-right style of coding started in [magrittr](https://github.com/smbache/magrittr) and emphasized by [dplyr](https://github.com/hadley/dplyr), where:

* `x %>% f` is equivalent to `f(x)`.
* `x %>% f(y)` is equivalent to `f(x, y)`.
* `x %>% f %>% g %>% h` is equivalent to `h(g(f(x)))`.


#### filter, map, reduce

R already has `Filter`, `lapply`, and `Reduce`, but funtools provides `filter`, `map`, and `reduce` which are more magrittr-friendly and like functional programming from other languages.

For example...

```R
seq(10) %>% lapply(function(x) x + 1) %>% Reduce(., sum)
```

...is how it is done in R.

```R
seq(10) %>% map(function(x) x + 1) %>% reduce(sum)
```

...is the funtools way.

In fact, funtools is full of fun shorthands, like `inc` (for +1) and `dec` (for -1):

```R
seq(10) %>% map(inc) %>% reduce(sum)
```

We also support infix operators:

`%/>%` is `map`

`%:>%` is `filter`

`%_>%` is `reduce`

thus making the chain even shorter...

```R
seq(10) %/>% inc %_>% sum
```

There's also `vmap` (or `%v>%`) which turns the list result into a vector before applying the function and `nmap`, which applys the map on the names of the list.

`nfilter` will apply the `filter` on the names.

`flatten` will turn a nested list into a depth-1 list and `flatmap` (or `%f/>%`) will flatten the result of the `map`.

`filtermap` (or `%:/>%`) will `filter` the list with the result of the `map` on the list.

`reducemap` (or `%_/>%`) will `map` a `reduce` function, which is good for reducing a list of lists.

`find` is the compliment to `Find`.


#### Function/Lambda Shorthand

You can create a shorthand for defining a function using `fn`:

```R
add <- function(x, y) { x + y }
add <- fn(x, y, x + y)
```


#### Function composition

`%>%` from magrittr already can be used to compose functions (e.g., `fn <- . %>% f %>% g`).

`%&>%` (`fandcompose`) can be used to compose two functions using `&&` instead of function application.  `%|>%` (`forcompose`) composes two functions using `||`.

```R
23 %>% (is_even %&>% fn(x, x > 20))
[1] FALSE
23 %>% (is_even %|>% fn(x, x > 20))
[1] TRUE
```


#### Flatten, Compact, Join

`flatten` takes a list of arbitrary depth and flattens it into a list of depth-1.

`compact` removes NA and NULL values from a list.

`join` combines a list of strings into a single string.

```R
flatten(list(list(1, 2), list("a", "b")))
# Produces list(1, 2, "a", "b")

compact(list(1, 2, NA, 3, NULL, 4))
# Produces list(1, 2, 3, 4)

join(list("hello", "how", "are", "you"), join = " ")
# Produces "hello how are you"
```


#### Split

`lsplit` splits a string into a list with each letter. `wsplit` splits a string into a list with each word.

```R
lsplit("hello how are you")
# [1] "h" "e" "l" "l" "o" " " "h" "o" "w" " " "a" "r" "e" " " "y" "o" "u"
wsplit("hello how are you")
# [1] "hello" "how"   "are"   "you"
```


#### NA Composition

Another, separate notion of compose is the SQL definition for handling NULL values.

`a %or% b` will return `b` if `a` is `NULL`, `NA`, or length 0 and will return `a` otherwise.

```R
beta_value <- options$beta_value %|% 0  # Assign beta to 0 unless already defined in options.
````


#### Zip

`zip` combines two lists into vector tuples. `lzip` will combine two lists into list-tuples, where classes can be different.

`zip_with` will let you combine two lists with an arbitrary function.

`%+>%` is a shorthand for `lzip`.


#### Threading

Threading iterates over a list using both the current and the previous position in the list. `thread` uses the previous position in the input list whereas `thread2` uses the previous position in the *output* list.

`thread_while` continues to add to a list until the function passed returns FALSE, after which it starts aggregating a new list.

```R
thread2(seq(10), `+`)
# Produces the cumulative sums of the first 10 numbers
#  [1]  1  3  6 10 15 21 28 36 45 55
```


#### Merge

Funtools expands `merge` to work with lists.


#### Chunk and Partition

Separate an R list into groups of a certain size:

```R
chunk(seq(10), 3)
# [[1]]
# [1] 1 2 3

# [[2]]
# [1] 4 5 6

# [[3]]
# [1] 7 8 9

# [[4]]
# [1] 10
````

or partition a list into groups based on a particular function:

```R
partition(seq(10), is_even)
# [[1]]
# [1]  2  4  6  8 10

# [[2]]
# [1] 1 3 5 7 9
```


#### Assignment Operators

`%+=%` is equivalent to `+=` from other languages.

`%-=%`, `%/=%`, and `%*=%` also exist.


```R
a <- 1
a %+=% 1
a %*=% 2
a
[1] 4
```


#### Multiple assigning

`%a-%` supports assigning multiple values at once:

```R
c(a, b, c) %a-% seq(3)
a
[1] 1
b
[1] 2
c
[1] 3
```

It can also be used to swap values:

```R
c(a, b) %a-% c(b, a)
a
[1] 2
b
[1] 1
```


#### Appending

`%<%` is shorthand for append.

`%<<%` will assign the result to the variable.

Thus `l <- append(l, 2)` can now be `l <- l %<% 2` or `l %<<% 2`.


#### Random utilities

Funtools contains custom matchers: `is_even`, `is_odd`, `is_upper`, and `is_lower`.

`%===%` is an infix operator for `identical`.

`isFALSE` compliments `isTRUE`.  `is_false` and `is_true` also work.

`sort_keys` will sort a list based on the names of that list.

`symdiff` implements symmetric difference.

`named` returns `TRUE` for named lists. `unnamed` returns `TRUE` for unnamed lists.

`grepv` returns the values for the pattern within a string (instead of their positions).

`null(xs)` returns `TRUE` if `xs` is empty. `null(xs, f)` returns `TRUE` if `find` fails to find with `f`.


## Examples

**Euler #1**

```R
library(magrittr)
library(funtools)
1000 %>% dec %>% seq %/>% fn(x, div(x, c(3, 5))) %_/>% or %v>% which %_>% `+`
```

**Euler #2**

```R
library(inflist)
library(num)
fib <- infseq({result <- 0; b <- 1; function() { c(result, b) %a-% c(b, result + b) }})
fib %>% take_while(fn(x, x <= num("4M"))) %:>% is_even %_>% `+`
```

**Euler #3**

```R
roots <- . %>% sqrt %>% floor %>% seq(2, .)
#TOOD: Why can't `fn` be used here? https://github.com/peterhurford/funtools/issues/5
is_prime <- function(n) { n %>% dec %>% roots %>% find(function(x) { div(n, x) }) %>% is.null }
largest_prime_factor <- function(n) { n %>% dec %>% roots %>% sort(., decreasing = TRUE) %:>% (function(x) { div(n, x) }) %>% find(is_prime) }
largest_prime_factor(600851475143)
```

**Euler #4**

```R
is_palindrome <- . %>% as.character %>% lsplit %>% { rev(.) == . } %>% all
((seq(100, 999) %v>% fn(x, rep(x, 899))) * rep(seq(100, 999), 899)) %>% unique %:>% is_palindrome %
>% max
```

**Replace infinite values with NA**

```R
c(0, 1, 2, Inf, 3) %:/>% list(is.infinite, fn(x, NA))
# c(0, 1, 2, NA, 3)
````

**Reinventing `which`**

```R
which_ <- function(bools) {
  bools %+/>% seq_along %:>% fn(x, x[[1]]) %/>% fn(x, x[[2]]) %>% unlist
}

> which(is_even(seq(10, 20)))
[1]  1  3  5  7  9 11
> which_(is_even(seq(10, 20)))
[1]  1  3  5  7  9 11
```

**Formatting a string to have line wrapping**
```R
## Print out str so that each line is max 13 characters and no words are broken.
str <- "Four score and seven years ago our fathers brought forth upon this continent a new nation conceived in liberty and dedicated to the proposition that all men are created equal"

wsplit(str) %+/>% nchar %>%
  thread2(fn(x, y, { list(y[[1]], (y[[2]] + x[[2]]) %% 13) })) %>%
  thread(fn(x, y, { list(y[[1]], x[[2]] < y[[2]]) })) %>%
  thread_while(fn(x, isTRUE(x[[2]]))) %//>%
  fn(x, x[[1]]) %/>%
  fn(x, collapse(x, " ")) %>%
  join("\n") %>% cat
```
