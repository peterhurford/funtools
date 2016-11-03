context("functionals")

describe("map", {
  test_that("map maps", {
    expect_equal(seq(10) %/>% inc, as.list(seq(2, 11)))
  })

  test_that("map can feed in additional parameters", {
    add <- function(x, y) { x + y }
    expect_equal(seq(10) %/>% list(add, x = 2), as.list(seq(3, 12)))
  })
})

test_that("vmap maps without turning into a list", {
  expect_equal(seq(10) %v>% inc, seq(2, 11))
})

test_that("nmap maps over names", {
  l <- list(a = 1, b = 2, c = 3)
  expect_equal(nmap(l, toupper), list(A = 1, B = 2, C = 3))
})

describe("innermap", {
  test_that("innermap maps on the inner-list", {
    l <- list(seq(3), seq(10, 13), seq(100, 103))
    inc_l <- list(as.list(seq(2, 4)), as.list(seq(11, 14)), as.list(seq(101, 104)))
    expect_equal(l %//>% inc, inc_l)
  })

  test_that("innermap can feed in additional parameters", {
    add <- function(x, y) { x + y }
    l <- list(seq(3), seq(10, 13), seq(100, 103))
    inc_l <- list(as.list(seq(3, 5)), as.list(seq(12, 15)), as.list(seq(102, 105)))
    expect_equal(l %//>% list(add, x = 2), inc_l)
  })
})

describe("innerinnermap", {
    l <- list(list(seq(3), seq(10, 13), seq(100, 103)),
         list(seq(1000, 1003), seq(10000, 10003), seq(100000, 100003)))
  inc_l <- list(list(as.list(seq(2, 4)),
             as.list(seq(11, 14)),
             as.list(seq(101, 104))),
           list(as.list(seq(1001, 1004)),
             as.list(seq(10001, 10004)),
             as.list(seq(100001, 100004))))
  expect_equal(l %///>% inc, inc_l)
})

test_that("flatmap maps then flattens", {
  l <- list(seq(3), seq(10, 13), seq(100, 103))
  inc_l <- as.list(c(seq(2, 4), seq(11, 14), seq(101, 104)))
  expect_equal(l %f/>% inc, inc_l)
})

describe("reduce", {
  test_that("reduce reduces", {
    expect_equal(seq(10) %_>% `+`, 55)
  })

  test_that("reduce can pass in an initial value", {
    expect_equal(list(fn(x, x + 2), fn(x, x * 2)) %_>% list(fn(x, f, f(x)), 3), 10)
  })
})

test_that("filter filters", {
  expect_equal(seq(10) %:>% is_even, c(2, 4, 6, 8, 10))
})

test_that("nfilter filters by name", {
  l <- list(a = 1, A = 2, b = 3, B = 4)
  expect_equal(nfilter(l, is_upper), list(A = 2, B = 4))
})

test_that("filtermap will filter and then map", {
  # Increment all even numbers
  expect_equal(seq(10) %:/>% list(is_even, inc), list(1, 3, 3, 5, 5, 7, 7, 9, 9, 11))
})

test_that("reducemap will reduce the inner lists", {
  l <- list(seq(3), seq(10, 13), seq(100, 103))
  expect_equal(l %_/>% fn(x, y, x + y), list(6, 46, 406))
})

test_that("find finds", {
  expect_equal(find(seq(101, 110), is_even), 102)
})

test_that("position returns the position of a find", {
  expect_equal(position(seq(101, 110), is_even), 2)
})
