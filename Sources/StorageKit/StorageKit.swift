import Foundation

protocol Entity: Codable{
    
    var id: String {get set}
   
}



@available(OSX 10.15, *)
class Container<T>: ObservableObject where T: Entity {
    
    public init(containerName: String) {
        self.containerName = containerName
        self.entities = []
        
        let directoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        
        let newContainerPath = directoryURL.appendingPathComponent(self.containerName)
        
        // Have not checked if directory gets destroyed every time (it should not)
        do {
            
            
                try FileManager.default.createDirectory(at: newContainerPath, withIntermediateDirectories: true, attributes: nil)

                print("New directory: \(newContainerPath.path)")
            
            
                    } catch let error as NSError {
            print("Unable to create directory \(error.debugDescription)")
        }
        
      _ =  self.fetchEntities()
    }
    
    let containerName: String
    
    var entities: [T] = []
    var hash: [String:T] = [:]
    
    func appendEntity(entity: T){
        
        self.entities.append(entity)
        self.hash[entity.id] = entity
        
        let jsonEncoder = JSONEncoder()
        do {
            
            let jsonData = try jsonEncoder.encode(entity)

            
            let directoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            
            let newContainerPath = directoryURL.appendingPathComponent(self.containerName)
            
            let newEntityPath = newContainerPath.appendingPathComponent("\(entity.id).json")
            
            try jsonData.write(to: newEntityPath)
            print("Entity saved at: \(newEntityPath.absoluteURL)")
            
        } catch {
            print("error saving entity")
        }
     
       
    }
    
    func removeEntity(entity: T){
        
        let directoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        
        let newContainerPath = directoryURL.appendingPathComponent(self.containerName)
        
        let newEntityPath = newContainerPath.appendingPathComponent(entity.id)
        
        do {
            try FileManager.default.removeItem(at: newEntityPath)

            print("Entity deleted")
            
        } catch {
            print("Error deleting entity")
        }
        
    }
    
    func fetchEntities() -> [T]{
        
        let fileManager = FileManager.default
        
        let directoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        
        let newContainerPath = directoryURL.appendingPathComponent(self.containerName)
        
        var entities: [T] = []
        var hash: [String:T] = [:]
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: newContainerPath, includingPropertiesForKeys: nil)
            // process files
            
            for file in fileURLs {
                
                do {
                    
                    let jsonData = try Data(contentsOf: file)
                    
                 
                    
                    
                    let newEntity: T  = try JSONDecoder().decode(T.self, from: jsonData as Data)
                   // print(newEntity) 🧟‍♂️
                    entities.append(newEntity)
                    hash[newEntity.id] = newEntity
                    
                } catch {
                    print("Error reading entity at file \(file.absoluteString)")
                    print(error.localizedDescription)
                }
            }
        } catch {
            print("Error while enumerating files \(newContainerPath.path): \(error.localizedDescription)")
        }
        
        print("Entities fetched: \(self.entities)")
        
        self.entities = entities
        self.hash = hash
        print("Container \(self.containerName) updated with the following list: \(self.entities)")
        print("Container \(self.containerName) updated with the following hash: \(self.hash)")
        return entities
    }
    
    
}
