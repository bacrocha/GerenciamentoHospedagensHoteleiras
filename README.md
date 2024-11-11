# Sistema de Gerenciamento de Hospedagens Hoteleiras 🏨

Este projeto foi desenvolvido como parte da matéria de Banco de Dados II durante a minha graduação em Engenharia de Software. Com foco em práticas de modelagem e manipulação de dados utilizando o MySQL, o objetivo do sistema é centralizar e otimizar o gerenciamento de informações de hotéis, quartos, clientes e hospedagens.

## 📑 Índice

- [Objetivo do Projeto](#-objetivo-do-projeto)
- [Estrutura do Banco de Dados](#-estrutura-do-banco-de-dados)
- [Funcionalidades Implementadas](#-funcionalidades-implementadas)
- [Consultas SQL](#-consultas-sql)
- [Procedimentos e Funções com PLMySQL](#-procedimentos-e-funções-com-plmysql)
- [Triggers](#-triggers)
- [Telas de Saída](#-telas-de-saída)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Resultados e Conclusão](#-resultados-e-conclusão)
- [Nota Final](#-nota-final)
- [Autora](#-autora)

## 🎯 Objetivo do Projeto

O sistema visa centralizar e simplificar o gerenciamento de reservas, dados de clientes, quartos e histórico de hospedagem, aplicando conceitos fundamentais de banco de dados, como:
- **Modelagem de dados**: criação de um Diagrama Entidade-Relacionamento (DER) para identificar entidades e relacionamentos.
- **Estruturação de tabelas e relacionamentos**: tabelas para armazenar informações de clientes, reservas e quartos, com implementação de relacionamentos específicos.
- **Consultas SQL**: desenvolvimento de queries para gerar relatórios e extrair informações relevantes.

## 🏛️ Estrutura do Banco de Dados

O sistema foi projetado para armazenar informações detalhadas das entidades a seguir:

- **Tabela “Hotel”**: Armazena informações dos hotéis, como ID, nome, cidade, estado (UF) e classificação em estrelas.
- **Tabela “Quarto”**: Armazena dados dos quartos, incluindo ID, ID do hotel ao qual pertence, número, tipo e preço da diária.
- **Tabela “Cliente”**: Contém dados dos clientes, como ID, nome, email, telefone e CPF.
- **Tabela “Hospedagem”**: Guarda os registros de hospedagens, incluindo ID, ID do cliente, ID do quarto, datas de check-in e check-out, valor total e status da hospedagem (reserva, hospedado, finalizada, cancelada).

## ⚙️ Funcionalidades Implementadas

1. **Cadastro de Clientes**: Inserção e atualização de dados dos clientes.
2. **Gerenciamento de Quartos**: Controle de tipos, disponibilidade e preços dos quartos.
3. **Reserva e Check-in/Check-out**: Registro de reservas e monitoramento do status da hospedagem.
4. **Consultas e Relatórios**: Consultas SQL para fornecer insights, como reservas ativas e histórico de hóspedes.

## 🔍 Consultas SQL

As consultas incluem:
- **Listar hotéis e seus quartos**: Exibir informações do hotel e dados dos quartos.
- **Clientes com hospedagens finalizadas**: Mostrar clientes e histórico de quartos e hotéis com status finalizado.
- **Histórico de hospedagens por cliente**: Listar hospedagens em ordem cronológica para um cliente específico.
- **Cliente com mais hospedagens**: Identificar o cliente com o maior número de hospedagens.
- **Clientes com hospedagens canceladas**: Listar clientes com reservas canceladas e seus detalhes.
- **Receita total por hotel**: Calcular receita de hospedagens finalizadas por hotel.
- **Clientes com reservas em hotel específico**: Mostrar clientes que já reservaram um hotel em particular.
- **Gasto total por cliente em hospedagens finalizadas**: Exibir clientes e valores totais gastos.
- **Quartos nunca utilizados**: Listar quartos sem registros de hospedagens.
- **Média de preços das diárias por tipo de quarto**: Calcular a média dos preços das diárias por tipo de quarto.

## 🔧 Procedimentos e Funções com PL/MySQL

Foram criados procedimentos e funções para automatizar operações e consultas:

- **Procedures**:
  - `RegistrarCheckIn`: Atualiza a data de check-in e o status para “hospedado”.
  - `CalcularTotalHospedagem`: Calcula o valor total com base nos dias de estadia e preço da diária.
  - `RegistrarCheckout`: Atualiza a data de check-out e define o status como “finalizada”.
  
- **Functions**:
  - `TotalHospedagensHotel`: Retorna o número total de hospedagens em um hotel específico.
  - `ValorMedioDiariasHotel`: Calcula o valor médio das diárias de um hotel.
  - `VerificarDisponibilidadeQuarto`: Verifica a disponibilidade de um quarto para uma data específica.

## ⚡ Triggers

- **AntesDeInserirHospedagem**: Trigger que verifica a disponibilidade do quarto antes de inserir uma nova hospedagem.
- **AposDeletarCliente**: Trigger que registra a exclusão de um cliente em uma tabela de log.

## 🖥️ Telas de Saída

Para atender ao escopo do projeto de Banco de Dados II da minha faculdade, foram solicitadas as seguintes telas de saída, que têm como objetivo proporcionar uma interface clara e funcional para a interação com o sistema de gerenciamento de hospedagens hoteleiras. Cada tela foi projetada para atender a uma necessidade específica do sistema, garantindo que os usuários possam realizar operações como cadastro de clientes, gerenciamento de quartos, reserva de hospedagens e geração de relatórios. As telas solicitadas são as seguintes:

- **A**: Tela para cadastro de clientes, onde são inseridos dados como nome, e-mail, telefone e CPF.
- **B**: Mensagem de sucesso ou erro no cadastro de cliente, indicando se a operação foi realizada corretamente ou se houve algum problema.
- **C**: Relatório de quartos cadastrados, exibindo informações sobre os quartos disponíveis no sistema, como número, tipo e preço.
- **D**: Mensagem de erro ou confirmação ao tentar remover ou alterar dados de um quarto, fornecendo feedback sobre o sucesso ou falha da operação.
- **E**: Tela para exibir o status de reservas e informações de check-in, mostrando as reservas feitas e seus detalhes.
- **F**: Tela para confirmação de check-out, incluindo cálculo de valores a pagar, com a finalização da hospedagem.
- **G**: Relatório de reservas por cliente, que apresenta um histórico das hospedagens realizadas por cada cliente.
- **H**: Relatório de receita por hotel, exibindo o total gerado de receitas pelas hospedagens realizadas.
- **I**: Tela mostrando o resultado da execução de funções, como a verificação da disponibilidade de um quarto para uma data específica.
- **J**: Mensagem de erro ao executar funções, quando os dados fornecidos não são válidos ou não atendem aos critérios necessários.
- **K**: Resultado da execução de uma trigger, como a inserção de uma nova hospedagem, mostrando o impacto da operação no banco de dados.
- **L**: Notificação de exclusão de cliente via trigger, informando que o cliente foi removido e os dados relacionados foram processados.

Essas telas são fundamentais para garantir que o sistema atenda às necessidades dos usuários e forneça uma experiência interativa, facilitando a gestão de informações e operações no sistema de gerenciamento de hospedagens hoteleiras.

## 🛠️ Tecnologias Utilizadas

- **MySQL**: Para desenvolvimento do banco de dados relacional e execução de consultas SQL.
- **Workbench/MySQL CLI**: Ferramentas de administração e desenvolvimento SQL.

## 📊 Resultados e Conclusão

Este projeto proporcionou a oportunidade de aplicar conceitos de banco de dados de forma prática e abrangente, reforçando habilidades em modelagem de dados, manipulação de SQL e automação com PL/MySQL. Essas experiências ampliaram minha compreensão sobre o gerenciamento de dados, preparando-me para desafios do mercado de trabalho.

## 🎓 Nota Final

Obtive a nota máxima neste projeto, o que reafirma minha dedicação e interesse na área de banco de dados dentro da Engenharia de Software.

## 👩‍💻 Autora

Este projeto foi desenvolvido por **Bárbara Rocha**, estudante do curso de Engenharia de Software da Unicesumar. O projeto foi realizado como parte da matéria de Banco de Dados II, com o intuito de aplicar e aprofundar os conhecimentos adquiridos sobre modelagem e manipulação de dados utilizando o MySQL.