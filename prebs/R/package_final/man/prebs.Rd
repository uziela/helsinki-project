\docType{package}
\name{prebs}
\alias{prebs}
\alias{prebs-package}
\title{PREBS package}
\description{
  The prebs package aims at making RNA-sequencing (RNA-seq)
  data more comparable to microarray data. The
  comparability is achieved by summarizing sequencing-based
  expressions of probe regions using a modified version of
  RMA algorithm. The pipeline takes mapped reads in BAM
  format as an input and produces either gene expressions
  or original microarray probe set expressions as an
  output.
}
\details{
  The package has only one public function:
  \code{calc_prebs}. Type help(calc_prebs) for more
  information on the usage.
}

