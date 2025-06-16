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
        let letra = gameManager.randomLetter(letras: "ABCDEFGHIJKLMNOPQRSTUVXWYZ")
        XCTAssertTrue(letrasValidas.contains(letra))
    }
    
    func testRandomCategory() {
        let finalCategorys = gameManager.randomCategorys(categorys: ["Cidade","Cor","Comida","Roupa","Pais","Fulano é...","Paisagem"])
        XCTAssertEqual(finalCategorys.count, 5)
        for categoria in finalCategorys {
            XCTAssertTrue(finalCategorys.contains(categoria), "Categoria inválida encontrada: \(categoria)")
          }
    }
    
    func testRepeatedAnswers1() {
        var a1 = Response(text: "A")
        var a2 = Response(text: "A")
        var a3 = Response(text: "B")
        var a4 = Response(text: "B")
        var a5 = Response(text: "C")
        var respostas = [a1, a2, a3, a4, a5]
        var _ = gameManager.isRepeated(respostas: &respostas )
        XCTAssertTrue(a1.isRepeat)
        XCTAssertTrue(a2.isRepeat)
        XCTAssertTrue(a3.isRepeat)
        XCTAssertTrue(a4.isRepeat)
        XCTAssertFalse(a5.isRepeat)

    }
    func testPrepareToVote() {
        var responses: [Response?] = [
            Response(text: "A"),
            Response(text: "B"),
            Response(text: "C"),
            Response(text: "D"),
            Response(text: "E"),
            Response(text: "F"),
            Response(text: "G"),
            Response(text: "H"),
            Response(text: "I"),
            Response(text: "J")
        ]
        
        let groups = gameManager.prepareToVote(toBeVoted: &responses)
        
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
            let respostas = [
                Response(text: "",isRepeat: false,isCorrect: true, isBest: true),  // 125
                Response(text: "",isRepeat: true,isCorrect: true, isBest: true),   // 75
                Response(text: "",isRepeat: true,isCorrect: true, isBest: false),  // 50
                Response(text: "",isRepeat: true,isCorrect: false, isBest: true),  // 0
                Response(text: "", isRepeat: false,isCorrect: false, isBest: false) // 0
            ]
            
        var players = (0..<5).map { _ in
            Player(name: "oi")
        }
            
            gameManager.calculatePoints(respostas: respostas, players: &players)
            
            XCTAssertEqual(players[0].points, 125)
            XCTAssertEqual(players[1].points, 75)
            XCTAssertEqual(players[2].points, 50)
            XCTAssertEqual(players[3].points, 0)
            XCTAssertEqual(players[4].points, 0)
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
