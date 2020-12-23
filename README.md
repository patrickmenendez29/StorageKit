# StorageKit

![AppIcon] (/Resources/StorageKit-Header.png)
A description of this package.

Creating your data
```swift
class YourClass: Entity {
    
    //include aditional parameters if needed
    init(id: String ) {
        self.id = id
        //initialize your parameters here
    }
    
    var id: String
    
    //can store arrays, strings, ints, booleans and others (everything that connforms to codable)
    
}
```


Setting up your App delegate 
```swift
import SwiftUI
import StorageKit

@main
struct YourApp: App {
    
    var userContainer = Container<User>(containerName: "Users")
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userContainer)
        }
    }
}
```
