# Worked examples published in Schultz et al. (Thorax 2008) and the BTS
# nodule guideline (2015).
test_that("published worked examples are reproduced", {
  expect_equal(round(100 * mayo(54, "yes", "no", 16, "no", "yes")$probability), 25)
  expect_equal(round(100 * mayo(68, "yes", "no", 22, "yes", "yes")$probability), 78)
  expect_equal(round(100 * mayo(70, "yes", "no", 4, "no", "yes")$probability, 1), 11.9)
})

test_that("all-zero predictors return the intercept", {
  x <- stats::qlogis(mayo(0 + 18, "no", "no", 0.1, "no", "no")$probability)
  expect_equal(x, -6.8272 + 0.0391 * 18 + 0.1274 * 0.1, tolerance = 1e-12)
})

test_that("bad input fails clearly", {
  expect_error(mayo(54, "maybe", "no", 16, "no", "yes"), "smoker")
  expect_error(model_run(list(age = 54)), "Missing")
})
