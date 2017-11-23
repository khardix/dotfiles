#!/usr/bin/env perl

# Configuration file for latexmk, automation script for LaTeX builds

# Use xelatex by default
$pdf_mode = 1; $postscript_mode = $dvi_mode = 0;
$pdflatex = "xelatex --shell-escape -src-specials -synctex=1 -interaction=nonstopmode %O %S";

# Ignore generated timestamp files
$hash_calc_ignore_pattern{'timestamp'} = '^';
