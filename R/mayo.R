# Mayo Clinic solitary pulmonary nodule model (Swensen et al. 1997), equation
# as given in Schultz et al. Thorax 2008, Box:
# x = -6.8272 + 0.0391*age + 0.7917*smoker + 1.3388*cancer
#     + 0.1274*diameter + 1.0407*spiculation + 0.7838*upper
# p = exp(x) / (1 + exp(x)).

#' Mayo Clinic nodule malignancy probability
#'
#' @param age Age in years.
#' @param smoker Current or former smoker, yes/no.
#' @param prior_cancer Extrathoracic cancer diagnosed 5 or more years before
#'   the nodule, yes/no.
#' @param diameter Largest nodule diameter, mm (developed on 4-30 mm).
#' @param spiculation Spiculated margin, yes/no.
#' @param upper_lobe Nodule in an upper lobe, yes/no.
#' @return A data frame with `probability` (0-1).
#' @references Swensen SJ, et al. *Arch Intern Med.* 1997;157:849-855.
#'   \doi{10.1001/archinte.1997.00440290031002}; Schultz EM, et al. *Thorax.*
#'   2008;63:335-341. \doi{10.1136/thx.2007.084731}
#' @examples
#' mayo(age = 54, smoker = "yes", prior_cancer = "no", diameter = 16,
#'      spiculation = "no", upper_lobe = "yes")
#' @export
mayo <- function(age, smoker, prior_cancer, diameter, spiculation, upper_lobe) {
  age <- .mayo_num(age, "age", 18, 110)
  d   <- .mayo_num(diameter, "diameter", 0.1, 100)
  x <- -6.8272 + 0.0391 * age + 0.7917 * .mayo_yesno(smoker, "smoker") +
    1.3388 * .mayo_yesno(prior_cancer, "prior_cancer") + 0.1274 * d +
    1.0407 * .mayo_yesno(spiculation, "spiculation") +
    0.7838 * .mayo_yesno(upper_lobe, "upper_lobe")
  data.frame(probability = stats::plogis(x))
}
