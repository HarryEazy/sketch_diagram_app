//
//  CustomColor.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI

// create a struct for the color as Color does not conform to Codable
struct CustomColor: Codable {
    
    // MARK: - Properties
    // 0001 is black so this is default type
    var green: Double = 0
    var blue: Double = 0
    var red: Double = 0
    var opacity: Double = 1
    
    
    
    
    // easy way to get the color from the CustomColor struct
    // this is helping when we load the file from the disk to create colour we can use in the UI
    var color: Color {
        Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    // MARK: - Lifecycle
    
    // inverse from color to custom color
    // it takes a color and we then create a cusom colour from this
    init(color: Color) {
        // cant get the rbg values from color directly so we need to use cgColor which is optional value
        // components returns the 3 color and alpha
        if let components = color.cgColor?.components {
            // check if components has atleast 3 values (not sure if this check is needed)
            // then we store the color to self variables
            if components.count > 2 {
                self.red = components[0]
                self.green = components[1]
                self.blue = components[2]
            }
            // if greater than 3 we have to opacity as well
            if components.count > 3 {
                self.opacity = components[3]
            }
        }
    }
        
}
