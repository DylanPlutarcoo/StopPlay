import Foundation
 

public final class Player: Codable {
  public  let name: String
  public  var points: Int
    
    public init(name: String, id: UUID = UUID(), points: Int = 0) {
        self.name = name
        self.points = points
    }
}
