#' Sample spatial cluster visualization workhorse function
#'
#' This function visualizes the clusters for one given sample at the spot-level
#' using (by default) the histology information on the background. This is the
#' function that does all the plotting behind [vis_clus()]. To visualize
#' gene-level (or any continuous variable) use [vis_gene_p()].
#'
#' @inheritParams vis_clus
#' @param d A data.frame with the sample-level information. This is typically
#' obtained using `cbind(colData(spe), spatialCoords(spe))`.
#' @param title The title for the plot.
#'
#' @return A [ggplot2][ggplot2::ggplot] object.
#' @export
#' @importFrom tibble tibble
#' @importFrom SpatialExperiment imgData scaleFactors
#' @importFrom S4Vectors metadata
#' @importFrom grid rasterGrob unit
#' @family Spatial cluster visualization functions
#'
#' @examples
#'
#' if (enough_ram()) {
#'     ## Obtain the necessary data
#'     if (!exists("spe")) spe <- fetch_data("spe")
#'     spe_sub <- spe[, spe$sample_id == "151673"]
#'
#'     ## Use the manual color palette by Lukas M Weber
#'     ## Don't plot the histology information
#'     vis_clus_p(
#'         spe = spe_sub,
#'         d = as.data.frame(cbind(colData(spe_sub), SpatialExperiment::spatialCoords(spe_sub)), optional = TRUE),
#'         clustervar = "layer_guess_reordered",
#'         sampleid = "151673",
#'         colors = libd_layer_colors,
#'         title = "151673 LIBD Layers",
#'         spatial = FALSE
#'     )
#'
#'     ## Clean up
#'     rm(spe_sub)
#' }
vis_clus_p <-
    function(spe,
    d,
    clustervar,
    sampleid,
    colors,
    spatial,
    title,
    image_id = "lowres",
    alpha = 1,
    point_size = 1.25) {

        ## Some variables
        pxl_row_in_fullres <- pxl_col_in_fullres <- key <- NULL
        # stopifnot(all(c("pxl_col_in_fullres", "pxl_row_in_fullres", "key") %in% colnames(d)))

        if (clustervar %in% c(
            "layer_guess",
            "layer_guess_reordered",
            "layer_guess_reordered_short",
            "spatialLIBD"
        )) {
            title <- gsub(clustervar, "LIBD Layers", title)
        }
        img <- SpatialExperiment::imgRaster(spe, sample_id = sampleid, image_id = image_id)

        p <- ggplot(
            d,
            aes(
                x = pxl_col_in_fullres * SpatialExperiment::scaleFactors(spe, sample_id = sampleid, image_id = image_id),
                y = pxl_row_in_fullres * SpatialExperiment::scaleFactors(spe, sample_id = sampleid, image_id = image_id),
                fill = factor(!!sym(clustervar)),
                key = key
            )
        )
        if (spatial) {
            grob <- grid::rasterGrob(img, width = grid::unit(1, "npc"), height = grid::unit(1, "npc"))
            p <-
                p + geom_spatial(
                    data = tibble::tibble(grob = list(grob)),
                    aes(grob = grob),
                    x = 0.5,
                    y = 0.5
                )
        }
        p <- p +
            geom_point(
                shape = 21,
                size = point_size,
                stroke = 0,
                colour = "transparent",
                alpha = alpha
            ) +
            coord_cartesian(expand = FALSE) +
            scale_fill_manual(values = colors) +
            xlim(0, ncol(img)) +
            ylim(nrow(img), 0) +
            xlab("") + ylab("") +
            labs(fill = NULL) +
            guides(fill = guide_legend(override.aes = list(size = 3))) +
            ggtitle(title) +
            theme_set(theme_bw(base_size = 20)) +
            theme(
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_blank(),
                axis.line = element_blank(),
                axis.text = element_blank(),
                axis.ticks = element_blank()
            )
        return(p)
    }
