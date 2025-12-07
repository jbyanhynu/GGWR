# GGWR
gradient-based geographically weighted regression


1. Yan, J., Wu, B., & Duan, X. (2024). Modeling Spatial Anisotropic Relationships Using Gradient-Based
Geographically Weighted Regression. Annals of the American Association of Geographers, 114(4), 697–718.
2. Wu, B., Yan, J., & Cao, K. (2023). l0
-Norm Variable Adaptive Selection for Geographically Weighted
Regression Model. Annals of the American Association of Geographers, 113(5), 1190–1206.


R²: the coefficient of determination (model fit);
adjR²: the adjusted coefficient of determination;
list_betas: a structured dataset containing the regression coefficients and their corresponding gradient field values.
Specifically, the first column and every subsequent 6th column represent the regression coefficients.
Columns 2 and 3 store the gradient values for the first coefficient; adding 6 to these column indices yields the gradient values for each successive coefficient following the same pattern.
AICc: the corrected Akaike Information Criterion.
