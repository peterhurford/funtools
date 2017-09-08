context("spelling")
test_that("Package is spelled correctly", {
  spellcheck <- spelling::spell_check_package("../..")
  expect_equal(nrow(spellcheck), 0, info = paste("Misspelled words:", paste0(spellcheck$word, collapse = ", ")))
})
