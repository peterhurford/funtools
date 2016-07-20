## Funtools

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

There's also `vmap` (or `%\>%`) which turns the list result into a vector before applying the function and `nmap`, which applys the map on the names of the list.

`nfilter` will apply the `filter` on the names.

`flatten` will turn a nested list into a depth-1 list and `flatmap` (or `%f/>%`) will flatten the result of the `map`.

`filtermap` (or `%:/>%`) will `filter` the list with the result of the `map` on the list.

`reducemap` (or `%_/>%`) will `map` a `reduce` function, which is good for reducing a list of lists.

`find` is the compliment to `Find`.

`null(xs)` returns `TRUE` if `xs` is empty. `null(xs, f)` returns `TRUE` if `find` fails to find with `f`.


#### Function composition

`%>%` from magrittr already can be used to compose functions (e.g., `fn <- . %>% f %>% g`).

`%&>%` (`fandcompose`) can be used to compose two functions using `&&` instead of function application.  `%|>%` (`forcompose`) composes two functions using `||`.

```R
23 %>% (is_even %&>% function(x) x > 20)
[1] FALSE
23 %>% (is_even %|>% function(x) x > 20)
[1] TRUE
```


#### Function Shorthands

You can create a shorthand for defining a function using `fn`:

```R
add <- function(x, y) { x + y }
add <- fn(x, y, x + y)
```


#### Zip

`zip` combines two lists into vector tuples. `lzip` will combine two lists into list-tuples, where classes can be different.

`zip_with` will let you combine two lists with an arbitrary function.


#### Merge

Funtools expands `merge` to work with lists.


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

`%<-%` supports assigning multiple values at once:

```R
c(a, b, c) %<-% seq(3)
a
[1] 1
b
[1] 2
c
[1] 3
```

It can also be used to swap values:

```R
c(a, b) %<-% c(b, a)
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

Funtools also contains custom matchers: `is_even`, `is_odd`, `is_upper`, and `is_lower`.

`%==%` is an infix operator for `identical`.

`isFALSE` compliments `isTRUE`.  `is_false` and `is_true` also work.



## Examples

**Euler #1**

```R
library(magrittr)
library(funtools)
1000 %>% dec %>% seq %/>% fn(x, div(x, c(3, 5))) %_/>% or %\>% which %_>% `+`
```

**Euler #2**

```R
library(inflist)
library(num)
fib <- infseq({result <- 0; b <- 1; function() { c(result, b) %<-% c(b, result + b) }})
fib %>% take_while(fn(x, x <= num("4M"))) %:>% is_even %_>% `+`
```

**Euler #3**

```R
roots <- . %>% sqrt %>% floor %>% seq(2, .)
isPrime <- function(n) { n %>% dec %>% roots %:>% fn(x, div(x, n)) %>% null }
largest_prime_factor <- function(n) { roots(n-1) %:>% (fn(x, div(x, n)) %&.% isPrime) %\>% max }
largest_prime_factor(600851475143)

**Euler #4**

```R
is_palindrome <- . %>% as.character %>% lsplit %>% fn(x, rev(x) == x) %>% all
self_map(seq(100, 999), `*`) %>% unique %:>% is_palindrome %>% max
```

**Reinventing `which`**

```R
library(funtools)
library(dplyr)
which_ <- function(bools) {
  bools %>% lzip(seq_along(.), .) %:/>% nth(2) %/>% first
}

> which(is_even(seq(10, 20)))
[1]  1  3  5  7  9 11
> which_(is_even(seq(10, 20)))
#TODO: FIX
Error in xs[vmap(xs, f)] : invalid subscript type 'list'
```

** Formatting a string to have line wrapping **
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
