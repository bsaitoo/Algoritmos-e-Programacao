algoritmo "desafio"
// Disciplina  : Algoritmo e Lógica de Programação 
// Professor   : André Olímpio 
// Desafio 1° bimestre - ArenaCode

const
   MAX_EQUIPES = 10
   PONTOS_VITORIA = 3
   PONTOS_EMPATE = 1
   PONTOS_DERROTA = 0

tipo
   TEquipe = registro
      codigo: inteiro
      nome: caractere
      capitao: caractere
      vitorias: inteiro
      empates: inteiro
      derrotas: inteiro
      pontosMarcados: inteiro
      pontosSofridos: inteiro
      saldo: inteiro
      pontosCampeonato: inteiro
   fimregistro

var
   equipes: vetor[1..MAX_EQUIPES] de TEquipe
   matrizConfrontos: vetor[1..MAX_EQUIPES,1..MAX_EQUIPES] de inteiro
   quantidadeEquipes, totalPartidas: inteiro
   opcao: inteiro

funcao localizarEquipe(cod: inteiro): inteiro
var
   i, localizarEquipe: inteiro
inicio
   localizarEquipe <- 0

   para i de 1 ate quantidadeEquipes faca
      se equipes[i].codigo = cod entao
         localizarEquipe <- i
      fimse
   fimpara
fimfuncao

funcao calcularSaldo(marcados, sofridos: inteiro): inteiro
var
   calcularSaldo: inteiro
inicio
   calcularSaldo <- marcados - sofridos
fimfuncao

funcao calcularPontuacao(vit, emp: inteiro): inteiro
var
   calcularPontuacao: inteiro
inicio
   calcularPontuacao <- (vit * PONTOS_VITORIA) + (emp * PONTOS_EMPATE)
fimfuncao

procedimento inicializarSistema
var
   i, j: inteiro
inicio
   quantidadeEquipes <- 0
   totalPartidas <- 0
   para i de 1 ate MAX_EQUIPES faca
      para j de 1 ate MAX_EQUIPES faca
         matrizConfrontos[i,j] <- 0
      fimpara
   fimpara
fimprocedimento

procedimento mostrarEquipe(indice: inteiro)
inicio
   escreval("")
   escreval("Codigo: ", equipes[indice].codigo)
   escreval("Equipe: ", equipes[indice].nome)
   escreval("Capitao: ", equipes[indice].capitao)
   escreval("Vitorias: ", equipes[indice].vitorias)
   escreval("Empates: ", equipes[indice].empates)
   escreval("Derrotas: ", equipes[indice].derrotas)
   escreval("Pontos marcados: ", equipes[indice].pontosMarcados)
   escreval("Pontos sofridos: ", equipes[indice].pontosSofridos)
   escreval("Saldo de pontos: ", equipes[indice].saldo)
   escreval("Pontos no campeonato: ", equipes[indice].pontosCampeonato)
fimprocedimento

procedimento cadastrarEquipe
var
   codigoNovo, indice, i, existeCodigo: inteiro
   nomeNovo, capitaoNovo: caractere
inicio
   se quantidadeEquipes >= MAX_EQUIPES entao
      escreval("Limite maximo de equipes atingido!")
   senao
      escreval("")
      escreval("=== CADASTRO DE EQUIPE ===")
      escreva("Informe um codigo inteiro positivo: ")
      leia(codigoNovo)

      existeCodigo <- 0
      para i de 1 ate quantidadeEquipes faca
         se equipes[i].codigo = codigoNovo entao
            existeCodigo <- 1
         fimse
      fimpara

      enquanto (codigoNovo <= 0) ou (existeCodigo = 1) faca
         se codigoNovo <= 0 entao
            escreva("Codigo invalido. Digite um valor positivo: ")
         senao
            escreva("Esse codigo ja existe. Informe outro codigo: ")
         fimse
         leia(codigoNovo)

         existeCodigo <- 0
         para i de 1 ate quantidadeEquipes faca
            se equipes[i].codigo = codigoNovo entao
               existeCodigo <- 1
            fimse
         fimpara
      fimenquanto

      escreva("Nome da equipe: ")
      leia(nomeNovo)
      enquanto nomeNovo = "" faca
         escreva("O nome nao pode ficar vazio. Digite novamente: ")
         leia(nomeNovo)
      fimenquanto

      escreva("Nome do capitao: ")
      leia(capitaoNovo)
      enquanto capitaoNovo = "" faca
         escreva("O nome do capitao nao pode ficar vazio. Digite novamente: ")
         leia(capitaoNovo)
      fimenquanto

      quantidadeEquipes <- quantidadeEquipes + 1
      indice <- quantidadeEquipes

      equipes[indice].codigo <- codigoNovo
      equipes[indice].nome <- nomeNovo
      equipes[indice].capitao <- capitaoNovo
      equipes[indice].vitorias <- 0
      equipes[indice].empates <- 0
      equipes[indice].derrotas <- 0
      equipes[indice].pontosMarcados <- 0
      equipes[indice].pontosSofridos <- 0
      equipes[indice].saldo <- 0
      equipes[indice].pontosCampeonato <- 0

      escreval("Equipe cadastrada com sucesso!")
   fimse
fimprocedimento

procedimento listarEquipes
var
   i: inteiro
inicio
   escreval("")
   escreval("=== EQUIPES CADASTRADAS ===")
   se quantidadeEquipes = 0 entao
      escreval("Nenhuma equipe cadastrada.")
   senao
      para i de 1 ate quantidadeEquipes faca
         escreval("--------------------------------")
         escreval("Codigo: ", equipes[i].codigo, " | Nome: ", equipes[i].nome)
         escreval("Capitao: ", equipes[i].capitao)
         escreval("Pontos: ", equipes[i].pontosCampeonato, " | Vitorias: ", equipes[i].vitorias, " | Empates: ", equipes[i].empates, " | Derrotas: ", equipes[i].derrotas)
      fimpara
   fimse
fimprocedimento

procedimento consultarEquipe
var
   cod, indice, i: inteiro
inicio
   escreva("Digite o codigo da equipe que deseja consultar: ")
   leia(cod)

   indice <- 0

   para i de 1 ate quantidadeEquipes faca
      se equipes[i].codigo = cod entao
         indice <- i
      fimse
   fimpara

   se indice = 0 entao
      escreval("Equipe nao encontrada.")
   senao
      mostrarEquipe(indice)
   fimse
fimprocedimento

procedimento registrarPartida
var
   cod1, cod2, i1, i2, placar1, placar2, i: inteiro
inicio
   escreval("")
   escreval("=== REGISTRAR PARTIDA ===")
   se quantidadeEquipes < 2 entao
      escreval("Cadastre pelo menos duas equipes antes de registrar partidas.")
   senao

      escreva("Codigo da primeira equipe: ")
      leia(cod1)

      i1 <- 0
      para i de 1 ate quantidadeEquipes faca
         se equipes[i].codigo = cod1 entao
            i1 <- i
         fimse
      fimpara

      enquanto i1 = 0 faca
         escreva("Equipe nao encontrada. Informe outro codigo: ")
         leia(cod1)

         i1 <- 0
         para i de 1 ate quantidadeEquipes faca
            se equipes[i].codigo = cod1 entao
               i1 <- i
            fimse
         fimpara
      fimenquanto

      escreva("Codigo da segunda equipe: ")
      leia(cod2)

      i2 <- 0
      para i de 1 ate quantidadeEquipes faca
         se equipes[i].codigo = cod2 entao
            i2 <- i
         fimse
      fimpara

      enquanto (i2 = 0) ou (i2 = i1) faca
         se i2 = i1 entao
            escreva("Uma equipe nao pode jogar contra ela mesma. Outro codigo: ")
         senao
            escreva("Equipe nao encontrada. Informe outro codigo: ")
         fimse

         leia(cod2)

         i2 <- 0
         para i de 1 ate quantidadeEquipes faca
            se equipes[i].codigo = cod2 entao
               i2 <- i
            fimse
         fimpara
      fimenquanto
      
      se matrizConfrontos[i1,i2] <> 0 entao
         escreval("Essas equipes ja possuem um confronto registrado.")
         escreval("O sistema nao permite registrar o mesmo confronto duas vezes.")
      senao
         escreva("Pontos marcados pela primeira equipe: ")
         leia(placar1)
         enquanto placar1 < 0 faca
            escreva("A pontuacao nao pode ser negativa. Digite novamente: ")
            leia(placar1)
         fimenquanto

         escreva("Pontos marcados pela segunda equipe: ")
         leia(placar2)
         enquanto placar2 < 0 faca
            escreva("A pontuacao nao pode ser negativa. Digite novamente: ")
            leia(placar2)
         fimenquanto

         equipes[i1].pontosMarcados <- equipes[i1].pontosMarcados + placar1
         equipes[i1].pontosSofridos <- equipes[i1].pontosSofridos + placar2
         equipes[i2].pontosMarcados <- equipes[i2].pontosMarcados + placar2
         equipes[i2].pontosSofridos <- equipes[i2].pontosSofridos + placar1

         se placar1 > placar2 entao
            equipes[i1].vitorias <- equipes[i1].vitorias + 1
            equipes[i2].derrotas <- equipes[i2].derrotas + 1
            equipes[i1].pontosCampeonato <- equipes[i1].pontosCampeonato + PONTOS_VITORIA
            equipes[i2].pontosCampeonato <- equipes[i2].pontosCampeonato + PONTOS_DERROTA
            matrizConfrontos[i1,i2] <- 1
            matrizConfrontos[i2,i1] <- 2
            escreval("Resultado: vitoria de ", equipes[i1].nome, "!")
         senao
            se placar2 > placar1 entao
               equipes[i2].vitorias <- equipes[i2].vitorias + 1
               equipes[i1].derrotas <- equipes[i1].derrotas + 1
               equipes[i2].pontosCampeonato <- equipes[i2].pontosCampeonato + PONTOS_VITORIA
               equipes[i1].pontosCampeonato <- equipes[i1].pontosCampeonato + PONTOS_DERROTA
               matrizConfrontos[i1,i2] <- 2
               matrizConfrontos[i2,i1] <- 1
               escreval("Resultado: vitoria de ", equipes[i2].nome, "!")
            senao
               equipes[i1].empates <- equipes[i1].empates + 1
               equipes[i2].empates <- equipes[i2].empates + 1
               equipes[i1].pontosCampeonato <- equipes[i1].pontosCampeonato + PONTOS_EMPATE
               equipes[i2].pontosCampeonato <- equipes[i2].pontosCampeonato + PONTOS_EMPATE
               matrizConfrontos[i1,i2] <- 3
               matrizConfrontos[i2,i1] <- 3
               escreval("Resultado: empate!")
            fimse
         fimse

         equipes[i1].saldo <- calcularSaldo(equipes[i1].pontosMarcados, equipes[i1].pontosSofridos)
         equipes[i2].saldo <- calcularSaldo(equipes[i2].pontosMarcados, equipes[i2].pontosSofridos)
         equipes[i1].pontosCampeonato <- calcularPontuacao(equipes[i1].vitorias, equipes[i1].empates)
         equipes[i2].pontosCampeonato <- calcularPontuacao(equipes[i2].vitorias, equipes[i2].empates)
         totalPartidas <- totalPartidas + 1
         escreval("Partida registrada e estatisticas atualizadas.")
      fimse
   fimse
fimprocedimento

funcao vemAntes(a, b: inteiro): logico
var
   vemAntes: logico
inicio
   se equipes[a].pontosCampeonato > equipes[b].pontosCampeonato entao
      vemAntes <- verdadeiro
   senao
      se equipes[a].pontosCampeonato < equipes[b].pontosCampeonato entao
         vemAntes <- falso
      senao
         se equipes[a].vitorias > equipes[b].vitorias entao
            vemAntes <- verdadeiro
         senao
            se equipes[a].vitorias < equipes[b].vitorias entao
               vemAntes <- falso
            senao
               se equipes[a].saldo > equipes[b].saldo entao
                  vemAntes <- verdadeiro
               senao
                  se equipes[a].saldo < equipes[b].saldo entao
                     vemAntes <- falso
                  senao
                     vemAntes <- equipes[a].pontosMarcados > equipes[b].pontosMarcados
                  fimse
               fimse
            fimse
         fimse
      fimse
   fimse
fimfuncao

procedimento ordenarClassificacao
var
   i, j, k, auxiliarConfronto: inteiro
   auxiliar: TEquipe
inicio
   para i de 1 ate quantidadeEquipes - 1 faca
      para j de i + 1 ate quantidadeEquipes faca
         se vemAntes(j, i) entao
            auxiliar <- equipes[i]
            equipes[i] <- equipes[j]
            equipes[j] <- auxiliar

            para k de 1 ate quantidadeEquipes faca
               auxiliarConfronto <- matrizConfrontos[i,k]
               matrizConfrontos[i,k] <- matrizConfrontos[j,k]
               matrizConfrontos[j,k] <- auxiliarConfronto
            fimpara

            para k de 1 ate quantidadeEquipes faca
               auxiliarConfronto <- matrizConfrontos[k,i]
               matrizConfrontos[k,i] <- matrizConfrontos[k,j]
               matrizConfrontos[k,j] <- auxiliarConfronto
            fimpara
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento exibirClassificacao
var
   i: inteiro
inicio
   se quantidadeEquipes = 0 entao
      escreval("Ainda nao existem equipes cadastradas.")
   senao
      ordenarClassificacao
      escreval("")
      escreval("========== CLASSIFICACAO GERAL ==========")
      escreval("Pos. Equipe P    V    E    D    PM   PS   SG")
      para i de 1 ate quantidadeEquipes faca
         escreval(i, "     ", equipes[i].nome, "   ", equipes[i].pontosCampeonato, "   ", equipes[i].vitorias, "   ", equipes[i].empates, "   ", equipes[i].derrotas, "   ", equipes[i].pontosMarcados, "   ", equipes[i].pontosSofridos, "   ", equipes[i].saldo)
      fimpara
   fimse
fimprocedimento

procedimento exibirEstatisticas
var
   i, totalVitorias, totalEmpates, somaPontos: inteiro
   maiorVitorias, maiorPontuacao, maiorSaldo, maiorMarcados: inteiro
   indiceVitorias, indicePontuacao, indiceSaldo, indiceMarcados: inteiro
   mediaPontos: real
inicio
   escreval("")
   escreval("========== ESTATISTICAS DO CAMPEONATO ==========")
   escreval("Equipes cadastradas: ", quantidadeEquipes)
   escreval("Partidas realizadas: ", totalPartidas)

   totalVitorias <- 0
   totalEmpates <- 0
   somaPontos <- 0
   indiceVitorias <- 0
   indicePontuacao <- 0
   indiceSaldo <- 0
   indiceMarcados <- 0

   se quantidadeEquipes > 0 entao
      maiorVitorias <- equipes[1].vitorias
      maiorPontuacao <- equipes[1].pontosCampeonato
      maiorSaldo <- equipes[1].saldo
      maiorMarcados <- equipes[1].pontosMarcados
      indiceVitorias <- 1
      indicePontuacao <- 1
      indiceSaldo <- 1
      indiceMarcados <- 1

      para i de 1 ate quantidadeEquipes faca
         totalVitorias <- totalVitorias + equipes[i].vitorias
         totalEmpates <- totalEmpates + equipes[i].empates
         somaPontos <- somaPontos + equipes[i].pontosMarcados

         se equipes[i].vitorias > maiorVitorias entao
            maiorVitorias <- equipes[i].vitorias
            indiceVitorias <- i
         fimse
         se equipes[i].pontosCampeonato > maiorPontuacao entao
            maiorPontuacao <- equipes[i].pontosCampeonato
            indicePontuacao <- i
         fimse
         se equipes[i].saldo > maiorSaldo entao
            maiorSaldo <- equipes[i].saldo
            indiceSaldo <- i
         fimse
         se equipes[i].pontosMarcados > maiorMarcados entao
            maiorMarcados <- equipes[i].pontosMarcados
            indiceMarcados <- i
         fimse
      fimpara

      escreval("Vitorias contabilizadas pelas equipes: ", totalVitorias)
      escreval("Partidas empatadas: ", totalEmpates / 2)

      se totalPartidas > 0 entao
         mediaPontos <- somaPontos / totalPartidas
         escreval("Media de pontos marcados por partida (somando as duas equipes): ", mediaPontos:0:2)
      senao
         escreval("Media de pontos marcados por partida: ainda nao ha partidas.")
      fimse

      escreval("Mais vitorias: ", equipes[indiceVitorias].nome, " (", maiorVitorias, ")")
      escreval("Maior pontuacao no campeonato: ", equipes[indicePontuacao].nome, " (", maiorPontuacao, " pontos)")
      escreval("Maior saldo: ", equipes[indiceSaldo].nome, " (", maiorSaldo, ")")
      escreval("Mais pontos marcados: ", equipes[indiceMarcados].nome, " (", maiorMarcados, ")")
   senao
      escreval("Cadastre equipes para calcular as estatisticas.")
   fimse
fimprocedimento

procedimento consultarConfrontos
var
   i, j: inteiro
inicio
   escreval("")
   escreval("========== MATRIZ DE CONFRONTOS ==========")
   se quantidadeEquipes < 2 entao
      escreval("Cadastre pelo menos duas equipes para consultar confrontos.")
   senao
      escreval("Legenda: 0 = nao jogaram; 1 = linha venceu; 2 = coluna venceu; 3 = empate")
      para i de 1 ate quantidadeEquipes faca
         escreva(equipes[i].nome, ": ")
         para j de 1 ate quantidadeEquipes faca
            se i = j entao
               escreva("- ")
            senao
               escreva(matrizConfrontos[i,j], " ")
            fimse
         fimpara
         escreval("")
      fimpara
   fimse
fimprocedimento

procedimento contagemRegressiva(n: inteiro)
inicio
   // Caso-base: quando n chega a zero, a chamada recursiva termina.
   se n <= 0 entao
      escreval("CAMPEONATO INICIADO!")
   senao
      escreval(n, "...")
      contagemRegressiva(n - 1)
   fimse
fimprocedimento

procedimento executarRecursoRecursivo
inicio
   escreval("")
   escreval("=== CONTAGEM REGRESSIVA PARA O CAMPEONATO ===")
   contagemRegressiva(5)
fimprocedimento

inicio
   inicializarSistema
   repita
      escreval("")
      escreval("==========================================")
      escreval("       ARENACODE CHAMPIONSHIP")
      escreval("==========================================")
      escreval("1. Cadastrar equipe")
      escreval("2. Listar equipes")
      escreval("3. Registrar resultado de partida")
      escreval("4. Consultar equipe")
      escreval("5. Exibir classificacao geral")
      escreval("6. Exibir estatisticas do campeonato")
      escreval("7. Consultar confrontos")
      escreval("8. Executar recurso recursivo")
      escreval("9. Encerrar sistema")
      escreva("Escolha uma opcao: ")
      leia(opcao)

      escolha opcao
         caso 1
            cadastrarEquipe
         caso 2
            listarEquipes
         caso 3
            registrarPartida
         caso 4
            consultarEquipe
         caso 5
            exibirClassificacao
         caso 6
            exibirEstatisticas
         caso 7
            consultarConfrontos
         caso 8
            executarRecursoRecursivo
         caso 9
            escreval("Sistema encerrado. Obrigada por utilizar o ArenaCode Championship!")
         outrocaso
            escreval("Opcao invalida. Escolha uma opcao de 1 a 9.")
      fimescolha
   ate opcao = 9
fimalgoritmo
