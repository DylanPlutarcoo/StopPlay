import Foundation
 

class Player {
    let name: String
    var points: Int
    
    init(name: String, id: UUID = UUID(), points: Int = 0) {
        self.name = name
        self.points = points
    }
}
