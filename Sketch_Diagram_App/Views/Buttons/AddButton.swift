//
//  AddButton.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI

/*:
 It is not right to have the add button active while editing the List object. That’s why, let's convert the add button to a custom object named "AddButton" and when the `editMode` element equal to “.active", it turn into an `EmptyView` object.
 */
struct AddButton: View {

    // MARK: - Properties
    @Binding var editMode: EditMode
    @Binding var alertShowing: Bool
    
    // MARK: - UI Elements
    var body: some View {
        if editMode == .inactive {
            
            return AnyView(Button(action: {
                    withAnimation {
                    }
                }) {
                    NavigationLink( "\(Image(systemName: "plus.circle.fill"))", destination: DrawingView(shapes: []))
                })
        } else {
            return AnyView(EmptyView())
        }
    }
}
    

