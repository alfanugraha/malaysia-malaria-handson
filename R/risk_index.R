# R/risk_index.R
# Climate-driven malaria risk index
# Combines temperature suitability, rainfall, and case incidence
# References: Mordecai et al. 2013, Caminade et al. 2014

#' Temperature suitability for Anopheles (peak ~25°C)
temp_suitability <- function(temp_raster) {
  # Gaussian suitability curve — optimal at 25°C, zero below 16 and above 34
  suit <- exp(-0.5 * ((temp_raster - 25) / 4)^2)
  suit[temp_raster < 16 | temp_raster > 34] <- 0
  return(suit / max(values(suit), na.rm = TRUE))  # normalise 0-1
}

#' Rainfall suitability (breeding sites — optimal 150-300mm/month)
rain_suitability <- function(rain_raster) {
  suit <- rain_raster
  suit[rain_raster < 50]  <- 0
  suit[rain_raster > 400] <- 0
  suit <- (suit - 50) / (300 - 50)
  suit[suit < 0] <- 0
  suit[suit > 1] <- 1
  return(suit)
}

#' Composite risk index
#' @param temp_suit normalised temperature suitability raster (0-1)
#' @param rain_suit normalised rainfall suitability raster (0-1)
#' @param w_temp weight for temperature (default 0.5)
#' @param w_rain weight for rainfall (default 0.5)
compute_risk_index <- function(temp_suit, rain_suit,
                               w_temp = 0.5, w_rain = 0.5) {
  risk <- (w_temp * temp_suit) + (w_rain * rain_suit)
  return(risk)
}

