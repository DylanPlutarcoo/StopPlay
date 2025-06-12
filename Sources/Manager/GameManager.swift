// The Swift Programming Language
// https://docs.swift.org/swift-book

/*
 PLANEJAMENTO:
 - Entidades:
    Entidade jogador que precisa armazenar os pontos que o jogador vez
    Entidade resposta para controlar se a respota foi repetida ou não
 - Funcoes:
    func de sortear letra do abc, retorna um character - ok
    func de sortear categoria, recebe um array de strings e retorna 5 strings - ok
    func de ver se tem repetição nas palavras, pega o array de resposta de muda para true se for repetido e deixa false se for unico
    func de votação recebe um array de strings(respostas) na ordem, o jogador 1 vai ter as respostas de 1-5 e ... e retorna um array de bool
    func de calcular os pontos, eu recebo o array de bool que vem dos sorteios dai eu pego e como ele ta em ordem de index e player eu so dou os pontos para o player respectivo
    func de jogar partida, sorteia uma letra e uma categoria, recebe 2-8 jogadores, recebe 5 respostas do usuario e envia essas respostas para a func de votação, repete o processo 3 vezes, depois das 3 vezes retorna um array com a ordem de jogadores de acordo com quem acertou mais pontos

 
 */
import Foundation

class GameManager{
    /// Função para sortear a letra da rodada
    func randomLetter() -> Character {
        let letras = Array("ABCDEFGHIJKLMNOPQRSTUVXWYZ")
        return letras.randomElement()!
    }
    ///Função para sortear a categoria da rodada
    func randomCategorys() -> [String] {
        let categorys: [String] = [
            "Nome",
            "Animal",
            "Cor",
            "Comida",
            "Bebida",
            "Lugar",
            "Objeto",
            "Profissão",
            "Filme",
            "Série",
            "Livro",
            "Personagem Famoso",
            "Marca",
            "Esporte",
            "Time",
            "Ator/Atriz",
            "Cantor(a)",
            "Banda",
            "Palavra em Inglês",
            "Doença",
            "Partes do Corpo",
            "App ou Site",
            "Celebridade",
            "Jogo",
            "Instrumento Musical",
            "Estilo Musical",
            "Doces/Sobremesas",
            "Verbo",
            "Adjetivo",
            "Coisa de Praia",
            "Coisa de Festa",
            "Fulano é..."
        ]

        return Array(categorys.shuffled().prefix(5))
    }
    ///Função para ver se a resposta é repetida
    func isRepeated(respostas: [Response]) {
        
        var count: [String: [Response]] = [:]
        
        for resposta in respostas {
            count[resposta.texto, default: []].append(resposta)
        }
        for (_, answers) in count {
            if answers.count > 1 {
                for answer in answers {
                    answer.isRepeat = true
                }
            }
        }
    }
    ///Função para organizar para votação, na UI o ideal é retornar um [[Bool]]
    func prepareToVote(toBeVoted: [Response?]) -> [[Response?]] {
        let sizeGroup = toBeVoted.count / 5
        var groups: [[Response?]] = []
        
        for i in 0..<5 {
            let initial = i * sizeGroup
            let end = initial + sizeGroup
            let grupo = Array(toBeVoted[initial..<end])
            groups.append(grupo)
        }
        
        return groups
    }
    ///Função para calcular os pontos do jogador
    func calculatePoints(votos: [[Bool]], respostas: [Response], player: [Player]){
        var counter: Int = 0
        for resposta in respostas {
            if resposta.isRepeat && votos[counter].filter { $0 }.count > votos[counter].count / 2{
                player[counter].points = 10
                counter += 1
            } else {
                if votos[counter].filter({ $0 }).count > votos[counter].count / 2 {
                    player[counter].points = 5
                    counter += 1
                } else {
                    return
                }
            }
        }
    }
    ///Função para retornar o ranking de jogadores com mais pontos
    func ranking(players: [Player]) -> [Player] {
        return players.sorted { $0.points > $1.points }
    }

}




