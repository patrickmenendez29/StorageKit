import XCTest
@testable import StorageKit

class User: Entity {
    
    public init(id: String, name: String, age: Int, password: String){
        self.id = id

        self.age = age
        self.name = name
        self.password = password
    }
    
    var id: String
    
    var name: String
    var age: Int
    var password: String
    
}

final class StorageKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(StorageKit, "Hello, World!")
        
        
        let user = User(id: "Admin", name: "Patrick", age: 19, password: "12345678")
        
        let container = Container<User>(containerName: "User Container")
        
        container.appendEntity(entity: user)
        
        let entities = container.fetchEntities()
        
        print(entities[0].password)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
