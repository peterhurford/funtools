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


#### Currying

You can create a partially evaluated function using `curry`:

```R
subtract <- function(a, b) a - b
subtract3 <- curry(subtract, 3)
subtract3(6)
# 3
```

`curry(subtract, 3)` is equivalent to `function(x) subtract(x, 3)`.

You can pass named arguments to `curry` to replace arbitrary parts of the function.

`curry(subtract, a = 3)` will make `function(x) subtract(3, x)`.


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

**Euler 1**

```R
library(magrittr)
library(funtools)
1000 %>% dec %>% seq %/>% curry(div, y = c(3, 5)) %_/>% or %\>% which %_>% `+`
```

**Euler 2**

```R
library(inflist)
fib <- infseq({result <- 0; b <- 1; function() { c(result, b) %<-% c(b, result + b) }})
fib %>% take_while(curry(`<=`, e2 = 4000000)) %:>% is_even %_>% `+`
```

**Euler 3**

```R
roots <- . %>% sqrt %>% floor %>% seq(2, .)
isPrime <- function(n) { n %>% dec %>% roots %:>% curry(div, x = n) %>% null }
largest_prime_factor <- function(n) { roots(n-1) %:>% (curry(div, x = n) %&.% isPrime) %\>% max }
largest_prime_factor(600851475143)

**Euler 4**

```R
is_palindrome <- . %>% as.character %>% lsplit %>% { rev(.) == . } %>% all
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
