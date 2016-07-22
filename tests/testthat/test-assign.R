context("assign")

describe("%+=%", {
  test_that("it adds in place", {
    x <- 5
    x %+=% 1
    expect_equal(x, 6)
    y <- 2
    x %+=% y
    expect_equal(x, 8)
    y %+=% x
    expect_equal(y, 10)
  })
})

describe("%-=%", {
  test_that("it subtracts in place", {
    x <- 5
    x %-=% 1
    expect_equal(x, 4)
    y <- 2
    x %-=% y
    expect_equal(x, 2)
    y %-=% x
    expect_equal(y, 0)
  })
})

describe("%/=%", {
  test_that("it divides in place", {
    x <- 5
    x %/=% 2
    expect_equal(x, 2.5)
    y <- 2
    x %/=% y
    expect_equal(x, 1.25)
    y %/=% x
    expect_equal(y, 1.6)
  })
})

describe("%*=%", {
  test_that("it multiplies in place", {
    x <- 5
    x %*=% 2
    expect_equal(x, 10)
    y <- 2
    x %*=% y
    expect_equal(x, 20)
    y %*=% x
    expect_equal(y, 40)
  })
})

describe("%a-%", {
  test_that("it assigns", {
    x %a-% 1
    expect_equal(x, 1)
    x %a-% 2
    expect_equal(x, 2)
  })
  test_that("it multi-assigns", {
    c(a, b, c) %a-% c(1, 2, 3)
    expect_equal(a, 1)
    expect_equal(b, 2)
    expect_equal(c, 3)
    c(iris2, iris3) %a-% list(iris, iris)
    expect_equal(iris2, iris)
    expect_equal(iris3, iris)
  })
  test_that("it swaps", {
    c(a, b) %a-% c(1, 2)
    expect_equal(a, 1)
    expect_equal(b, 2)
    c(a, b) %a-% c(b, a)
    expect_equal(a, 2)
    expect_equal(b, 1)
  })
})
