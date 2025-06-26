import Foundation
 // diferenciar nome do atributo do nome da classe

public final class Response: Equatable, Codable {
    public let text: String
    public var isRepeat: Bool
    public var isCorrect: Bool
    public var isBest: Bool
    public init(text: String, isRepeat: Bool = false, isCorrect: Bool = true, isBest: Bool = false) {
        self.text = text
        self.isRepeat = isRepeat
        self.isCorrect = isCorrect
        self.isBest = isBest
    }
   public static func == (lhs: Response, rhs: Response) -> Bool {
           return lhs.text == rhs.text && lhs.isRepeat == rhs.isRepeat
       }
    
    
    public func validateAnswer(with letter: String) {
        if isAnswerValid(letter: letter) {
            self.isCorrect = false
        }
    }
    
    public func isAnswerValid(letter: String) -> Bool {
        if doesAnswerStartWithLetter(letter) {
            return true
        } else if isAnswerLongEnough() {
            return true
        } else {
            return false
        }
    }
    
    public func doesAnswerStartWithLetter(_ letter: String) -> Bool {
        let firstLetter = self.text.first?.lowercased()
        
        return firstLetter != letter ? false : true
    }
    
    public func isAnswerLongEnough() -> Bool {
        let answerCount = self.text.count
        
        return answerCount < 2 ? false : true
    }
}
