//
//  Shapes.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI

struct Shapes: Identifiable, Codable {
    
    // MARK: - Properties
    
    // we dont want to save this color as we have a customColor for that
    // we make it computed property from the customColor
    var color: Color {
        get {
            customColor.color
        }
        set {
            customColor = CustomColor(color: newValue)
        }
    }
    
    var points: [CGPoint]
    var lineWidth: CGFloat
    let id: UUID
    var shapeType: String
    
    // MARK: - Private Properties
    // dont want to expose this to ui code as we only need this to save the file
    private var customColor: CustomColor
    
    // MARK: - Lifecycle
    init(points: [CGPoint], color: Color, lineWidth: CGFloat, shapeType: String) {
        self.points = points
        self.customColor = CustomColor(color: color)
        self.lineWidth = lineWidth
        self.id = UUID()
        self.shapeType = shapeType
    }
    
}
