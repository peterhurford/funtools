test_that("zip zips into a vector", {
  expect_equal(zip(seq(3), seq(2, 4)), list(c(1, 2), c(2, 3), c(3, 4)))
})

test_that("lzip zips into a list", {
  expect_equal(lzip(seq(3), head(letters, 3)), list(list(1, "a"), list(2, "b"), list(3, "c")))
})

test_that("%+>%", {
  expect_equal(seq(2) %+>% c(10, 11), list(list(1, 10), list(2, 11)))
})

test_that("zip_with zips with a custom function", {
  expect_equal(zip_with(seq(4), seq(10, 13), fn(x, y, x + y)), list(11, 13, 15, 17))
})

test_that("%+/>%", {
  expect_equal(seq(4) %+/>% inc, list(list(1, 2), list(2, 3), list(3, 4), list(4, 5)))
})
