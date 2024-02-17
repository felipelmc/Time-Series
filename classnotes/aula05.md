#### Data: 28/08/2023

$\rightarrow$ **E SE NÃO FOR RAZOÁVEL ASSUMIR NORMALIDADE?**

**Intervalos de confiança a partir de bootstrapped residuals:** quando não e razoável assumir normalidade, podemos usar bootstrapping para estimar os intervalos de confiança. O processo assume que os resíduos são independentes e que a variância é constante.

$$
\begin{align*}
\epsilon_t &= y_t - \hat{y}_{t|t-1} \\
\Rightarrow y_t &= \hat{y}_{t|t-1} + \epsilon_t
\end{align*}
$$

Daí geramos novas observações $y_{t+1}$, assumindo que erros futuros sejam semelhantes aos erros passados, ou seja, amostramos erros futuros ($\epsilon_{t+1}$) a partir dos erros passados.

$$
y_{t+1} = \hat{y}_{t+1|t} + \epsilon_{t+1}
$$

Repetimos o processo para gerar $y_{t+2}$, $y_{t+3}$, etc, onde $y_{t+2} = \hat{y}_{t+2|t+1} + \epsilon_{t+2}$. Fazendo isso repetidamente, geramos uma distribuição de previsões futuras para calcular estimativas.

> Temos T pontos residuais e os dados observados do erro, ou seja, $\epsilon_1, \epsilon_2, \dots, \epsilon_T$. Utilizamos isso para gerar vários caminhos simulados futuros. As observações $\epsilon_{T+1}, \epsilon_{T+2}, \dots$ são amostrados dos resíduos passados. É como se você estivesse simulando daquela distribuição e gerando erros futuros a partir dela. Assumimos que os resíduos futuros vêm da mesma distribuição dos resíduos passados e que eles são não-correlacionados (porque amostramos uniformemente). 
>
> Bootstrap é uma ferramenta para calcular incerteza. Se você tem poucos dados, naturalmente a incerteza já é grande e o bootstrap vai refletir isso.
>
> ![bootstrapping](images/residuals-bootstrap.jpeg)

**Box-Cox transformation**: se os dados apresentam variações que crescem ou diminuem dependendo do nível da série (ou seja, não tem variância constante), podemos aplicar uma transformação Box-Cox para estabilizar a variância. A transformação é dada por:

$$
w_t = \begin{cases} 
\dfrac{y_t^\lambda - 1}{\lambda}, & \text{se } \lambda > 0 \\ 
\log(y_t), & \text{se } \lambda = 0 \end{cases}
$$

O parâmetro $\lambda$ é estimado a partir dos dados, como um hiperparâmetro. Exemplo quando $\lambda = 0 \Rightarrow w_t = \log(y_t) \Rightarrow y_t = \exp(w_t)$.

$$
\begin{align*}
    &\mathbb{P} (w_1 \leq w_t \leq w_2) = 0.95 \\
    &\mathbb{P} (w_1 \leq \log (y_t) \leq w_2) = 0.95 \\
    &\mathbb{P} (\exp (w_1) \leq y_t \leq \exp (w_2)) = 0.95
\end{align*}
$$

A associação entre a média de uma escala e a média em outra escala não é direta como $\bar{y} = \exp(\bar{w})$. Precisamos calcular:

$$
\begin{align*}
f(y) &= \left| \dfrac{\partial w}{\partial y} \right| f(w) \\
     &= f(w) \left| \dfrac{\partial \log (y_t)}{\partial y} \right| \\
     &= f(w) \left| \dfrac{1}{y_t} \right| \\
\end{align*}
$$

$$
\underbrace{\mathbb{E}[Y] = \int_{0}^{\infty} y f(y) dy}_{\text{complicado de computar}} = \int_{0}^{\infty} y f(\log y) \dfrac{1}{y} dy
$$
