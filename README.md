# StorageKit

![Header](Resources/StorageKit-Header.png)

StorageKit is a simple yet powerful alternative to Core Data. With StorageKit, you can save data to your app's directory and access it using minimal code.


Creating your data

```swift
//Conforming your class 
class MyClass: Entity, Identifiable{
    
    //include aditional parameters if needed
    init(id: String ) {
        self.id = id
        //initialize your parameters here
    }
    
    var id: String
    
    //can store arrays, strings, ints, booleans and others (everything that conforms to codable)
    
}
```


Setting up your App delegate 
```swift
import SwiftUI
import StorageKit

@main
struct YourApp: App {
    
    var classContainer = Container<MyClass>(containerName: "MyClass container")
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(classContainer)
        }
    }
}
```

Reading/Writing data 

```swift

struct ContentView: View {

    //accessing the container
    @EnvironmentObject var classContainer: Container<MyClass>

    var body: some View {
        List {
        //each container has its own public property of entities that works as a list, a dictionary is also created
            ForEach(self.classContainer.entities){ object in
                Text("\(object.id)")

            }
        }
            
    }
} 
