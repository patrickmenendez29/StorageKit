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
```

Adding entities to a container 
to append a new entity, use appendEntity(entity: Entity)

```swift

public func appendEntity(entity: Entity) 

//Example 

Button(action: {
            // ids must be unique
            let sampleUser = User(id: "Sample user")
            self.userContainer.appendEntity(entity: sampleUser)
        }){
            Text("Add a sample entity")
        }
        
   ```
   Removing an entity is even easier
   ```swift
   public func removeEntity(entity: Entity)
   ```
   If an external array is required, fetchEntities() will return an array filled with all entities inside the container
   ```swift 
   
   //result will be a copy, which means that if the contasiner updates after calling it, it will remain static
   
   public func fetchEntity() -> [Entity]
   ```
