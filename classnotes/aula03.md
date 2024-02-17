#### Data: 16/08/2023

**RECAPITULANDO...**

Quando você assume estacionaridade, isso pode não ser verdade. Quando você modela um process estocástico sob essa suposição, você espera que o processo seja aproximadamente Gaussiano. E, obviamente, quanto menos Gaussiano for o processo, menos ótima vai ser a modelagem do processo sob uma forma linear. Trata-se de uma simplificação que pode funcionar melhor ou pior dependendo da forma como o processo é gerado.

$$
\text{MSE} (\text{m}(y_T)) \leq \text{MSE} (\text{l}(y_T)) \ \forall \text{ estimador linear } \text{l}(y_T)
$$

Isso, naturalmente, quando $\text{m}(y_T) \neq \text{l}(y_T)$

**❗TODO PROCESSO ESTACIONÁRIO É UM PROCESSO LINEAR OU PODE SER TRANSFORMADO EM PROCESSO LINEAR.**

$\Rightarrow$ **ESTIMATIVAS BASEADAS EM MODELOS**

Temos um processo que queremos modelar, i.e., observamos certos dados sem conhecer o processo gerador.

$$
\{Y_t\} = y_1, y_2, \dots, y_T
$$

Dado isso, queremos estimar $h$ passos a frente. Precisamos propor um modelo que faça isso, qualquer que seja. Existem modelos muito simples que podem ser úteis, por exemplo:

**Modelo 1:** $y_t = \mu + \epsilon_t, \epsilon_t \sim \mathcal{N}(0, \sigma^2)$

Qual é a estimativa pontual para $y_{t+h}$? $\hat{y}_{t+h | t}$? É uma estimativa do $\hat{\mu}$, que é justamente a média amostral. Então, $\hat{y}_{t+h | t} = \hat{\mu} = \bar{y}$.

**Modelo 2 (Random Walk ou Naive):** $y_t = y_{t-1} + \epsilon_t, \epsilon_t \sim \mathcal{N}(0, \sigma^2)$

E qual é a estimativa pontual para $y_{t+h}$? $\hat{y}_{t+h | t}$? É uma estimativa do $\hat{\mu}$, que é justamente a média amostral. Então, qual e uma estimativa $\hat{y}_{t+h | t}$? É $y_t$.

**Modelo 3 (Sazonal):** $\hat{y}_{t+h | t} = y_{t+h-m(k+1)}$, onde $m$ é o período da sazonalidade e $k = \lfloor(h-1)/m\rfloor$ (arredonda para baixo).

**Modelo 4 (Random Walk with Drift):** $y_t = \text{c} + y_{t-1} + \epsilon_t, \epsilon_t \sim \mathcal{N}(0, \sigma^2)$. Utiliado para detectar tendência. Além disso, $\text{c} = \frac{y_T - y_i}{T-1}$. Então, $\hat{y}_{t+h | t} = \text{c} \cdot h + y_t$. 

Essa multiplicação por $h$ se justifica pela seguinte questão:

$$
\begin{align*}
    &y_{t+1} = \text{c} + y_t \\
    &y_{t+2} = \text{c} + \underbrace{y_{t+1}}_{\text{c} +y_t} 
\end{align*}
$$
