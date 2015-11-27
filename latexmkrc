#!/usr/bin/env perl

# Configuration file for latexmk, automation script for LaTeX builds

# Use xelatex by default
$pdflatex = "xelatex %O %S";
$pdf_mode = 1; $postscript_mode = $dvi_mode = 0;
