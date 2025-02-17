# spatialLIBD 1.7.12

SIGNIFICANT USER-VISIBLE CHANGES

* The visualization functions `vis_*()` of `SpatialLIBD` in this version
match the Bioconductor 3.15 version of `SpatialExperiment`.
Note that if you used `SpatialExperiment::read10xVisium()`, the names of
the spatial coordinates changed at 
https://github.com/drighelli/SpatialExperiment/commit/6710fe8b0a7919191ecce989bb6831647385ef5f
and thus you might need to switch them back if you created your
`SpatialExperiment` object before this change. You can do so with
`spatialCoordsNames(spe) <- rev(spatialCoordsNames(spe))`.
`read10xVisiumWrapper()` uses `SpatialExperiment::read10xVisium()` internally,
so this change on `SpatialExperiment` would then also affect you.

# spatialLIBD 1.7.11

NEW FEATURES

* Now `layer_stat_cor()` has the `top_n` argument which can be used for
subsetting the marker genes prior to computing the correlation as part of the
spatial registration process.

# spatialLIBD 1.7.10

NEW FEATURES

* Added the `add_key()` function to reduce code duplication and resolve
https://github.com/LieberInstitute/spatialLIBD/issues/31.

# spatialLIBD 1.7.9

NEW FEATURES

* This version is now compatible with the bioc-devel version of
SpatialExperiment where spatialData() was deprecated. Details at
https://github.com/LieberInstitute/spatialLIBD/pull/29/files.

# spatialLIBD 1.7.7

BUG FIXES

* Fixed a bug where the using the left-mouse click was not working for
annotating individual spots under the "gene (interactive)" tab.

# spatialLIBD 1.7.6

NEW FEATURES

* `vis_gene_p()`, `vis_clus_p()` and all related functions now have an argument
`point_size` which lets you control how big the points are plotted. This can
be useful for visualization purposes.
* The shiny app now has an input controlling the point size. If you increase it
to say `5`, then if you zoom in the `clusters (interactive)` panel, you can
see larger spots when zooming in.
* These features are related to
https://github.com/LieberInstitute/spatialLIBD/issues/28 although the spot
diameter is still not the true spot diameter. However, now you have more
flexibility for visualizing the spots.

# spatialLIBD 1.7.5

NEW FEATURES

* Expanded the _Using spatialLIBD with 10x Genomics public datasets_ vignette
to show how you can deploy your web application. See
https://libd.shinyapps.io/spatialLIBD_Human_Lymph_Node_10x/ for the live
example.

# spatialLIBD 1.7.4

BUG FIXES

* `vis_gene()` and `vis_grid_gene()` now support `geneid`s that are found in
the `rownames(spe)`. This makese these functions more flexible.
* `vis_grid_gene()` and `vis_grid_clus()` now have the `sample_order` argument
which gives you more control in case you want to plot a subset of samples. This
should also reduced the memory required as discovered at
https://github.com/LieberInstitute/spatialDLPFC/issues/45.

# spatialLIBD 1.7.3

NEW FEATURES

* Added support for more than one background picture per sample. This was done
through the new argument `image_id`. Resolves
https://github.com/LieberInstitute/spatialLIBD/issues/25.
* Added options for side by side visualization of the background image and the
clusters or gene expression values in the static versions. Resolves
https://github.com/LieberInstitute/spatialLIBD/issues/19.
* Allow changing the transparency level of the spots with the `alpha` argument.
Resolves https://github.com/LieberInstitute/spatialLIBD/issues/20.
* Add support for image manipulation with the `magick` package. Adds functions
`img_edit()`, `img_update()` and `img_update_all()` as well as new features
on the web application. Resolves
https://github.com/LieberInstitute/spatialLIBD/issues/21.
* Added support for more control over the gene color scale and in the web
application also added support for reversing the order of the scale.
Resolves https://github.com/LieberInstitute/spatialLIBD/issues/22 and
https://github.com/LieberInstitute/spatialLIBD/issues/23.
* Added `export_cluster()` and `import_cluster()` to help export/import
clustering results instead of having to save large `spe` objects when
exploring different clustering methods.
* Added `locate_images()` and `add_images()` for adding non-standard images
to a `spe` object.

# spatialLIBD 1.7.2

BUG FIXES

* Fixed an issue introduced by newer versions of `shiny`. This version of
`spatialLIBD` works with `shiny` version 1.7.1, though it's likely backwards
compatible. Resolves https://github.com/LieberInstitute/spatialLIBD/issues/24.
* Fix an issue where `as.data.frame(colData(spe))` uses `check.names = TRUE` by
default and then changes the column names unintentionally.

# spatialLIBD 1.7.1

NEW FEATURES

* Added `read10xVisiumWrapper()` and related functions that make it easier
to read in the SpaceRanger output files and launch a shiny web application
using `run_app()`. These new functions read in the analysis output from
SpaceRanger by 10x Genomics, in particular, the clustering and dimension
reduction (projection) results.

# spatialLIBD 1.3.19

SIGNIFICANT USER-VISIBLE CHANGES

* `spatialLIBD` has been updated to work with `SpatialExperiment` version
1.1.701 which will be released as part of Bioconductor 3.13. This changes
internal code of `spatialLIBD` which will work with any objects created with
`SpatialExperiment` version 1.1.700.

# spatialLIBD 1.3.16

SIGNIFICANT USER-VISIBLE CHANGES

* The citation information has changed now that `spatialLIBD` has a bioRxiv
pre-print at https://www.biorxiv.org/content/10.1101/2021.04.29.440149v1.

# spatialLIBD 1.3.15

SIGNIFICANT USER-VISIBLE CHANGES

* We now use `plotly::toWebGL()` to make the web application more responsive.

# spatialLIBD 1.3.14

SIGNIFICANT USER-VISIBLE CHANGES

* The documentation and help messages shown in the web application have been
revamped and improved.

# spatialLIBD 1.3.12

NEW FEATURES

* We added a new vignette that shows how you can use `spatialLIBD` with any
10x Genomics Visium dataset processed with `spaceranger`. The vignette uses
the publicly available human lymph node example from the 10x Genomics website.

# spatialLIBD 1.3.3

NEW FEATURES

* Overall the package has been updated to use `SpatialExperiment` version
1.1.427 available on Bioconductor 3.13 (bioc-devel). Several functions
were re-named such as `sce_image_gene_p()` now has a shorter name
`vis_gene_p()`. This update also changes these visualization functions to ONLY
support `SpatialExperiment` objects instead of the original modified
`SingleCellExperiment` objects.
* Updated citation information to reflect that
https://doi.org/10.1038/s41593-020-00787-0 is now public. Also added a link on
the README to https://doi.org/10.6084/m9.figshare.13623902.v1 for the
manuscript high resolution images.

# spatialLIBD 1.1.7

NEW FEATURES

* The functions `sce_image_gene_p()`, `sce_image_gene()`, `sce_image_grid()`, 
`sce_image_grid_gene()`, `sce_image_clus()`, `sce_image_clus_p()`, 
`geom_spatial()` now work with VisiumExperiment objects thanks to the new 
function `read_image()` and `ve_image_colData()`. This work was done by Brenda Pardo and Leonardo. 


# spatialLIBD 1.1.5

NEW FEATURES

* `fetch_data()` takes the data from sce object and creates a VisiumExperiment
object containing these data thanks to the function `sce_to_ve()`. VisiumExperiment object can be obtained with 
`fetch_data("ve")`. This work was done by Brenda Pardo and Leonardo. 


# spatialLIBD 1.1.4

NEW FEATURES

* `fetch_data()` now uses `BiocFileCache()` when downloading the data from
Dropbox.

# spatialLIBD 0.99.14

SIGNIFICANT USER-VISIBLE CHANGES

* Added the function `enough_ram()` which is used to control the execution of
examples. If it fails when using `fetch_data("sce")` then `fetch_data()` will
show a warning.
* `fetch_data(type = "sce_example")` is now supported and used visibly in the
vignette, eliminating the need for `eval = FALSE` chunks. This should enable
testing the vignette code on the Bioconductor Single Package Builder on
Windows (max 2.5 GB of RAM available).

BUG FIXES

* Fixed the example in `get_colors()`.
* Fixed `layer_stat_cor_plot()` for when `min` and/or `max` are specified.

# spatialLIBD 0.99.13

SIGNIFICANT USER-VISIBLE CHANGES

* Documentation website is now available at
http://LieberInstitute.github.io/spatialLIBD/. It gets updated with every
commit on the master branch (bioc-devel) using GitHub Actions and pkgdown.


# spatialLIBD 0.99.12

BUG FIXES

* Remove the spatialLIBD.Rproj file =( since BioC's SBP is asking me to do so
http://bioconductor.org/spb_reports/spatialLIBD_buildreport_20200303135350.html
* Use `system2()` instead of `system()`.
* Move the `set.seed()` call outside of `layer_boxplot()` as noted by
Martin Morgan
https://github.com/Bioconductor/Contributions/issues/1389#issuecomment-594099852
.
* Use `\linkS4class` as I see being done at
https://github.com/drisso/SingleCellExperiment/search?q=linkS4class&unscoped_q=linkS4class.
* Use `vapply()` instead of `sapply()`.
* Fix (or attempt to) some doc links.



# spatialLIBD 0.99.11

BUG FIXES

* Check if removing the `RcppAnnoy` line in the DESCRIPTION actually works now
based on Aaron Lun's comment at
https://github.com/eddelbuettel/rcppannoy/issues/57#issuecomment-594097241.


# spatialLIBD 0.99.10

SIGNIFICANT USER-VISIBLE CHANGES

* Include AWS links to the image TIFF files (~500mb each) as requested by
Qian Zhu <zqian@jimmy.harvard.edu> for visualizing the data on the Giotto
Viewer https://www.biorxiv.org/content/10.1101/701680v1.

BUG FIXES

* Fix `fetch_data()` and the vignette by specifying the `mode = "wb"` for
`utils::download.file()` in order to resolve an issue with Windows OS reported
here http://bioconductor.org/spb_reports/spatialLIBD_buildreport_20200302120158.html#tokay2_buildsrc_anchor.


# spatialLIBD 0.99.9

SIGNIFICANT USER-VISIBLE CHANGES

* Link to https://doi.org/10.1101/2020.02.28.969931 now that its
public.


# spatialLIBD 0.99.8

SIGNIFICANT USER-VISIBLE CHANGES

* https://spatial.libd.org/spatialLIBD is not supported since we
are using Shiny Server and not Shiny Server Pro. So all links have
now been updated to http://spatial.libd.org/spatialLIBD.


# spatialLIBD 0.99.7

BUG FIXES

* Run a test that might help with https://github.com/r-lib/pkgdown/issues/1230.


# spatialLIBD 0.99.6

SIGNIFICANT USER-VISIBLE CHANGES

* Add mirrors for the shiny app and change the main location.


# spatialLIBD 0.99.5

SIGNIFICANT USER-VISIBLE CHANGES

* Make `fetch_data()` more flexible. Should now work when the data is absent.


# spatialLIBD 0.99.4

BUG FIXES

* Fix Travis badges
* Fix Kristen's name on the vignette
* Add the same welcome information to the top of the vignette, since this will
be what Bioconductor users see first. Basically, we have made sure that users
will see the same information first regardless if they find the package README,
open the shiny app, or find the package vignette.


# spatialLIBD 0.99.3

SIGNIFICANT USER-VISIBLE CHANGES

* Further refine the READMEs (pkg and shiny). They now include the list of
links to the raw 10x Genomics files as well as a short description of the
project at the top. This was in response to feedback by Andrew Jaffe.


# spatialLIBD 0.99.2

SIGNIFICANT USER-VISIBLE CHANGES

* Update main package READMEs to reflect the changes to the shiny web app
README.md.


# spatialLIBD 0.99.1

NEW FEATURES

* Added Kristen R Maynard to the DESCRIPTION file.
* Improved the shiny app page footer.
* Moved around the documentation and added a new main tab with an overview in
response to the feedback by Stephanie Hicks.


# spatialLIBD 0.99.0

NEW FEATURES

* Added a `NEWS.md` file to track changes to the package.
* First full version of the package to be submitted to Bioconductor. Note that
the `ExperimentHub::ExperimentHub()` functionality won't work until they
approve the package. However, for now `fetch_data()` has a backup mechanism
in place.
* Submitted to Bioconductor
[here](https://github.com/Bioconductor/Contributions/issues/1389).
