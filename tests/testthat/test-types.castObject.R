library(stringr)
library(tableschema.r)
library(testthat)
library(config)
library(foreach)

context("types.castObject")

# Constants

TESTS <- list(
  list('default', list(), list()),
  list('default', '{}', helpers.from.json.to.list('{}')),
  list('default', '{"key": "value"}', list('key' = 'value')),
  list('default', '["key", "value"]', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('default', 'string', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('default', 1, config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('default', '3.14', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('default', '', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('default', matrix(1:4, nrow = 2), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('default', NULL, config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list('default', '[["id", "name"],["1", "ab"]]', config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")))
)

# Tests

foreach(j = seq_along(TESTS) ) %do% {
  
  TESTS[[j]] <- setNames(TESTS[[j]], c("format", "value", "result"))
  
  test_that(str_interp('format "${TESTS[[j]]$format}" should check "${TESTS[[j]]$value}" as "${TESTS[[j]]$result}"'), {
    
    expect_equal(types.castObject(TESTS[[j]]$format, TESTS[[j]]$value), TESTS[[j]]$result)
  })
}
