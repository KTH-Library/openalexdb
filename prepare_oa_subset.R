library(aws.s3)
library(dplyr)
library(purrr)
library(aws.s3)
library(stringr)
library(readr)

s3_key <-
  system("mc alias list netapp", intern = TRUE) %>%
  grep("AccessKey", ., value = TRUE) %>%
  gsub("\\s+AccessKey\\s+:\\s+", "", .)

s3_secret <-
  system("mc alias list netapp", intern = TRUE) %>%
  grep("SecretKey", ., value = TRUE) %>%
  gsub("\\s+SecretKey\\s+:\\s+", "", .)

cfg <- function() {
  c(
    "AWS_S3_ENDPOINT" = "cloud.kth.se",
    "AWS_DEFAULT_REGION" = "s3",
    "AWS_ACCESS_KEY_ID" = s3_key,
    "AWS_SECRET_ACCESS_KEY" = s3_secret
  )
}

bls <- function(bucket, con = cfg()) {
  aws.s3::get_bucket_df(
    bucket = bucket,
    use_https = TRUE,
    base_url = con["AWS_S3_ENDPOINT"],
    key = con["AWS_ACCESS_KEY_ID"],
    secret = con["AWS_SECRET_ACCESS_KEY"],
    region = con["AWS_DEFAULT_REGION"]
  )
}

# just get the first hundred rows from each CSV
s3_csv_heads <- function(csv_files, n_row = 100) {

  head_cmd <- function(x)
    sprintf("mc head -n %s netapp/openalex-csv/%s", n_row, x)

  parse_cli_csv <- function(x)
    readr::read_csv(paste0(system(x, timeout = 10, intern = TRUE), "\n"),
      show_col_types = FALSE)

  csv_files %>%
    map_chr(head_cmd) %>%
    map(parse_cli_csv)

}

fz <- bls("openalex-csv")$Key

csvz <-
  fz %>%
  s3_csv_heads()

# save csv data as gz files in the directory "csv-files"

mypath <- "~/repos/openalexdb"
csvdir <- file.path(mypath, "csv-files")
if (!dir.exists(csvdir)) dir.create(csvdir)

save_csv_gz <- function(x, fn) {
  f <- file.path(csvdir, paste0(fn, ".gz"))
  message("Writing ", f)
  readr::write_csv(x, file = f)
}

map2(csvz, fz, save_csv_gz)

# output only lines in the orig load script that references these files

read_lines(file.path(mypath, "copy-openalex-csv.sql")) %>%
  .[stringr::str_detect(., fz)] %>%
  write_lines(., file = file.path(mypath, "load.sql"))

# also move all data to a sqlite db

library(RSQLite)

con <- RSQLite::dbConnect(RSQLite::SQLite(), file.path(mypath, "oa.db"))

cp <- function(nm, x)
  dbWriteTable(con, nm, x)

walk2(gsub("\\.csv$", "", fz), csvz, cp)

dbDisconnect(con)

# the oa.db can now be uploaded to postgres using pgloader (see Makefile)
