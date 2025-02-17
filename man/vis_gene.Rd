% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vis_gene.R
\name{vis_gene}
\alias{vis_gene}
\title{Sample spatial gene visualization}
\usage{
vis_gene(
  spe,
  sampleid,
  geneid = "SCGB2A2; ENSG00000110484",
  spatial = TRUE,
  assayname = "logcounts",
  minCount = 0,
  viridis = TRUE,
  image_id = "lowres",
  alpha = 1,
  cont_colors = if (viridis) viridisLite::viridis(21) else c("aquamarine4",
    "springgreen", "goldenrod", "red"),
  point_size = 1.25,
  ...
)
}
\arguments{
\item{spe}{Defaults to the output of
\code{fetch_data(type = 'spe')}. This is a
\link[SpatialExperiment:SpatialExperiment]{SpatialExperiment-class}
object with the spot-level Visium data and information required for
visualizing the histology. See \code{\link[=fetch_data]{fetch_data()}} for more details.}

\item{sampleid}{A \code{character(1)} specifying which sample to plot from
\code{colData(spe)$sample_name}.}

\item{geneid}{A \code{character(1)} specifying the gene ID stored in
\code{rowData(spe)$gene_search} or a continuous variable stored in \code{colData(spe)}
to visualize. If \code{rowData(spe)$gene_search} is missing, then \code{rownames(spe)}
is used to search for the gene ID.}

\item{spatial}{A \code{logical(1)} indicating whether to include the histology
layer from \code{\link[=geom_spatial]{geom_spatial()}}. If you plan to use
\link[plotly:ggplotly]{ggplotly()} then it's best to set this to \code{FALSE}.}

\item{assayname}{The name of the \code{assays(spe)} to use for extracting the
gene expression data. Defaults to \code{logcounts}.}

\item{minCount}{A \code{numeric(1)} specifying the minimum gene expression (or
value in the continuous variable) to visualize. Values at or below this
threshold will be set to \code{NA}. Defaults to \code{0}.}

\item{viridis}{A \code{logical(1)} whether to use the color-blind friendly
palette from \link[viridisLite:viridis]{viridis} or the color palette used
in the paper that was chosen for contrast when visualizing the data on
top of the histology image. One issue is being able to differentiate low
values from NA ones due to the purple-ish histology information that is
dependent on cell density.}

\item{image_id}{A \code{character(1)} with the name of the image ID you want to
use in the background.}

\item{alpha}{A \code{numeric(1)} in the \verb{[0, 1]} range that specifies the
transparency level of the data on the spots.}

\item{cont_colors}{A \code{character()} vector of colors that supersedes the
\code{viridis} argument.}

\item{point_size}{A \code{numeric(1)} specifying the size of the points. Defaults
to \code{1.25}. Some colors look better if you use \code{2} for instance.}

\item{...}{Passed to \link[base:paste]{paste0()} for making the title of the
plot following the \code{sampleid}.}
}
\value{
A \link[ggplot2:ggplot]{ggplot2} object.
}
\description{
This function visualizes the gene expression stored in \code{assays(spe)} or any
continuous variable stored in \code{colData(spe)} for one given sample at the
spot-level using (by default) the histology information on the background.
To visualize clusters (or any discrete variable) use \code{\link[=vis_clus]{vis_clus()}}.
}
\details{
This function subsets \code{spe} to the given sample and prepares the
data and title for \code{\link[=vis_gene_p]{vis_gene_p()}}. It also adds a caption to the plot.
}
\examples{

if (enough_ram()) {
    ## Obtain the necessary data
    if (!exists("spe")) spe <- fetch_data("spe")

    ## Valid `geneid` values are those in
    head(rowData(spe)$gene_search)
    ## or continuous variables stored in colData(spe)
    ## or rownames(spe)

    ## Visualize a default gene on the non-viridis scale
    vis_gene(
        spe = spe,
        sampleid = "151507",
        viridis = FALSE
    )

    ## Use a custom set of colors in the reverse order than usual
    vis_gene(
        spe = spe,
        sampleid = "151507",
        cont_colors = rev(viridisLite::viridis(21, option = "magma"))
    )

    ## Visualize a continuous variable, in this case, the ratio of chrM
    ## gene expression compared to the total expression at the spot-level
    vis_gene(
        spe = spe,
        sampleid = "151507",
        geneid = "expr_chrM_ratio"
    )

    ## Visualize a gene using the rownames(spe)
    vis_gene(
        spe = spe,
        sampleid = "151507",
        geneid = rownames(spe)[which(rowData(spe)$gene_name == "MOBP")]
    )
}
}
\seealso{
Other Spatial gene visualization functions: 
\code{\link{vis_gene_p}()},
\code{\link{vis_grid_gene}()}
}
\concept{Spatial gene visualization functions}
