#### Data: 06/09/2023

**$\Rightarrow$ MODELO DE REGRESSÃO PARA SÉRIES TEMPORAIS**

$y$: série temporal. Ex.: eletricidade;
$x$: série temporal. Ex.: temperatura.

**Hipóteses:**

$\rightarrow$ sobre relação entre $y$ e $x$:
- espera-se relação linear entre $y$ e $x$

$\rightarrow$ sobre os resíduos, espera-se:
- média 0 (se não tem, viesado)
- não sejam auto-correlacionados (se são, não capturou toda a informação)
- não sejam correlacionados com $x$
- bom (mas não essencial) ter normalidade e homocedasticidade

$\rightarrow$ sobre $x$:
- não é variável aleatória 
> Essa é uma hipótese que, na maioria dos casos reais, não é verdadeira. Geralmente não conhecemos $x$ perfeitamente, e por isso ele é fonte de incerteza. Veremos ao calcular intervalos de confiança, por exemplo, que a incerteza sobre $x$ não é levada em conta.

$$
y_t = \beta_0 + \beta_1 x_{1, t} + \cdots + \beta_k x_{k, t} + \epsilon_t
$$

**$\rightarrow$ Método dos Mínimos Quadrados (M. M. Q.):**

$$
\underbrace{\underset{\beta's}{\text{min}} \sum (y_t - \beta_0 + \beta_1 x_{1, t} + \cdots + \beta_k x_{k, t})^2}_{\text{minimização do erro quadrático}}
$$

Obtemos estimativas dos parâmetros $\beta$'s:

$$
\hat{y_t} = \hat{\beta}_0 + \hat{\beta}_1 x_{1, t} + \cdots + \hat{\beta}_k x_{k, t}
$$

**$\rightarrow$ Coeficiente de Determinação ($R^2$):**

$$
\begin{align*}
R^2 & = 1 - \dfrac{\text{RSS}}{\text{TSS}} \\
&= 1 - \dfrac{\sum (\hat{y}_t - \bar{y})^2}{\sum (y_t - \bar{y})^2}
\end{align*}
$$

$R^2$ é uma medida de ajuste do modelo. Quanto mais próximo de 1, melhor o ajuste. Quanto mais próximo de 0, pior o ajuste. Essa medida, no entanto, depende do treino. Se eu ficar adicionando variável, ele vai continuar reduzindo e supostamente chegaríamos ao modelo perfeito. Não podemos, portanto, nos basear somente nela, porque ela não consegue medir a capacidade de generalização do modelo (se houver *overfitting*, por exemplo, o $R^2$ vai ser bom).

**$\rightarrow$ Coeficiente de Determinação Ajustado ($R^2_{adj}$):**

$$
R^2_{adj} = 1 - \dfrac{\text{RSS}/(T-k-1)}{\text{TSS}/(T-1)}
$$

Tenta corrigir para avaliar também a capacidade de generalização do modelo.

**$\rightarrow$ Desvio padrão**

$$
\hat{\sigma} = \sqrt{\dfrac{1}{T-K-1} \sum_{t=1}^T \epsilon_t^2}
$$

Graus de liberdade: $T-K-1$. Na prática, grau de liberdade significa que não conseguimos, livremente, escolher os valores de todos os parâmetros. Quando fazemos o ajuste de um modelo linear com dois parâmetros com 10 valores, por exemplo, temos 8 graus de liberdade. 

**$\rightarrow$ Teste t** (para avaliar a significância de cada parâmetro):

$$
t = \dfrac{\hat{\beta}_j}{\sigma_{\hat{\beta}_j}} \sim \mathcal{T}_{T-2} \\
$$

$$
\begin{align*}
\text{H}_0&: \beta_j = 0 \\
\text{H}_1&: \beta_j \neq 0
\end{align*}
$$

Estamos dizendo que $t$ segue uma distribuição. Se o valor cai numa zona de baixa probabilidade assumindo que a hipótese nula é verdadeira, rejeitamos a hipótese nula. Se o valor cai numa zona de alta probabilidade, falhamos em rejeitar a hipótese nula. Um $\texttt{p-valor}$ baixo nos leva a rejeitar a hipótese nula, enquanto um $\texttt{p-valor}$ alto sugere que não temos evidências suficientes para rejeitar a hipótese nula.

Temos alguma métrica, fazemos hipóteses. Sob a hipótese nula, provamos que ela tem alguma distribuição específica e julgamos o valor da métrica de acordo com o que esperávamos. Se o valor cai numa zona de baixa probabilidade, rejeitamos a hipótese nula. Se o valor cai numa zona de alta probabilidade, falhamos em rejeitar a hipótese nula.

**$\rightarrow$ Teste F** (F-statistic)

$M_1$ com $p_1$ parâmetros
$M_2$ com $p_2$ parâmetros

$p_1 < p_2$ e $M_1$ é um subconjunto de $M_2$.

$$
F = \dfrac{(\text{RSS}_1 - \text{RSS}_2)/(p_2 - p_1)}{\text{RSS}_2/(T-p_2-1)} \sim \mathcal{F}_{p_2 - p_1, n-p_2}
$$

Mais especificamente para séries temporais, podemos verificar tendência e sazonalidade:

$$
y_t = \underbrace{\beta_0 + \beta_1 t}_{\text{tendência}} + \underbrace{\beta_2 d_{2, t} + \beta_3 d_{3, t} + \beta_4 d_{4, t}}_{\text{trimestral}} + \epsilon_t
$$

Se sabemos $\beta_2 d_{2, t} + \beta_3 d_{3, t} + \beta_4 d_{4, t}$, sabemos $d_1$, que é o trimestre que não está ali e é dado por $d_1 = 1 - d_2 - d_3 - d_4$. Se o adicionássemos, não teríamos solução, porque a matriz de design não teria inversa. 

$$
y_t = (y_1, \cdots, y_T)^T 
$$

$$
\hat{\beta} = (X^T X)^{-1} X^T y \Rightarrow \hat{y} = X \hat{\beta} = \underbrace{X (X^T X)^{-1} X^T y}_{H, \text{ hat matrix}} \\
$$

$$
X = \begin{pmatrix} 1 & t_1 & d_{2, 1} & d_{3, 1} & d_{4, 1} \\ \vdots & \vdots & \vdots & \vdots & \vdots \\ 1 & t_T & d_{2, T} & d_{3, T} & d_{4, T} \end{pmatrix}
$$

Leave One Out Cross Validation (LOOCV): para cada ponto, ajustamos o modelo sem aquele ponto e calculamos o erro. Fazemos isso para todos os pontos e calculamos a média. É um método de validação cruzada. Mas, usando a hat matrix, podemos fazer isso de forma mais eficiente ajustando o modelo apenas uma vez:

$$
\text{LOOCV} = \dfrac{1}{T} \sum^T_{t=1} \left( \dfrac{\overbrace{y_t - \hat{y}_{t}}^{\epsilon_t}}{1 - h_{t, t}} \right)^2
$$

---

$\rightarrow$ **TESTES PARA OS RESÍDUOS**

**Box-Pierce Test:** testa se os resíduos são independentes. A hipótese nula é que os resíduos são independentes. Se o p-value for menor que o nível de significância, rejeitamos a hipótese nula e concluímos que os resíduos não são independentes.

$$\text{Q} = \text{T} \sum^l_{k=1} r_k^2$$

onde $r_k$ é a autocorrelação amostral de ordem $k$ e $l$ é o número de defasagens (lags). T é o tamanho da amostra.

**Ljung-Box Test:** testa se os resíduos são independentes. A hipótese nula é que os resíduos são independentes. Se o p-value for menor que o nível de significância, rejeitamos a hipótese nula e concluímos que os resíduos não são independentes.

$$\text{Q}^* = \text{T} (\text{T} + 2) \sum^l_{k=1} \dfrac{r_k^2}{\text{T} - k}$$

onde $r_k$ é a autocorrelação amostral de ordem $k$ e $l$ é o número de defasagens (lags). T é o tamanho da amostra.

$\text{Q}$ e $\text{Q}^* \sim \mathcal{X}^2 (l-k)$, onde $k$ é o número de parâmetros estimados no modelo.