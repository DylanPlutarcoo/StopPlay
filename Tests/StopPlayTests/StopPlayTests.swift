//
//  GameManagerTests.swift
//  MyExecutable
//
//  Created by Gabriel Oliveira Plutarco on 10/06/25.
//

import XCTest
@testable import StopPlay

final class GameManagerTests: XCTestCase {
    var gameManager: GameManager!
    
    override func setUp() {
        super.setUp()
        gameManager = GameManager()
    }
    
    func testRandomLetter() {
        let letrasValidas = Set("ABCDEFGHIJKLMNOPQRSTUVXWYZ")
        let letra = gameManager.randomLetter()
        XCTAssertTrue(letrasValidas.contains(letra))
    }
    
    func testRandomCategory() {
        let finalCategorys = gameManager.randomCategorys()
        XCTAssertEqual(finalCategorys.count, 5)
        for categoria in finalCategorys {
            XCTAssertTrue(finalCategorys.contains(categoria), "Categoria inválida encontrada: \(categoria)")
          }
    }
    
    func testRepeatedAnswers1() {
        let a1 = Response(answer: "A")
        let a2 = Response(answer: "A")
        let a3 = Response(answer: "B")
        let a4 = Response(answer: "B")
        let a5 = Response(answer: "C")
        let _ = gameManager.isRepeated(respostas: [a1, a2, a3, a4, a5])
        XCTAssertTrue(a1.isRepeat)
        XCTAssertTrue(a2.isRepeat)
        XCTAssertTrue(a3.isRepeat)
        XCTAssertTrue(a4.isRepeat)
        XCTAssertFalse(a5.isRepeat)

    }
    func testPrepareToVote() {
        let responses: [Response?] = [
            Response(answer: "A"),
            Response(answer: "B"),
            Response(answer: "C"),
            Response(answer: "D"),
            Response(answer: "E"),
            Response(answer: "F"),
            Response(answer: "G"),
            Response(answer: "H"),
            Response(answer: "I"),
            Response(answer: "J")
        ]
        
        let groups = gameManager.prepareToVote(toBeVoted: responses)
        
        XCTAssertEqual(groups.count, 5)
        for group in groups {
            XCTAssertEqual(group.count, 2)
        }
        XCTAssertEqual(groups[0], [responses[0], responses[1]])
        XCTAssertEqual(groups[1], [responses[2], responses[3]])
        XCTAssertEqual(groups[2], [responses[4], responses[5]])
        XCTAssertEqual(groups[3], [responses[6], responses[7]])
        XCTAssertEqual(groups[4], [responses[8], responses[9]])
    }
    func testCalculatePoints() {
        let r1 = Response(answer: "Banana", isRepeat: true)
        let r2 = Response(answer: "Abacaxi", isRepeat: false)
        let r3 = Response(answer: "Cenoura", isRepeat: false)

        let respostas = [r1, r2, r3]

        let p1 = Player(name: "Alice")
        let p2 = Player(name: "Bob")
        let p3 = Player(name: "Carol")

        let players = [p1, p2, p3]

        let votos: [[Bool]] = [
            [true, true, false],
            [true, true, false],
            [false, false, true]
        ]

        gameManager.calculatePoints(votos: votos, respostas: respostas, player: players)

        XCTAssertEqual(players[0].points, 10, "Jogador 0 deveria ter 10 pontos (resposta repetida e válida)")
        XCTAssertEqual(players[1].points, 5, "Jogador 1 deveria ter 5 pontos (resposta única e válida)")
        XCTAssertEqual(players[2].points, 0, "Jogador 2 não deveria ter pontos (resposta não válida)")
    }
    func testRanking() {
        let p1 = Player(name: "Alice")
        p1.points = 15
        let p2 = Player(name: "Davi")
        p2.points = 30
        let p3 = Player(name: "Carol")
        p3.points = 20
        let jogadores = [p1, p2, p3]
        let rankingOrdenado = gameManager.ranking(players: jogadores)

        XCTAssertEqual(rankingOrdenado[0].name, "Davi")
        XCTAssertEqual(rankingOrdenado[1].name, "Carol")
        XCTAssertEqual(rankingOrdenado[2].name, "Alice")
    }

}
