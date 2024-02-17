#### Data: 25/09/2023

**Modelos autorregressivos (SARIMA)**

Modelo de regressão linear da própria observação, mas para períodos passados. A diferença é que há uma forte dependência entre as covariáveis, que geralmente não existe em modelos de regressão linear. Continuamos assumindo que a série é estacionária.

Chamamos de $\text{AR}(p)$:

$$
y_t = c + \phi_1 y_{t-1} + \phi_2 y_{t-2} + \cdots + \phi_p y_{t-p} + \epsilon_t, \quad \epsilon_t \sim \text{WN}(0, \sigma^2)
$$

$\rightarrow$ Para $\text{AR}(1)$: $y_t = c + \phi_1 y_{t-1} + \epsilon_t$

$\phi_1 = 0, c = 0 \implies \text{ruído branco}$
$\phi_1 = 0, c = 0 \implies \text{random walk}$
$\phi_1 = 1, c \neq 0 \implies \text{random walk with drift}$
$\phi_1 < 0 \implies \text{oscilar ao redor da média}$

**Restrições**

Para $\text{AR}(1)$: $-1 < \phi_1 < 1$
Para $\text{AR}(2)$: $-1 < \phi_2 < 1$, $\phi_1 + \phi_2 < 1$ e $\phi_2 - \phi_1 < 1$

Isso tende a ficar mais complicado para $p \geq 3$, mas normalmente pacotes que ajustam modelos AR já aplicam essas restrições.

**Média móvel de ordem $q$**

$$
y_t = c + \epsilon_t + \theta_1 \epsilon_{t-1} + \theta_2 \epsilon_{t-2} + \cdots + \theta_q \epsilon_{t-q}
$$

Ou seja, define $y_t$ como uma combinação linear de erros passados, uma função de erros de previsão passados. A média móvel de ordem $q$ é denotada por $\text{MA}(q)$.

Podemos escrever um modelo autorregressivo de ordem p como um modelo de média móvel de ordem infinita. E se impusermos algumas restrições paramétricas no modelo de média móvel, podemos escrever um modelo de média móvel de ordem $q$ como um modelo autorregressivo de ordem infinita.

$$
\begin{align*}
\text{Estacionário AR}(p) &\implies \text{MA}(\infty) \\
\underbrace{\text{ MA}(q)}_{\text{restrições paramétricas}} &\implies \text{AR}(\infty)
\end{align*}
$$

Vejamos:

$$
\begin{align*}
&\overbrace{y_t = \phi_1 y_{t-1} + \epsilon_t}^{\text{AR}(1)}\\
&y_t = \phi_1 (\phi_1 y_{t-2} + \epsilon_{t-1}) + \epsilon_t \\
&y_t = \phi_1^2 y_{t-2} + \phi_1 \epsilon_{t-1} + \epsilon_t \\
&\vdots \\
&y_t = \epsilon_t + \phi_1 \epsilon_{t-1} + \phi_1^2 \epsilon_{t-2} + \phi_1^3 \epsilon_{t-3} + \dots  \\
&\vdots \\
&\underbrace{y_t = \phi_1^k y_{t-k} + \phi_1^{k-1} \epsilon_{t-1} + \cdots + \phi_1 \epsilon_{t-k+1} + \epsilon_t}_{\text{MA}(\infty)}
\end{align*}
$$

Se o modelo não for estacionário, não consigo escrever ele de maneira razoável como um modelo de média móvel de ordem infinita. Por isso que sempre conseguimos escrever um processo finito de ordem p como um processo de média móvel de ordem infinita no caso estacionário.

$$
\overbrace{y_t = \epsilon_t + \theta_1 \epsilon_{t-1}}^{\text{MA}(1)} \\ 
\underbrace{\epsilon_t = \sum_{j=0}^{\infty} (-\theta_1)^j y_{t-j}}_{\text{AR}(\infty)}
$$

- $|\theta_1| > 1$: peso aumenta para valores passados, ou seja, dados distantes terão pesos maiores que dados recentes
- $|\theta_1| = 1$: todos os dados terão o mesmo peso
- $|\theta_1| < 1$: peso diminui para valores passados, ou seja, dados recentes terão pesos maiores que dados distantes

As restrições são importantes para criar modelos que fazem mais sentido para determinados propósitos.

**Técnicas de diferenciação**

Estabilizar a média dos dados, por exemplo, removendo tendência e sazonalidade.

**Diferenciação de primeira ordem para remover tendência:**

$$
y_t \prime = y_t - y_{t-1}
$$

Vamos dizer que $y_t$ é um passeio aleatório, i.e., $y_t + y_{t-1} + \epsilon_t, \epsilon_t \sim \mathcal{N}(0, \sigma^2)$. Trata-se de um processo não estacionário, já que $\phi = 1$.

$$
\begin{align*}
y_t \prime &= y_t - y_{t-1} \\
&= \epsilon_t \sim \mathcal{N}(0, \sigma^2)
\end{align*}
$$

Pegamos um processo não estacionário e ao aplicarmos uma diferença, tornamos ele um processo estacionário. Isso tende a remover tendência da série.

Na diferenciação de segunda ordem, aplicamos outra vez a diferença na série já diferenciada uma vez:

$$
\begin{align*}
y_t \prime \prime &= y_t \prime - y_{t-1} \prime \\
&= y_t - 2 y_{t-1} + y_{t-2}
\end{align*}
$$

Outra coisa comum é aplicar **diferenciação para remover sazonalidade**. Por exemplo, se a série for mensal, podemos aplicar uma diferença de 12 meses para remover sazonalidade anual.

$$
y_t^{(m)} = y_t - y_{t-m}, \quad m = \text{período}
$$

Sendo $y_t = y_{t-m} + \epsilon_t, \epsilon_t \sim \text{WN}(0, \sigma^2)$, seasonal naive, temos:

$$
\begin{align*}
y_t^{(m)} &= y_t - y_{t-m} \\
&= \epsilon_t \sim \text{WN}(0, \sigma^2)
\end{align*}
$$

Quando queremos remover tendência e sazonalidade, aplicamos uma diferença de primeira ordem e uma diferença de m-ordem. **Normalmente é aconselhável aplicar primeiro a diferença sazonal e depois a diferença de primeira ordem, embora matematicamente não faça diferença.** Ao remover a sazonalidade já podemos remover uma parte da tendência, podendo não ser necessário aplicar a diferença de primeira ordem.

$\rightarrow$ **Backshift notation**

Definição com essas propriedades:

$$
\begin{align*}
&B y_t &= y_{t-1} \\
&B (B y_t) = B^2 y_t  &= y_{t-2} \\
&\vdots \\
&B^k y_t &= y_{t-k}
\end{align*}
$$

$B$ é uma operação algébrica que aplicada em $y_t$ retorna $y_{t-1}$.

$$
\begin{align*}
y_t \prime &= y_t - y_{t-1} \\
&= (1 - B) y_t
\end{align*}
$$

$$
\begin{align*}
y_t \prime \prime& = y_t \prime - y_{t-1} \prime \\
&= (1 - B) y_t \prime \\
&= (1 - B)^2 y_t
\end{align*}
$$

Para remover tendência, fazemos:

$$
\begin{align*}
y_t \prime &= (1 - B) y_t \\
y_t \prime \prime &= (1 - B)^2 y_t \\
\end{align*}
$$

Para remover sazonalidade, fazemos:

$$
\begin{align*}
y_t^{(m)} &= y_t - y_{t-m} \\
&= (1 - B^m) y_t
\end{align*}
$$

Aplicando os dois, a notação fica:

$$
y_t \prime^{(m)} = (1 - B^m) (1 - B) y_t
$$