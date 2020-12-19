import XCTest
@testable import StorageKit

final class StorageKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //XCTAssertEqual(StorageKit, "Hello, World!")
        var entity = Entity(id: "Test Entity", name: "John", description: "A simple user")
        var container = Container(containerName: "User Container")
        
        container.appendEntity(entity: entity)
        
        var entities = container.fetchEntities()
        
        print(entities[0].name)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
