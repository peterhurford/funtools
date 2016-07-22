context("chunk")

describe("chunk", {
  test_that("it chunks evenly", {
    expect_equal(chunk(seq(9), 3), list(c(1, 2, 3), c(4, 5, 6), c(7, 8, 9)))
  })
  test_that("leftovers are chunked into a final list", {
    expect_equal(chunk(seq(10), 3), list(c(1, 2, 3), c(4, 5, 6), c(7, 8, 9), 10))
  })
})

describe("partition", {
  test_that("it partitions according to a function", {
    expect_equal(partition(seq(10), is_even), list(c(2, 4, 6, 8, 10), c(1, 3, 5, 7, 9)))
  })
})
