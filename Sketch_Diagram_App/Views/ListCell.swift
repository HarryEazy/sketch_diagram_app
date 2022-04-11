//
//  ListCell.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import SwiftUI

struct ListCell: View {
    
    // MARK: - Properties
    let title: String
    let newDiagram: Diagram
    
    // MARK: - UI Elements
    var body: some View {
        
        VStack(alignment: .leading) {
            
            NavigationLink(title, destination: DrawingView(shapes: newDiagram.shapes))
                .font(.headline)
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(title: "Test Title for Previews", newDiagram: Diagram(name: "test", shapes: []))
    }
}

