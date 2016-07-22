context("joiners")

test_that("flatten flattens", {
   expect_equal(flatten(list(list(list(2)))), list(2))
   expect_equal(flatten(list(list(2, 3), list(4, 5))), list(2, 3, 4, 5))
})

test_that("compact compacts", {
  expect_equal(compact(list(1, 2, NA, 3)), list(1, 2, 3))
  expect_equal(compact(list(1, 2, NA, 3, NA)), list(1, 2, 3))
  expect_equal(compact(list(1, 2, NULL, 3, NA)), list(1, 2, 3))
  expect_equal(compact(list(NULL)), list())
})

test_that("join joins", {
  expect_equal(join(list("a", "b", "c"), join = " "), "a b c")
})
