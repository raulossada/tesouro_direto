

# Cálculo

Inicialmente eu decido comprar um **Título Prefixado**.

Assim, decido investir um certo valor, numa certa data.


```r
> # Tesouro Prefixado 2020 (LTN)	01/01/2020	8,92	R$32,51	R$812,88
> # Tesouro Prefixado 2023 (LTN)	01/01/2023	9,96	R$35,88	R$598,14
> 
> # Valor Investido
> valor_investido <- 598.14;
> 
> # Data da Compra
> data_compra <- "2017-07-25";
```

O título que eu decidi comprar possui uma **Taxa de Rendimento** e uma **Data de Vencimento**.


```r
> # Taxa de Rendimento do Papel na Compra (%a.a.)
> taxa_rendimento <- 9.96/100;
> 
> # Data do Vencimento
> data_vencimento <- "2023-01-01";
```

Agora, suponha que eu decida resgatar o título apenas na data de vencimento.


```r
> library("bizdays");
> 
> # Cria o calendário
> 
> create.calendar(name="Brazil/ANBIMA", 
+                 holidays=holidaysANBIMA, 
+                 weekdays=c("saturday", "sunday") );
> 
> qt_dias_uteis <- bizdays(from=data_compra, to=data_vencimento, cal="Brazil/ANBIMA");
> 
> resgate_valor_bruto <- valor_investido * (1 + taxa_rendimento)^(qt_dias_uteis/252);
> resgate_valor_bruto <- round(x=resgate_valor_bruto, digits=0);
```

Assim o valor bruto que irei receber é de R$ 1000

## Taxa de Custódia

Porém, nem tudo são flores. Ou seja, eu preciso pagar algumas taxas.

E uma das taxas que eu preciso pagar é a **Taxa de Custódia**.


```r
> taxa_custodia <- 0.3/100;
> 
> dataMais2 <- as.Date(x=data_compra, format="%Y-%m-%d")+2;
> dataMais2 <- as.character(dataMais2);
> 
> qt_dias_corridos2 <- bizdays(from=dataMais2, to=data_vencimento, cal="actual");
> 
> valor_custodia <- taxa_custodia * ( (qt_dias_corridos2)/365 ) * 
+   (valor_investido + resgate_valor_bruto)/2;
> valor_custodia <- round(x=valor_custodia, digits=2);
```

Assim o valor referente à taxa de custódia que eu vou ter que pagar será de R$ 13.03

## Diferença Bruta

A diferença bruta será:


```r
> diferenca_bruta <- resgate_valor_bruto - valor_investido;
```

## Imposto de Renda


```r
> ir <- (diferenca_bruta - valor_custodia) * (0.15);
> ir <- round(x=ir, digits=2);
```

O valor do imposto de renda que eu vou precisar pagar será de R$ 58.32

## Rendimento Líquido

Após descontar os impostos e taxas temos que o rendimento líquido será:


```r
> rendimento_liquido <- diferenca_bruta - valor_custodia - ir;
```

Valor líquido do rendimento: R$ 330.51

## Valor Líquido do Resgate


```r
> resgate_valor_liquido <- valor_investido + rendimento_liquido;
```

Valor líquido do resgate: R$ 928.65

## Taxa de Rendimento Líquida


```r
> taxa_rendimento_liquida <- ( (resgate_valor_liquido / valor_investido)^(252/qt_dias_uteis) 
+                              ) - 1;
> 
> taxa_rendimento_liquida <- taxa_rendimento_liquida * 100;
> 
> taxa_rendimento_liquida <- round(x=taxa_rendimento_liquida, digits=2);
```

Taxa de rendimento líquida: 8.47% a.a.


***

## Taxa de administração 1

1o. O valor da administração na entrada


```r
> taxa_admin <- 0.5/100;
> 
> valor_admin_entrada <- valor_investido * taxa_admin;
> valor_admin_entrada <- round(x=valor_admin_entrada, digits=2);
```

Valor da administração na entrada: R$ 2.99

## Taxa de administração 2

1o. O valor da administração no resgate


```r
> valor_admin_resgate <- taxa_admin * ( (qt_dias_corridos2-365)/365 ) * ( (valor_investido+valor_admin_entrada+resgate_valor_bruto)/2 );
```

Valor da administração no resgate: R$ 17.7549964

## Rendimento Líquido 2

Após descontar os impostos e taxas temos que o rendimento líquido será:


```r
> rendimento_liquido <- diferenca_bruta - valor_custodia - ir - valor_admin_resgate;
```

Valor líquido do rendimento: R$ 312.7550036

## Valor Líquido do Resgate 2


```r
> resgate_valor_liquido <- valor_investido + rendimento_liquido;
```

Valor líquido do resgate: R$ 910.8950036







