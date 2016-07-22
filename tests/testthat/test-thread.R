test_that("thread threads on the original list", {
  expect_equal(thread(seq(10), fn(x, y, x + y)), as.list(seq(10) * 2 - 1))
})

test_that("thread2 threads on the output list", {
  expect_equal(thread2(seq(10), fn(x, y, x + y)), as.list(cumsum(seq(10))))
})

test_that("thread_while builds a list of lists", {
  expect_equal(thread_while(seq(10), is_even),
               list(list(1), list(2, 3), list(4, 5), list(6, 7), list(8, 9), list(10)))
})
