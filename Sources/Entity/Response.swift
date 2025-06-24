import Foundation
 // diferenciar nome do atributo do nome da classe

public final class Response: Equatable, Codable {
    public let text: String
    public var votes: [Bool]
    public var isRepeated: Bool
    public var isValid: Bool {
        let trues = votes.filter({ $0 == true })
        let falses = votes.filter({ $0 == false })
        return trues.count >= falses.count
    }

    public init(text: String, votes: [Bool] = [], isRepeat: Bool = false) {
        self.text = text
        self.votes = votes
        self.isRepeated = isRepeat
    }
   public static func == (lhs: Response, rhs: Response) -> Bool {
           return lhs.text == rhs.text && lhs.isRepeated == rhs.isRepeated
       }
}
