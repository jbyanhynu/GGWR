# GGWR
Gradient-based geographically weighted regression


1. Yan, J., Wu, B., & Duan, X. (2024). Modeling Spatial Anisotropic Relationships Using Gradient-Based
Geographically Weighted Regression. Annals of the American Association of Geographers, 114(4), 697–718.
2. Wu, B., Yan, J., & Cao, K. (2023). l0
-Norm Variable Adaptive Selection for Geographically Weighted
Regression Model. Annals of the American Association of Geographers, 113(5), 1190–1206.
3. Yan, J. 2023. 地理加权各向异性回归模型与方法研究.


R²: goodness of fit;

adjR²: Adjusted goodness of fit;

list_betas: a structured dataset containing the regression coefficients and their corresponding gradient values.
Specifically, the first column and every subsequent 6th column represent the regression coefficients.
Columns 2 and 3 store the gradient values for the first coefficient; adding 6 to these column indices yields the gradient values for each successive coefficient following the same pattern.

AICc: the corrected Akaike Information Criterion.

ICS: an interpretability of coefficient symbol (ICS) metric is designed to evaluate coefficient estimates that are correlated and across spaces that are at times counterintuitive and
contradictory in sign to global regression estimates. Further details regarding ICS can be found in Reference 2.
