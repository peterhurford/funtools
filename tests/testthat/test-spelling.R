context("spelling")
test_that("Package is spelled correctly", {
  root <- rprojroot::find_root("DESCRIPTION")
  spellcheck <- spelling::spell_check_package(root)
  expect_equal(nrow(spellcheck), 0,
               info = paste("Misspelled words:", paste0(spellcheck$word, collapse = ", ")))
})
