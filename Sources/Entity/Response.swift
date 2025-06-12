import Foundation

class Response: Equatable{
    let texto: String
    var isRepeat: Bool
    init(answer: String, isRepeat: Bool = false) {
        self.texto = answer
        self.isRepeat = isRepeat
    }
    static func == (lhs: Response, rhs: Response) -> Bool {
           return lhs.texto == rhs.texto && lhs.isRepeat == rhs.isRepeat
       }
}
