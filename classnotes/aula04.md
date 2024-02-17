#### Data: 21/08/2023

$\Rightarrow$ **ANALISANDO MODELOS**

**Fitted values** (valores ajustados): embora sejam utilizados para analisar modelos, não podem ser utilizados para medir a capacidade de generalização dos modelos. Não podem ser utilizados para predição porque todos os parâmetros do modelo foram estimados com todos os pontos disponíveis.

**Resíduos**: $\epsilon_t = y_t - \hat{y_t}$. Resíduos são os restos após ajustar o modelo. Vale lembrar que se aplicarmos alguma transformação aos dados - por exemplo, $w_t = \log (y_t)$, então $\epsilon_t = w_t - \hat{w_t}$. Ou seja, se aplicamos alguma transformação aos dados, temos que olhar para os resíduos transformados. O resíduo na escala transformada é chamado de resíduo de inovação.

**Diagnosticando resíduos:**

Bons métodos de previsão terão as seguintes características:

- resíduos não correlacionados (caso estejam correlacionados, alguma informação não foi capturada pelo modelo)
- resíduos com média zero (caso não tenham média zero, o modelo está tendencioso)

São boas características, mas não são estritamente necessárias:

- variância constante (homocedasticidade)
- resíduos normalmente distribuídos

Essas características facilitam muito o cálculo de intervalos de confiança e testes de hipótese.

$\Rightarrow$ **DISTRIBUIÇÃO DAS PREVISÕES**

Uma previsão pontual é a média da distribuição. Na maioria das vezes, assumimos que modelos são Gaussianos, então a previsão pontual é a média da distribuição Gaussiana. Portanto, supondo que queremos calcular um intervalo de confiança de $95\%$, temos:

$$
\hat{y}_{t+h | t} \pm 1.96 \sqrt{\text{Var}(\hat{y}_{t+h | t})}
$$

**Intervalos de confiança one-step**: podem ser estimados a partir do desvio padrão dos resíduos. 

$$
\hat{\sigma} = \sqrt{\dfrac{1}{\text{T - K - M}} \sum_{t=1}^T \epsilon_t^2},
$$

onde K é número de parâmetros estimados e M é o número de resíduos perdidos (faltantes).

Ou seja, começamos estimando o desvio padrão um passo a frente, e depois calculamos o desvio padrão $h$ passos a frente: $\hat{\sigma}_h = g(\hat{\sigma})$

Média: $\hat{\sigma}_h = \hat{\sigma}\sqrt{1 + \dfrac{1}{T}}$

Naive: $\hat{\sigma}_h = \hat{\sigma}\sqrt{h}$

Sazonal: $\hat{\sigma}_h = \hat{\sigma}\sqrt{k+1}$

Random Walk with Drift: $\hat{\sigma}_h = \hat{\sigma}\sqrt{h \left(\dfrac{1+h}{T-1} \right)}$
