context("splitters")

test_that("lsplit splits on letters", {
  expect_equal(lsplit("abc"), c("a", "b", "c"))
})

test_that("wsplit splits on words", {
  expect_equal(wsplit("happy birthday"), c("happy", "birthday"))
})
