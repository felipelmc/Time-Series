#### Data: 16/10/2023

Revisão dos pontos importantes para ARIMA:

- **Modelo autorregrssivo**

$$
y_t = c + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \epsilon_t, \quad \epsilon_t \sim \text{WN}(0, \sigma^2)
$$

A função de autocorrelação no caso dos modelos autoregressivos tem a característica de decaimento exponencial dos lags ou um decaimento sinoidal. Podemos usar a Partial Autocorrelation Function (PACF) para identificar o número de lags significativos, excluindo os efeitos dos lags intermediários que pareçam correlacionados entre si.

> Supondo uma série temporal de vendas de um produto altamente sazonal. A empresa faz determinada mudança no produto e quer saber se isso aumenta as vendas, mas estamos entrando no verão, quando as vendas aumentam naturalmente. Como podemos medir o efeito da mudança no produto? A ideia é incluir no modelo uma variável que capture o efeito da sazonalidade, como por exemplo, a temperatura. Caso não adicionássemos e essa variável fosse significativa, poderíamos incorrer em um erro de especificação, pensando que a mudança no produto foi significativa quando na verdade foi a sazonalidade.

**DIFERENÇA:** A Autocorrelation Function está preocupada sem saber se existe correlação no lag $k$, não importando a fonte dessa correlação. A Partial Autocorrelation Function está preocupada em saber se existe correlação no lag $k$, mas considerando os efeitos dos lags intermediários. Usamos a PACF para encontrar a ordem do modelo autorregressivo (o $p$ em $\text{AR(p)}$).

- **Modelo de média móvel**

$$
y_t = c + \theta_1 \epsilon_{t-1} + \theta_2 \epsilon_{t-2} + \cdots + \theta_q \epsilon_{t-q} + \epsilon_t, \quad \epsilon_t \sim \text{WN}(0, \sigma^2)
$$

No modelo de média móvel é ao contrário: usa-se a ACF para encontrar a ordem do modelo de média móvel (o $q$ em $\text{MA(q)}$).

- **Backshift notation**

$B y_t = y_{t-1}$

$B^m y_t = y_{t-m}$

$$
\begin{align*}
(1-B)(1 - B^m)y_t &= (1-B-B^m+B^{m+1})y_t \\
&= y_t - y_{t-1} - y_{t-m} + y_{t-m-1}\\
\end{align*}
$$

Trata-se de uma notação para conveniência e facilitar cálculos.

Diferença de primeira ordem:
$$
y_t^\prime = y_t - y_{t-1} = (1-B)y_t
$$

É possível fazer uma diferença de segunda ordem caso a série ainda não esteja estacionária:

$$
y_t^{\prime \prime} = y_t^\prime - y_{t-1}^\prime = y_t - 2y_{t-1} + y_{t-2} = (1-B)^2 y_t
$$

Torna possível escrever diferenças de ordem $d$ como $(1-B)^d y_t$ e de maneira simplificada.


**ARIMA**

$$
y_t^\prime = c + \phi_1 y_{t-1}^\prime + \cdots + \phi_p y_{t-p}^\prime + \theta_1 \epsilon_{t-1} + \cdots + \theta_q \epsilon_{t-q} + \epsilon_t
$$

$$
(1 - \phi_1 B - \cdots - \phi_p B^p) (1-B)^d y_t = c + (1 + \theta_1 B + \cdots + \theta_q B^q) \epsilon_t
$$

$$
\text{ARIMA(p, d, q)}
$$

- $\text{ARIMA(0, 0, 0)}, c = 0$: white noise
- $\text{ARIMA(0, 1, 0)}, c = 0$: random walk
- $\text{ARIMA(0, 1, 0)}, c \neq 0$: random walk with drift
- $\text{ARIMA(p, 0, 0)}, c \neq 0$: $\text{AR}(p)$
- $\text{ARIMA(0, 0, q)}, c \neq 0$: $\text{MA}(q)$

<br>

- $c = 0, d = 0$: previsão de longo prazo $\rightarrow$ zero cte
- $c = 0, d = 1$: previsão de longo prazo $\rightarrow$ cte $\neq 0$
- $c = 0, d = 2$: previsão de longo prazo $\rightarrow$ linha reta
- $c \neq 0, d = 0$: previsão de longo prazo $\rightarrow$ média dos dados
- $c \neq 0, d = 1$: previsão de longo prazo $\rightarrow$ linha reta
- $\cancel{c \neq 0, d = 2}$: previsão de longo prazo $\rightarrow$ função quadrática, ruim

<br>

As bibliotecas que ajustam os modelos fazem estimação por máxima verossimilhança, **MLE**.

Normalmente a seleção de melhor modelo é feita com base no **AIC** e **BIC**, que são critérios de informação que penalizam modelos com muitos parâmetros.

$\text{AIC} = -2 \log (L) + 2(p+q+k+1)$

$\text{BIC} = \text{AIC} + [\log (T) - 2](p+q+k+1)$

Como para $\log(T) > 2$ o termo $[\log (T) - 2]$ é positivo, o BIC penaliza mais modelos com muitos parâmetros, i.e., tende a escolher modelos mais simples.

<br>

- $\text{ARIMA(0, d, 0)}$
- $\text{ARIMA(1, d, 0)}$
- $\text{ARIMA(0, d, 1)}$
- $\text{ARIMA(2, d, 2)}$