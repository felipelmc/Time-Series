#### Data: 14/08/2023

**$\Rightarrow \{Y_t\}$ série temporal Gaussiana**
Queremos prever $Y_{t+h} | Y_t = y_t$

Sabemos que a série temporal possui uma média $\mu$, uma variância $\sigma_2$ e uma ACF $\rho (h)$. Então:

$$Y_{t+h} | Y_t = y_t \sim \mathcal{N} [\mu + \rho (h) (y_t - \mu), \sigma^2 (1 - \rho (h)^2)] $$

Seja $\text{m} (y_t)$ uma estimativa pontual $Y_{t+h}|Y_t$. Se quisermos minimizar o erro quadrático médio (MSE) de $\text{m} (y_t)$, usamos a média. 

$$
\begin{align*}
\text{MSE} &= \mathbb{E}[Y_{t+h} - \text{m} (Y_t)]^2 \\
           &= \sigma^2 (1 - \rho (h)^2)
\end{align*}
$$

Então, quando $\rho (h) \rightarrow 0, \text{m}(Y_t) \rightarrow \mu$ e $\text{MSE} \rightarrow \sigma^2$.

No caso em que $\rho(h) \rightarrow 1$, $\text{m}(Y_t) \rightarrow y_t$ e $\text{MSE} \rightarrow 0$.

**$\Rightarrow \{Y_t\}$ série temporal (não-Gaussiana)**
Agora, se a série temporal não é gaussiana, teríamos que conseguir minimizar o MSE de outra forma - geralmente usando algum método computacional.

Temos $\text{m}(y_t)$ (a média) e algum estimador linear $\text{l}(Y_t) = \text{a} Y_t + \text{b}$ da média.

$\text{m}(Y_t) = \text{l}(Y_t) \rightarrow \text{minimiza MSE}$

$\text{m}(Y_t) \neq \text{l}(Y_t) \rightarrow \text{l}(Y_t) \text{ não minimiza MSE}$

O estimador linear só é ótimo no caso Gaussiano. Em geral, não é ótimo. Funções lineares funcionam bem no mundo Gaussiano, assim como primeiro e segundo momentos são suficientes. Então, assumimos que a série temporal é Gaussiana e usamos a média e a variância para que o modelo seja útil de alguma forma e mais fácil de ser computado.
