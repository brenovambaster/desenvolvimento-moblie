# Projeto de Estudo com Flutter

Este projeto é um aplicativo de estudo em Flutter, com foco em implementar as melhores práticas de desenvolvimento, como o SOLID, Domain-Driven Design (DDD) e a Arquitetura Limpa (Clean Architecture).

O objetivo principal é demonstrar uma estrutura de código organizada e escalável, onde as responsabilidades de cada parte da aplicação estão claramente definidas e desacopladas.

# 1. Arquitetura do Projeto

A aplicação está dividida em três camadas principais:

*   **Apresentação (presentations):** A "face" da aplicação, responsável por tudo que o usuário vê e interage.
*   **Domínio (domain):** O coração do projeto, onde a lógica de negócio reside, independente da interface ou da fonte de dados.
*   **Dados (data):** A camada de implementação, que lida com a persistência de dados em fontes externas.

# 2. Responsabilidades de Cada Camada

## Camada de Apresentação

Esta camada é composta pelos seguintes componentes:

*   **Widgets:** A interface de usuário (UI) construída com widgets do Flutter. Eles são "burros", ou seja, apenas exibem o que o estado dita e disparam eventos para o BLoC.
*   **BLoC (Business Logic Component):** O gerenciador de estado da aplicação. Ele recebe eventos da UI, executa a lógica de negócio (via Usecases) e emite estados para a UI, que se redesenha de acordo.
*   **Events:** Classes que representam as intenções ou ações do usuário na UI (ex: `AddTodoEvent`, `LoadTodosEvent`).
*   **States:** Classes que representam os diferentes estados que a UI pode ter (ex: `TodoLoading`, `TodosLoaded`, `TodoError`).

## Camada de Domínio

Esta camada é totalmente independente e contém a essência da aplicação.

*   **Entities:** Objetos de dados puros que representam os conceitos de negócio. Eles são a linguagem comum de todo o projeto (ex: `TodoEntity`). São imutáveis.
*   **Usecases:** Classes que encapsulam uma única operação de negócio. Eles orquestram as ações e garantem que as regras de negócio sejam seguidas (ex: `AddTodoUseCase`, `DeleteTodoUseCase`).
*   **Repositories (Interfaces):** Contratos que a camada de domínio define para a camada de dados. Eles especificam o que deve ser feito (ex: `abstract class TodoRepository { Future<List<TodoEntity>> getTodos(); }`).

## Camada de Dados

Esta camada é responsável por implementar os contratos definidos na camada de Domínio.

*   **Models:** Objetos de dados que representam a estrutura dos dados na fonte externa (ex: um JSON de uma API ou uma linha de uma tabela do sqflite). Eles são responsáveis pela conversão dos dados (ex: `TodoModel.fromMap`).
*   **Data Sources:** Contratos que definem a interação com a fonte de dados (ex: `abstract class TodoRemoteDataSource`).
*   **Implementations:** As classes que implementam os Data Sources para uma tecnologia específica (ex: `TodoRemoteDataSourceSqflite`).
*   **Repositories (Implementações):** A ponte entre as camadas. Elas implementam o `TodoRepository` da camada de domínio e usam o Data Source para se comunicar com o sqflite.

# 3. Interfaces entre as Camadas

A comunicação entre as camadas é feita exclusivamente através de contratos (interfaces) e objetos de dados (Entities).

*   **Apresentação & Domínio:** A camada de Apresentação (BLoC) interage com a camada de Domínio chamando os Usecases. O BLoC só conhece a Usecase e a Entity do domínio, nada sobre o repositório ou o banco de dados.
*   **Domínio & Dados:** A camada de Domínio (Usecases) interage com a camada de Dados através do Repository. O Usecase só conhece a interface do Repository e lida com Entities. A implementação do Repository traduz as Entities em Models e usa o Data Source para se comunicar com o sqflite.

# 4. Princípios e Padrões Aplicados

*   **Injeção de Dependência:** As dependências são injetadas em tempo de execução, permitindo que a aplicação troque facilmente a fonte de dados (por exemplo, de um mock para o sqflite) sem modificar a lógica de negócio. A classe `TodoInjection` centraliza essa configuração.
*   **Imutabilidade:** Os objetos de estado (Entities e States) são imutáveis, o que evita efeitos colaterais inesperados e torna o gerenciamento de estado mais seguro.
*   **Single Responsibility Principle (SRP):** Cada classe tem uma única responsabilidade bem definida. O `TodoBloc` gerencia o estado, o `AddTodoUseCase` adiciona uma tarefa, e o `TodoRemoteDataSourceSqflite` interage com o sqflite.

Este projeto é um excelente ponto de partida para entender como construir aplicações Flutter robustas e escaláveis.
