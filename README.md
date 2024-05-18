# FIAP: P�s Tech - Software Architecture

[![FIAP P�s Tech](https://postech.fiap.com.br/imgs/imgshare.png)](https://postech.fiap.com.br/?gad_source=1&gclid=Cj0KCQjwhfipBhCqARIsAH9msbmkyFZTmYIBomPCo-sGkBPLiiZYAkvTmM1Kx-QjwmYs3_NhyPKvP44aAtdZEALw_wcB)

## Objetivo do projeto
Gerenciar a infraestrutura necess�ria para os seguintes projetos:
* [Produto](https://github.com/pos-4soat/fastfood-products).
* [Pedido](https://github.com/pos-4soat/fastfood-orders).
* [Pagamento](https://github.com/pos-4soat/fastfood-payment).
* [Produ��o](https://github.com/pos-4soat/fastfood-production).
* [Lambda](https://github.com/pos-4soat/fastfood-auth).

## Como usar
� necess�rio ter uma conta no terraform, um workspace criado, devidas configura��es de usu�rio e adicionar as *Workspace variables* no workspace relacionadas a AWS, que s�o as seguintes:
* AWS_ACCESS_KEY_ID 
* AWS_SECRET_ACCESS_KEY

Necess�rio tamb�m configurar no GitHub as *Secrets and variables*, entrando em *Actions* e adicionando na parte *Repository secrets* a seguinte:
* TF_API_TOKEN (token gerado pelo terraform para conseguir integrar)

Esse reposit�rio tem um workflow que no momento de criar um pull request, ir� criar um speculative plan no terraform n�o sendo poss�vel aplicar, ao realizar o merge ir� realizar um plan e deixar� poss�vel ser aplicado manualmente pelo terraform.
N�o est� aplicando automaticamente pois como envolve custos, seria perigoso subir algo sem querer e atribuir custos desnecess�rios.
Como toda a infraestrutura est� nesse projeto alguns recursos dependem de recursos deployados em outros reposit�rios, como � o caso da lambda depender da imagem dispon�vel no ECR

### Run 1
Necess�rio acessar as variables.tf da pasta root e colocar o valor da vari�vel create_lambda como false, fazendo isso � poss�vel aplicar a run inicial.

ATEN��O:
* create_lambda = false

### Run 2
Para essa funcionar corretamente � necess�rio alterar o create_lambda para true e tamb�m atualizar os values das vari�veies *production_uri_lb*, *products_uri_lb*, *order_uri_lb* e *payment_uri_lb*, sendo esse o valor do DNS Name do load balancer que foi criado para cada no workflow dos reposit�rios.

ATEN��O:
* create_lambda = true
* production_uri_lb com valor do DNS Name do load balancer de produ��o
* products_uri_lb com valor do DNS Name do load balancer de produtos
* order_uri_lb com valor do DNS Name do load balancer de pedidos
* payment_uri_lb com valor do DNS Name do load balancer de pagamento

## Diagrama dos recursos

![Diagrama](graph.png)
