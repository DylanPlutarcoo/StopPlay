import Foundation
 

public final class Player {
  public  let name: String
  public  var points: Int
    
    init(name: String, id: UUID = UUID(), points: Int = 0) {
        self.name = name
        self.points = points
    }
}
