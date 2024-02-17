#### Data: 09/08/2023

$$\underbrace{\{y_t\}_{t=1}^T}_{\text{observação de um processo estocástico}} \rightarrow \{Y_t\}^T_{t=1}$$

É difícil computar a distribuição conjunta de $Y_1, \dots, Y_T$, mas é possível utilizando a Gaussiana $\sim \mathcal{N}(\mu, \Sigma)$, i.e., $1^o$ e $2^o$ momentos são suficientes.

$\{y_t\}_{t=1}^T \rightarrow \{Y_t\}^T_{t=1} \Rightarrow \text{Distribuição conjunta} \Rightarrow \text{Complexo} \Rightarrow 1^o \text{ e } 2^o \text{ momentos }$

$\Rightarrow \text{Gaussiana} \Rightarrow \text{Regressão Linear} \Rightarrow \underbrace{\text{Dilema viés-variância}}_{\mathbb{E}[(y - y_i)^2] = \text{bias + variance}}$

Casos:

1. $T >> P$, baixo viés e baixa variância
2. $T \sim P$, alta variância
3. $T < P$, variância infinita

> T é observação, P é covariável.

Para solucionar os casos 2 e 3, normalmente usamos regularização, em particular Lasso (L1) e Ridge (L2).

Suponha $\hat{y}_t = \beta_0 + \beta_1 x_1 + \dots \beta_p x_p$. Queremos minimizar o erro quadrático médio, dado por $\mathbb{E}[(y - \hat{y})^2] = \text{bias}^2 + \text{variance} + \text{noise}$.

A regularização L1, Lasso, é dada por $\mathbb{E}[(y - \hat{y})^2] + \lambda \sum_{j=1}^p |\beta_j|$, onde $\lambda$ é o parâmetro de regularização. A regularização L2, Ridge, é dada por $\mathbb{E}[(y - \hat{y})^2] + \lambda \sum_{j=1}^p \beta_j^2$.

Penalizamos para tirar flexibilidade do modelo, que estava estimando com muita incerteza. Isso aumenta o viés, porque impedimos determinados valores e limitamos a modelagem, mas diminui a variância com mais velocidade (trade-off). O Lasso, inclusive, leva valores pouco prováveis de $\beta$ a zero, então funciona como uma seleção de variáveis de alguma forma:

$$\hat{y}_t = \beta_0 + \cancel{\beta_1} x_1 + \dots \beta_p x_p$$

> O.B.S.: Tudo isso assume que o processo gerador dos dados é aproximadamente linear. Se o linear não performa bem, podemos usar Generalized Additive Models (GAMs) ou Redes Neurais, por exemplo.

GAM: $y_t = \underbrace{f_1 (x_{1, t})}_{\text{polinomial, p. ex.}} + \dots + \underbrace{f_p (x_{p, t})}_{\text{smoothing spline}} + \epsilon_t$.

$f_1(x_{1, t}) = \gamma_0 + \gamma_1 x_{1, t} + \gamma_2 (x_{1, t})^2$

**❗COMO IDENTIFICAR UM PROBLEMA DE SÉRIE TEMPORAL QUE NÃO FOI RESOLVIDO PELOS MÉTODOS CLÁSSICOS?**

Olhamos os resíduos, mas usando ferramentas para avaliar se existe relação temporal nos dados. Aí, nesse caso, tentamos modelar o que não foi explicado usando um modelo temporal.

**DEFINIÇÕES:**

Dados $\{y_t\}$ e $\mathbb{E}[(y_t)^2] < \infty$, temos:

- $\mu_y(t) = \mathbb{E}[y_t]$
- $\gamma_y(r, s) = \text{cov}(y_r, y_s) = \mathbb{E}[(y_r - \mu_y(r))(y_s - \mu_y(s))]$

**$ \Rightarrow \{y_t\}$ fracamente estacionária:**

(i) $\mu_y(t) = \mu_y \ \forall t$. Isso significa que a média independe do tempo.
(ii) $\gamma_y(t, t+h)$ é independente de t, ou seja, só depende da distância entre os tempos. Por isso, só escrevemos $\gamma_y(h)$.

$\gamma_y (h) = \text{cov}(y_t, y_{t+h}) \ \forall t$
Não importa se t = 1 ou t = 100, a distribuição não será diferente.

**Auto-correlation function:** $f_y(h) = \dfrac{\gamma_y(h)}{\gamma_y(0)} = \text{corr}(y_t, y_{t+h})$.
Trata-se da função de covariância dividida pela variância.

Definição de fracamente estacionário: $\mu_y (t, x) = a + bx$. Não é uma constante, somente não depende do tempo (t).

**Considere $\{y_t\} \text{ I.I.D. } (0, \sigma^2)$**

- $\mu_y(t) = 0 \ \forall t$
- $\gamma_y(h) = \begin{cases} \sigma^2, & \text{se } h = 0 \\ 0, & \text{se } h \neq 0 \end{cases}$
Por serem independentes, a covariância é zero se h é diferente de zero.

É um caso particular de fracamente estacionária, já que observamos que a média é constante e a covariância só depende da distância entre os tempos. Ou seja, nada depende do tempo.

**Considere $\{y_t\} \sim \text{WN}(0, \sigma^2)$**

WN é ruído branco, o que significa que as variáveis aleatórias são não correlacionadas (independência implica não correlação, mas não correlação não implica independência).

No caso normal, o caso do WN e o caso I.I.D. são equivalentes.

**Média amostral:** Dados $y_1, y_2, \dots, y_T$, a média amostral é dada por $\bar{y} = \frac{1}{T} \sum_{t=1}^T y_t$.

**Variância amostral (ou autocovariância, porque estamos tratando de uma série estacionária):** Dados $y_1, y_2, \dots, y_T$, a variância amostral é dada por $\hat{\gamma}^2 = \frac{1}{T} \sum_{t=1}^{T-|h|} (y_{t-|h|} - \bar{y})(y_t - \bar{y})$.

**Autocorrelação amostral:** Dados $y_1, y_2, \dots, y_T$, a autocorrelação amostral é dada por $\hat{\rho}_h = \dfrac{\hat{\gamma}_h}{\hat{\gamma}_0}, -T < h < T$. A autocorrelação amostral tende para uma $\mathcal{N}(0, \sigma*^{2})$.

O comportamento dessa função é fundamental para verificar se existe relação temporal nos dados. Observamos os resíduos para ver se existe relação temporal nos dados. 

Se **não houver** relação temporal, esperamos algo como:

![sem-relacao-temporal](images/sem-relacao-temporal.jpg)

Se **houver** relação temporal, esperamos algo como:

![relacao-temporal](images/relacao-temporal.jpg)