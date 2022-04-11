//
//  Diagram.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI


struct Diagram: Identifiable, Codable {
    
    // MARK: - Properties
    var shapes: [Shapes]
    let id: UUID
    var name: String
    
    // MARK: - Lifecycle
    init( name: String, shapes: [Shapes]){
        self.name = name
        self.shapes = shapes
        self.id = UUID()
    }
    
    
    
    
}
