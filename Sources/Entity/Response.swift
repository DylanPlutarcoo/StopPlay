import Foundation
 // diferenciar nome do atributo do nome da classe

public final class Response: Equatable{
    public let text: String
    public var isRepeat: Bool
    public var isCorrect: Bool
    public var isBest: Bool
    init(text: String, isRepeat: Bool = false, isCorrect: Bool = true, isBest: Bool = false) {
        self.text = text
        self.isRepeat = isRepeat
        self.isCorrect = isCorrect
        self.isBest = isBest
    }
   public static func == (lhs: Response, rhs: Response) -> Bool {
           return lhs.text == rhs.text && lhs.isRepeat == rhs.isRepeat
       }
}
