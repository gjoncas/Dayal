# Dayal - An Introduction to R for Quantitative Economics
Dayal's <a href="https://link.springer.com/book/10.1007/978-81-322-2340-5">book</a> is a beautiful little primer on R, based on the <a href="https://cran.r-project.org/web/packages/mosaic/index.html">Mosaic</a> package.
<br>However, some of the code doesn't work, and several datasets are unavailable.

Here I'll try to fix up the code, and post corrections that work for R version 3.5.0.
<br>Currently, ch. 5-6 and 11-12 still have problems.

Obviously, all copyright goes to Dayal, Springer, and the makers of each dataset.

## Problems in the code
<b>Ch. 4 – Fixed</b>
<br>Oil price data unavailable (get via Quandl + a few tweaks)

<b>Ch. 5</b>
<br>Can't compute derivatives (try <a href="https://cran.r-project.org/web/packages/mosaicCalc/index.html">mosaicCalc</a>)
<br>World Bank dataset isn't available

<b>Ch. 6</b>
<br>Can't layer charts on top of one another (cf. Ch. 12)

<b>Ch. 11</b>
<br>Favstats mixes treatment & control group together

<b>Ch. 12</b>
<br>Can't plot multiple graphs together (cf. Ch. 6)
<br>Datasets don't work (World Bank, Maddison Project)

## Datasets
<ul>
<li>International Forestry Resources and Institutions (<a href="http://www.ifriresearch.net/resources/data/">IFRI</a>): ‘Carbon storage and livelihoods’ (<a href="http://www.ifriresearch.net/wp-content/uploads/2012/06/carbon_livelihoods_dataset1.zip">.zip</a>)</li>
<li>Kathryn Graddy (<a href="http://people.brandeis.edu/~kgraddy/data.html">Brandeis University</a>): ‘Detailed Fulton Fish Market Data’ (<a href="http://people.brandeis.edu/~kgraddy/datasets/fishmayreq.txt">.txt</a>) (<a href="http://people.brandeis.edu/~kgraddy/datasets/dictionary.doc">dictionary</a>)
<li>Maddison Project (2015): ‘Maddison Historical Statistics’ (<a href="http://www.rug.nl/ggdc/historicaldevelopment/maddison">superseded</a>)</li>
<li>World Bank (2014): World Development Indicators (<a href="http://databank.worldbank.org/data/home.aspx">superseded</a>)</li>
<li>Datasets built into R: AirPassengers, anscombe, lalonde</li>
<li>Datasets in the AER package: NYSESW, USMacroSW</li>
</ul>
