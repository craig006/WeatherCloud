import Foundation
//This is just a conveinience wrapper until AwesomeCache supports Codable
class JsonCacheWrapper<T: Decodable & Encodable>: NSObject, NSCoding {
    
    var item: T!
    
    init(item: T) {
        self.item = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let data = aDecoder.decodeData() {
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(T.self, from: data) {
                item = result
                return
            }
        }
        
        return nil
    }
    
    func encode(with aCoder: NSCoder) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(item) {
            aCoder.encode(data)
        } else {
            print("Error while encoding type \(T.self)")
        }
    }
}
