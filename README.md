
<!-- README.md is generated from README.Rmd. Please edit that file -->

# accdbfetch

<!-- badges: start -->
<!-- badges: end -->

The goal of accdbfetch is to connect to a proprietary Microsoft Access
application created by Robert Cline, Sr. to manage land records.
Connection to the MS Access application is made by using a file path to
the application which is supplied by the user to extract and tidy tables
from the Access db.

## Installation

You can install the development version of `accdbfetch` from
[GitHub](%22https://github.com/rccline/accdbfetch%22)

``` r
devtools::install_github("https://github.com/rccline/accdbfetch")
```

## Example

After installing the accdbfetch application, load the accdbfetch
library, then run the command *accdb\_fetch(“your file path”)* to load
and tidy useful tables from the access application into the R
environment. The data from the extracted tables can be used to create
Ownership Reports and Lease Packages.

``` r
library(accdbfetch)
## basic example code 

accdb_fetch("The path to MS_Access.accdb")
```

This README.md was created with README.Rmd. What is special about using
`README.Rmd` instead of just `README.md`? You can include R chunks like
so:

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

This package is maintained by Robert Cline Sr. *<rccline@fastmail.fm>*
