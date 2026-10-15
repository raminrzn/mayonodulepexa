# mayonodulepexa

The **Mayo Clinic solitary pulmonary nodule model** as a ModelsCloud service:
the probability that an indeterminate nodule on chest imaging is malignant.

Swensen SJ, et al. *Arch Intern Med.* 1997;157(8):849–855.
[doi:10.1001/archinte.1997.00440290031002](https://doi.org/10.1001/archinte.1997.00440290031002)

## Inputs

| Field | Coding |
|---|---|
| `age` | years |
| `smoker` | yes / no (current or former) |
| `prior_cancer` | yes / no: extrathoracic cancer diagnosed 5 or more years before the nodule |
| `diameter` | largest diameter, mm (developed on 4–30) |
| `spiculation` | yes / no |
| `upper_lobe` | yes / no |

Returns `probability` (0–1).

## Validation

Reproduces the published worked examples: 25% and 78% (Schultz et al.,
*Thorax* 2008) and 11.9% (BTS nodule guideline, 2015).

## Use

```r
remotes::install_git("https://github.com/raminrzn/mayonodulepexa", ref = "main")
mayonodulepexa::model_run(list(age = 54, smoker = "yes", prior_cancer = "no",
                               diameter = 16, spiculation = "no", upper_lobe = "yes"))
```

For research use. Not a medical device.

## License

GPL-3.
