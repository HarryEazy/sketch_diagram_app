//
//  MenuView.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import SwiftUI

struct MenuView: View {
    
    // MARK: - Properties
    @ObservedObject var customFileManager = CustomFileManager.shared
    
    // MARK: - Private Properties
    @State private var alertShowing = false
    @State private var editMode: EditMode = .inactive

    var body: some View {
        
        // MARK: - Navigation View
        NavigationView {
            
            List {

                ForEach(customFileManager.diagrams) { diagram in
                    ListCell(title: diagram.name, newDiagram: diagram)
                }
                    .onDelete(perform: customFileManager.delete)
                    .onMove(perform: customFileManager.move)
            }
                    .navigationTitle(Text("Diagrams"))
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing:AddButton(editMode: $editMode, alertShowing: $alertShowing )
                        
                        // MARK: - TODO
                        
                        // ADD BUTTON SO THAT YOU CANT GO TO NEW DIAGRAM UNTIL EDIT HAS FINISHED
                        
                        // MARK: - TODO END
                    )
                    
                    .environment(\.editMode, $editMode)
        
            }.listStyle(.plain)

        }
        
    }
    
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


