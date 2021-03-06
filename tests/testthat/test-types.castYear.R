library(stringr)
library(tableschema.r)
library(testthat)
library(foreach)
library(config)

context("types.castYear")

# Constants

TESTS <- list(
  
  list("default", 2000, 2000),
  list("default", "2000", 2000),
  list("default", -2000, config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default", 20000, config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default", "20000000", config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default", "3.14", config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default", "2000a", config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default", "200a", config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default",  matrix(c("1","2"),nrow = 1), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default", "", config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r"))),
  list("default", list(2000), config::get("ERROR", file = system.file("config/config.yml", package = "tableschema.r")))
  
)

# Tests

foreach(j = seq_along(TESTS) ) %do% {
  
  TESTS[[j]] <- setNames(TESTS[[j]], c("format", "value", "result"))
  
  test_that(str_interp('format "${TESTS[[j]]$format}" should check "${TESTS[[j]]$value}" as "${TESTS[[j]]$result}"'), {
    
    expect_equal(types.castYear(TESTS[[j]]$format, TESTS[[j]]$value), TESTS[[j]]$result)
  })
}
