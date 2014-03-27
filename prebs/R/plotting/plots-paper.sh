#!/bin/sh

plots_dir="plots-dir"
marioni_dir="plot-data/Marioni-basic-0-60-paper/plot-data"
laml_dir="plot-data/LAML-basic-0-60-paper/plot-data"
stock_dir="plot-data/Marioni-stock-paper/plot-data"
retrieval_dir="plot-data/retrieval"
correlation_scatter_dir="plot-data/correlation-scatter-plot"
ratios_dir="plot-data/ratios"

mkdir -p $plots_dir

#./scripts/figure1_eps.R $marioni_dir $laml_dir $stock_dir $plots_dir/3-abs-scatter.eps $plots_dir/s1-diff-scatter.eps $plots_dir/s2-venn.eps $plots_dir/6-stock-scatter.eps
#./scripts/figure2_eps.R $marioni_dir $laml_dir $plots_dir/1-abs-graph.eps $plots_dir/4-diff-graph.eps $plots_dir/5-cross-diff-graph.eps
#./scripts/retrieval_plot_eps.R $retrieval_dir/retrieval.csv $plots_dir/7-retrieval.eps

./scripts/figure1.R $marioni_dir $laml_dir $stock_dir $plots_dir/3-abs-scatter.pdf $plots_dir/6-diff-scatter.pdf $plots_dir/7-venn.pdf $plots_dir/9-stock-scatter.pdf
./scripts/figure2.R $marioni_dir $laml_dir $plots_dir/1-abs-graph.pdf $plots_dir/5-diff-graph.pdf $plots_dir/8-cross-diff-graph.pdf
./scripts/retrieval_plot.R $retrieval_dir/retrieval.csv $plots_dir/4-retrieval.pdf

./scripts/correlation_scatter_plot.R $correlation_scatter_dir/prebs_data_0-10.csv $correlation_scatter_dir/prebs_data_0-60.csv $correlation_scatter_dir/prebs_log2fc_data_0-10.csv $correlation_scatter_dir/prebs_log2fc_data_0-60.csv $plots_dir/2-correlation-scatter-plot.pdf

#./scripts/correlation_scatter_plot_eps.R $correlation_scatter_dir/prebs_data_0-10.csv $correlation_scatter_dir/prebs_data_0-60.csv $correlation_scatter_dir/prebs_log2fc_data_0-10.csv $correlation_scatter_dir/prebs_log2fc_data_0-60.csv $plots_dir/2-correlation-scatter-plot.eps

#./scripts/ratios_plot.R $ratios_dir/all_LAML_ratios.csv $plots_dir/10-ratios-plot.pdf
