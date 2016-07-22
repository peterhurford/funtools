test_that("is_even", {
  expect_true(is_even(2))
  expect_false(is_even(3))
  expect_false(is_even(2.3))
})

test_that("is_odd", {
  expect_true(is_odd(3))
  expect_false(is_odd(4))
  expect_false(is_odd(2.3))
})

test_that("is_upper", {
  expect_true(is_upper("A"))
  expect_false(is_upper("a"))
})

test_that("is_lower", {
  expect_false(is_lower("A"))
  expect_true(is_lower("a"))
})

test_that("is_true", {
  expect_true(is_true(TRUE))
  expect_false(is_true(FALSE))
})

test_that("is_false", {
  expect_true(is_false(FALSE))
  expect_false(is_false(TRUE))
})

test_that("%===%", {
  expect_true(1 %===% 1)
  expect_false(1 %===% 2)
})

test_that("symdiff", {
  xs <- c(2, 4, 5)
  ys <- c(3, 4, 6)
  expect_equal(symdiff(xs, ys), c(2, 5, 3, 6))
})

test_that("named", {
  expect_true(named(list(a = 1, b = 2)))
  expect_true(named(list(a = 1, 2, 3)))
  expect_false(named(list(1, 2, 3)))
})

test_that("unnamed", {
  expect_false(unnamed(list(a = 1, b = 2)))
  expect_false(unnamed(list(a = 1, 2, 3)))
  expect_true(unnamed(list(1, 2, 3)))
})

test_that("dec", { expect_equal(dec(1), 0) })
test_that("inc", { expect_equal(inc(1), 2) })

test_that("div", {
  expect_true(div(4, 2))
  expect_false(div(5, 2))
})

test_that("grepv", {
  expect_equal(grepv(c("hello", "hi", "how", "are", "you"), "h"), c("hello", "hi", "how"))
})
