# FIAP: Pós Tech - Software Architecture

[![FIAP Pós Tech](https://postech.fiap.com.br/imgs/imgshare.png)](https://postech.fiap.com.br/?gad_source=1&gclid=Cj0KCQjwhfipBhCqARIsAH9msbmkyFZTmYIBomPCo-sGkBPLiiZYAkvTmM1Kx-QjwmYs3_NhyPKvP44aAtdZEALw_wcB)

## Objetivo do projeto
Gerenciar a infraestrutura necessária para os seguintes projetos:
* [Produto](https://github.com/pos-4soat/fastfood-products).
* [Pedido](https://github.com/pos-4soat/fastfood-orders).
* [Pagamento](https://github.com/pos-4soat/fastfood-payment).
* [Produção](https://github.com/pos-4soat/fastfood-production).
* [Lambda](https://github.com/pos-4soat/fastfood-auth).

## Como usar
É necessário ter uma conta no terraform, um workspace criado, devidas configurações de usuário e adicionar as *Workspace variables* no workspace relacionadas a AWS, que são as seguintes:
* AWS_ACCESS_KEY_ID 
* AWS_SECRET_ACCESS_KEY

Necessário também configurar no GitHub as *Secrets and variables*, entrando em *Actions* e adicionando na parte *Repository secrets* a seguinte:
* TF_API_TOKEN (token gerado pelo terraform para conseguir integrar)

Esse repositório tem um workflow que no momento de criar um pull request, irá criar um speculative plan no terraform não sendo possível aplicar, ao realizar o merge irá realizar um plan e deixará possível ser aplicado manualmente pelo terraform.
Não está aplicando automaticamente pois como envolve custos, seria perigoso subir algo sem querer e atribuir custos desnecessários.
Como toda a infraestrutura está nesse projeto alguns recursos dependem de recursos deployados em outros repositórios, como é o caso da lambda depender da imagem disponível no ECR

### Run 1
Necessário acessar as variables.tf da pasta root e colocar o valor da variável create_lambda como false, fazendo isso é possível aplicar a run inicial.

ATENÇÃO:
* create_lambda = false

### Run 2
Para essa funcionar corretamente é necessário alterar o create_lambda para true e também atualizar os values das variáveies *production_uri_lb*, *products_uri_lb*, *order_uri_lb* e *payment_uri_lb*, sendo esse o valor do DNS Name do load balancer que foi criado para cada no workflow dos repositórios.

ATENÇÃO:
* create_lambda = true
* production_uri_lb com valor do DNS Name do load balancer de produção
* products_uri_lb com valor do DNS Name do load balancer de produtos
* order_uri_lb com valor do DNS Name do load balancer de pedidos
* payment_uri_lb com valor do DNS Name do load balancer de pagamento
