test_that("gateway returns full-precision JSON and ignores platform fields", {
  js <- gateway(model_input = get_default_input(), execution_id = "z",
                callback_url = "https://example.invalid/cb")
  expect_equal(jsonlite::fromJSON(js)$probability,
               model_run(get_default_input())$probability, tolerance = 1e-12)
  expect_equal(round(jsonlite::fromJSON(gateway())$probability, 4), 0.2494)
})
