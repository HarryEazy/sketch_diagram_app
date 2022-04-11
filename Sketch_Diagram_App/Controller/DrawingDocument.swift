//
//  DrawingDocument.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation


class DrawingDocument: ObservableObject {
    
    //MARK: - Properties
    let customFileManager = CustomFileManager.shared
    var diagrams = [Diagram]()
    @Published var shapes = [Shapes]()
    
    //MARK: - Lifecycle
    init() {
        self.diagrams = customFileManager.diagrams
    }
   
}
