context("append")

describe("%<%", {
  test_that("It appends", {
    expect_equal(list() %<% 1, list(1))
    expect_equal(list() %<% 1 %<% 2, list(1, 2))
    expect_equal(list(1, 2) %<% "A", list(1, 2, "A"))
  })
})

describe("%<<%", {
  test_that("It appends in-place", {
    l <- list()
    l %<<% 1
    expect_equal(l, list(1))
    l %<<% 2
    expect_equal(l, list(1, 2))
    l %<<% "A"
    expect_equal(l, list(1, 2, "A"))
  })
})
