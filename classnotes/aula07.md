#### Data: 04/09/2023

$\Rightarrow$ **AVALIAR PREVISÕES PONTUAIS**

- Importante olhar resíduos
- Importante checar previsões fora da amostra

$$\underbrace{-------------}_{\text{training}} \ \underset{\text{T}}{|} \ \underbrace{------>}_{\text{test}}$$

$$
e_{T+h} = y_{T+h} - \hat{y}_{T+h|T}
$$

Nesse caso, $\hat{y}_{T+h|T}$ é uma previsão fora da amostra, como se seu modelo não tivesse visto. Então, $e_{T+h}$ é um resíduo fora da amostra.

Métricas normalmente utilizadas:

- Mean Absolute Error (**MAE**): $\text{mean}(|e_t|)$
- Root Mean Squared Error (**RMSE**): $\sqrt{\text{mean}(e_t^2)}$

Problema: essas medidas estão na mesma escala que os dados. Nesse caso, utilizamos outras métricas como Mean Absolute Percentage Error (MAPE):

- **MAPE**: com $P_t = \dfrac{100 \cdot e_t}{y_t}$, temos $\text{mean}(|P_t|)$. Essa é uma métrica que não pode ter valores iguais a 0 e instável para valores próximos de 0.

Com $q_j = \dfrac{e_j}{\frac{1}{T-m} \sum^T_{t=1}|y_t - y_{t-m}|}$, $m=1$, ou $q_j = \dfrac{e_j}{\frac{1}{T-m} \sum^T_{t=1}(y_t - y_{t-m})^2}$, temos:

- **MASE**: $\text{mean}(|q_j|)$
- **RMSSE**: $\sqrt{\text{mean}(q_j^2)}$

$\Rightarrow$ **AVALIAR PRECISÃO DAS DISTRIBUIÇÕES DE PREVISÃO**

Se quisermos, por exemplo, a previsão de um determinado quantil, usamos **Quantile Score**:

$$
Q_{p, t} = 
\begin{align*}
    \begin{cases}
        2 (1-p) (f_{p, t} - y_t), & \text{se } y_t < f_{p, t} \\
        2 p (y_t - f_{p, t}), & \text{se } y_t \geq f_{p, t}
    \end{cases}
\end{align*}
$$

Quando usamos medidas como RMSE, estamos olhando para a média da distribuição. No caso da MAE, estamos olhando para a mediana da distribuição. No quantile score, não estamos restritos ao quantil 0.5 (mediana), mas podemos olhar para qualquer quantil. Se usamos o quantile score para o quantil 0.5, estamos olhando para a mediana da distribuição e chegamos às mesmas conclusões que chegamos com a MAE.

**O modelo mais calibrado é aquele que tem o menor quantile score para aquele quantil**, o que significa que a sua distribuição empírica está caindo mais próxima da distribuição teórica.

Muitas vezes queremos fazer uma lista de usuários lucrativos, mas para garantir isso queremos que o quantil 5% seja positivo, i.e., estatisticamente significativo. 

Outra medida é o **Winkler Score**, para intervalos de confiança. $100 (1 - \alpha) \%$ intervalo de confiança no tempo $t$: $[l_{\alpha, t}, u_{\alpha,t}]$

$\alpha = 0.05$

$$
W_{\alpha, t} = 
\begin{align*}
    \begin{cases}
        (u_{\alpha, t} - l_{\alpha, t}) + \dfrac{2}{\alpha} (l_{\alpha, t} - y_t), & \text{se } y_t < l_{\alpha, t} \\
        (u_{\alpha, t} - l_{\alpha, t}),  & \text{se } l_{\alpha, t} \leq y_t \leq u_{\alpha, t} \\
        (u_{\alpha, t} - l_{\alpha, t}) + \dfrac{2}{\alpha} (y_t - u_{\alpha, t}), & \text{se } y_t > u_{\alpha, t}
    \end{cases}
\end{align*}
$$

$l_{\alpha, t} = f_{\frac{\alpha}{2}, t}$
$u_{\alpha, t} = f_{1 - \frac{\alpha}{2}, t}$

$W_{\alpha, t} = \dfrac{Q_{\frac{\alpha}{2}}, Q_{1 - \frac{\alpha}{2}, t}}{\alpha}$

Métrica para avaliar toda a distribuição: **Continuous Ranked Probability Score (CRPS)**

$$
\begin{align*}
& \text{CRPS} (F, y_t) = \int_{-\infty}^{\infty} (\underbrace{F(x)}_{\mathbb{P}(Y_t \leq x)} - 1(x - y_t))^2 dx \\
& 1(x-y_t) = \begin{cases} 1, & \text{se } x \geq y_t \\ 0, & \text{se } x < y_t \end{cases}
\end{align*}
$$

Eu espero que 5% dos valores estejam aqui. Se tiver mais do que 5% dos valores ali, o número dentro da integral vai ser maior com uma frequência maior de vezes. Nesse caso, o modelo penaliza mais o modelo.

> **Reforçando:** O uso de cada métrica depende do caso. Se quero observar coisas pontuais em relação ao quantil, uso o quantile score. Se quero observar intervalos de confiança, uso o Winkler Score. Se quero observar a distribuição inteira, uso o CRPS.
