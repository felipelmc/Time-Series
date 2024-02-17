#### Data: 11/09/2023

Na última aula, estudamos modelos de regressão. De forma geral, vimos:

$\rightarrow$ **Valores ajustados**

$$
\begin{align*}
    \hat{y} &= X \hat{\beta} \\
    &= X (X^T X)^{-1} X^T y \\
    &= Hy
\end{align*}
$$

$$
H = X (X^T X)^{-1} X^T
$$

Podemos utilizar os valores da diagonal de H para fazer Leave One Out Cross Validation (LOOCV) com menor custo computacional. Não fosse isso, seria necessário fazer o ajuste do modelo $T$ vezes, uma para cada ponto.

$$
\text{LOOCV} = \dfrac{1}{T} \sum^T_{t=1} \left[  \dfrac{\epsilon_t}{(1 - h_t)^2} \right]
$$

$\rightarrow$ **Previsão**

$$
\begin{align*}
    \hat{y} &= x^* \hat{\beta} \\
    &= x^* (X^T X)^{-1} X^T y \\
\end{align*}
$$

$\rightarrow$ **Variância das previsões**

$$
\hat{\sigma}^2_{\epsilon} \cdot \left[ 1 + x^{*} (X^T X)^{-1} x^{*T} \right]
$$

$\rightarrow$ **Intervalo de confiança das previsões**

$$
\hat{y} \pm 1.96 \cdot \hat{\sigma}_{\epsilon} \cdot \sqrt{1 + x^{*} (X^T X)^{-1} x^{*T}}
$$

O componente $\sqrt{1 + x^{*} (X^T X)^{-1} x^{*T}}$ é um indicativo da incerteza da previsão: 

1. variabilidade dos dados não explicada pelo modelo;
2. incerteza na estimativa dos coeficientes $\hat{\beta}$.

Outra fonte de incerteza é o fato de que assumimos que as covariáveis são conhecidas. Mas, na prática, também não temos necessariamente certeza sobre elas.