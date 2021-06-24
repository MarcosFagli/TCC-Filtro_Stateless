# TCC
Filtro Stateless codificado em  Bluespec

O arquivo pdf da tese pode ser acessado na raiz do diretório ou através do link https://repositorio.ufscar.br/ (disponível em breve)

## Agradecimentos
Agradeço imensamente a todos os professores e técnicos adminstrativos da UFSCar, em especial ao professor Doutor Paulo Matias (https://github.com/thotypous) e ao seu aluno de doutorando Fabiano Losilla (https://github.com/logsilla) por toda supervisão neste trabalho. Agradeço também aos meus pais e amigos, que sempre estiveram comigo me incentivando e auxiliando em todos os momentos da minha vida.

## Resumo
Um dos pilares da segurança cibernética é o princípio do isolamento, e uma das principais formas de aplicar esse princípio a redes com endereços globalmente roteáveis é a filtragem de pacotes. Com o aumento da banda consumida pelas aplicações de rede, da quantidade de dispositivos conectados, e com a incidência cada vez maior de ataques de movimentação lateral, torna-se importante construir filtros de alto desempenho customizáveis e de baixo custo. Este trabalho propõe o desenvolvimento de um filtro stateless em FPGA. Os filtros stateless são programas que dada uma entrada (sequência de bits) retornam uma decisão, com base na correspondências ou não com critérios previamente definidos. A FPGA é um dispositivo que pode ser programado no nível de hardware e com isso é possível conseguir um melhor desempenho quando comparado a processadores de propósito geral, pois dependendo da forma que o circuito é implementado, pode-se chegar muito próximo a circuitos integrados de propósito específico. Assim, este trabalho começa pelo estudo de alguns protocolos tradicionais de rede, como o IPv4 e IPv6, identificando campos de interesse em cada um dos protocolos, como os endereços IP e MAC de origem e destino, a versão, o payload, comprimento do payload, checksum, dentre outros dados. Em seguida, o trabalho propõe um método para filtrar esses pacotes, inicialmente utilizando a lógica de bloqueio por padrão, assim qualquer pacote fora do padrão do filtro será descartado, permitindo-se explicitamente apenas alguns IPs e MACs de origem e destino. A importância de se trabalhar com filtragem de pacotes é justificada principalmente pela proteção de sistemas computacionais evitando possíveis invasões, visto que os ataques, quando remotos, ocorrem pela rede, assim, quanto mais eficiente o filtro, melhor poderá ser sua detecção e bloqueio de pacotes maliciosos. Assim, essa proposta, mesmo que protótipo inicial de filtro, utiliza dispositivos reconfiguráveis com interfaces mais velozes de conexão e desempenho superior a um custo menor que os dispositivos comerciais existentes atualmente.


## Execução e compilação

Para as compilações é necessário possuir o software Bluespec instalado, este será utilizado para as implementações e criação dos códigos em Verilog e posteriormente a criação do arquivo dump.vcd que será utilizado na simulação.

Para isso, basta seguir os tutoriais disponíveis em https://github.com/B-Lang-org/bsc.

Após a instalação do compilador Bluespec, basta seguir os seguintes comandos

Para a geração dos arquivos em Verilog, utilize o seguinte comando:
```
bsc -verilog -u TbIfc.bsv
```

Continue para a criação do tb (nome do arquivo executável) e então a criação do dump.vcd.

```
bsc -verilog -o tb -e mkTbIfc
./tb +bscvcd						
```

Para realizar as análises, utilize o GTKWave, disponível em http://gtkwave.sourceforge.net/. Basta abrir o programa e ler o arquivo dump.vcd disponível na pasta /Cod do repositório ou executar os passos acima.
