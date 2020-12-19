import SwiftUI
import Foundation

class Entity: Codable{
    
   public init(id: String, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    
    var id: String
    var name: String
    var description: String
    
    
}


class Container {
    
    internal init(containerName: String) {
        self.containerName = containerName
        self.entities = [:]
        
        let directoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        
        let newContainerPath = directoryURL.appendingPathComponent(self.containerName)
        
        // Have not checked if directory gets destroyed every time (it should not)
        do {
            try FileManager.default.createDirectory(at: newContainerPath, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Unable to create directory \(error.debugDescription)")
        }
        print("New directory: \(newContainerPath.path)")
    }
    
    let containerName: String
    var entities: [String: Entity]
    
    func appendEntity(entity: Entity){
        
        self.entities[entity.id] = entity
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
    
    func removeEntity(entity: Entity){
        
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
    
    func fetchEntities() -> [Entity]{
        
        let fileManager = FileManager.default
        
        let directoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        
        let newContainerPath = directoryURL.appendingPathComponent(self.containerName)
        
        var entities: [Entity] = []
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: newContainerPath, includingPropertiesForKeys: nil)
            // process files
            
            for file in fileURLs {
                
                do {
                    
                    let jsonData = try Data(contentsOf: file)
                    
                 
                    
                    
                    let newEntity: Entity  = try JSONDecoder().decode(Entity.self, from: jsonData as Data)
                    print(newEntity)
                    entities.append(newEntity)
                } catch {
                    print("Error reading entity at file \(file.absoluteString)")
                    print(error.localizedDescription)
                }
            }
        } catch {
            print("Error while enumerating files \(newContainerPath.path): \(error.localizedDescription)")
        }
        
        return entities
    }
    
}
