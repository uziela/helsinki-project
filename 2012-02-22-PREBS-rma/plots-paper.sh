#!/bin/sh

plots_dir="plots-dir"
marioni_dir="plot-data/Marioni-basic-0-60-paper/plot-data"
laml_dir="plot-data/LAML-basic-0-60-paper/plot-data"
stock_dir="plot-data/Marioni-stock-paper/plot-data"
retrieval_dir="plot-data/retrieval"

mkdir -p $plots_dir

./scripts/figure1.R $marioni_dir $laml_dir $stock_dir $plots_dir/1-abs-scatter.pdf $plots_dir/3-diff-scatter.pdf $plots_dir/5-venn.pdf $plots_dir/7-stock-scatter.pdf
./scripts/figure2.R $marioni_dir $laml_dir $plots_dir/2-abs-graph.pdf $plots_dir/4-diff-graph.pdf $plots_dir/6-cross-diff-graph.pdf
./scripts/retrieval_plot.R $retrieval_dir/retrieval.csv $plots_dir/8-retrieval.pdf
