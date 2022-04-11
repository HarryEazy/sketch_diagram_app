//
//  CustomFileManager.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI


/*:
 CustomFileManager to get usr documents path, save and get diagrams.
 ObservableObject as we need to know when changes occur
 static let shared to call class outside itself
 */

class CustomFileManager: ObservableObject {
    
    // MARK: - Properties
    /*:
     To store data with FileManager, we need a URL object. We define a property for that.
    */
    @Published var diagrams = [Diagram]()
    static let shared = CustomFileManager()
    
    // MARK: - Private Properties
    private let dataSourceURL: URL
    
    // MARK: - Lifecycle
    init() {
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let diagramPath = documentsPath.appendingPathComponent("diagrams").appendingPathExtension("json")
        
        self.dataSourceURL = diagramPath
        self.diagrams = getAllDiagrams()

    }
    
    // MARK: - Private Methods

    private func getAllDiagrams() -> [Diagram] {
        do {
            
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: dataSourceURL)
            let decodedDiagrams = try! decoder.decode([Diagram].self, from: data)

            return decodedDiagrams
        } catch {
            return []
        }
    }
    
    
    private func saveDiagrams() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(diagrams)
            try data.write(to: dataSourceURL)
            self.diagrams = getAllDiagrams()
        } catch {
            // write catch exception here!!!
        }
    }
    
    
    // MARK: - Public Methods
    func createDiagram(name: String, shapes: [Shapes]) {
        let diagram = Diagram(name: name, shapes: shapes)
        diagrams.insert(diagram, at: 0)
        saveDiagrams()
    }

    /*:
     Write a method to replace a previously defined `Diagram` object. Similarly, after making changes, we call the `saveNotes` method.
    */
    func changeDiagram(diagram: Diagram, index: Int) {
        diagrams[index] = diagram
        saveDiagrams()
    }
    
    /*:
     Write a new method to delete a `diagram` object. To delete the element in a `List` object in SwiftUI, we need the `offsets` information of that element. That’s why, this method has a `offsets` parameter.
    */
    func delete(_ offsets: IndexSet) {
        diagrams.remove(atOffsets: offsets)
        saveDiagrams()
    }
    
    /*:
     Finally, write a method called `move` to move a `List` cell. The information source of the cells in the `List` object -we will create- will be `allNotes` array. Therefore, when we change the position of a cell, we need to change the offsets of the `Note` object of that cell.
    */
    func move(source: IndexSet, destination: Int) {
        diagrams.move(fromOffsets: source, toOffset: destination)
        saveDiagrams()
    }

}
