//
//  DrawShapes.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI

struct DrawingShape: Shape {
    // MARK: - Properties
    let points: [CGPoint]
    let engine = DrawingEngine()
    let shapeType: String
    
    // MARK: - Methods
    func path(in rect: CGRect) -> Path {
        
        // Use switch statement for shapeType to call the correct method in DrawingEngine
        switch(shapeType){
            
        case "line":
            return engine.createLine(for: points)
            
        case "circle":
            return engine.makeCircle(for: points)
            
        case "rectangle":
            return engine.createRectangle(for: points)
            
        case "triangle":
            return engine.createTriangle(for: points)
        
        default:
            return engine.createPath(for: points)
        }

    }
    
    
    
}
