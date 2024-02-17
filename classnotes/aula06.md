#### Data: 30/08/2023

$\Rightarrow$ **DECOMPOSIÇÃO DE SÉRIES TEMPORAIS**

$$
y_t = \underbrace{S_t}_{\text{sazonalidade}} + \underbrace{T_t}_{\text{tendência}} + \underbrace{R_t}_{\text{remain}}
$$

Se fôssemos fazer isso na mão, como seria?

**Passo 1:** estimar a tendência

$$
T_t = \hat{m}_t = \underbrace{\dfrac{0.5 x_{t-q} + x_{t-q+1} + \dots + x_{t+q-1} + 0.5 x_{t+q}}{d}}_{\text{média móvel centrada, uma das formas de estimar } T_t},
$$

onde $d$ é o período da sazonalidade e $q$ é o número de pontos à esquerda e à direita do ponto $t$.

Quando $d$ é par, não conseguimos pegar o período de forma simétrica. Um jeito de fazer isso para não deixar ninguém de fora é dar metade do peso para cada uma das pontas. Por exemplo, se $d = 4$, temos $q = 2$ e $T_t = \dfrac{0.5 x_{t-2} + x_{t-1} + x_{t+1} + 0.5 x_{t+2}}{4}$.

A média móvel é uma forma simples de retirar a tendência.

**Passo 2:** estimar o componente sazonal

Removemos a tendência para calcular a sazonalidade:

$$
\begin{align*}
w_k = \{(x_{k + j d} - \hat{m}_{k + j d})\}, \ &q < k+ j 
d < n - q \\
& k = 1, \dots, d
\end{align*}
$$

$j$ é o número de períodos completos (o elemento "circular"). $k$ é o número de pontos dentro de um período. $w_k$ é a média dos pontos dentro de um período. $d$ é o período da sazonalidade.

Importante tirar a média dos $w_k$, por exemplo:

$$
\begin{align*}
w_1 &= x_{1 + 0 \times 12} = x_1 - m_1 \\
&= x_{1 + 1 \times 12} = x_{13} - m_{13} \\
\end{align*}
$$

Nesse caso, tiraríamos a média entre os dois valores de $w_1$.

Para garantir que a média do componente sazonal seja centrada em zero, fazemos:

$$
\begin{align*}
\hat{S}_k &= w_k - d^{-1} \sum_{i=1}^d w_i, \ k = 1, \dots, d \\
\hat{S}_k &= \hat{S}_{k-d}, k > d
\end{align*}
$$

Agora que calculamos a média móvel (tendência) para estimar o componente sazonal, podemos tirar a sazonalidade da série (de-sazonalizá-la):

$$
\begin{align*}
&d_t = x_t - \hat{S}_t, \\
&\text{e podemos modelar a série original como: } y_t = \hat{S}_k + \underbrace{A_k}_{T_t + R_t}
\end{align*}
$$

Ajustamos um modelo na série de-sazonalizada e depois adicionamos a sazonalidade de volta, embora a incerteza não seja incorporada nessa soma (já que as coisas não são estimadas ao mesmo tempo).
