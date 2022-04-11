//
//  AlertButton.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import SwiftUI

struct AlertButton: View {
    
    @Binding var alertShowing: Bool
    
    var body: some View {
        
            return AnyView(Button(action: {
                withAnimation {
                    print("Alert Button Pressed")
                    if alertShowing {
                        alertShowing = false
                    } else {
                        alertShowing = true
                    }
                    
                }
            }) {
                Image(systemName: "square.and.arrow.down")
                    .imageScale(.large)
            })
            
    }
    
}



//struct AlertButton_Previews: PreviewProvider {
//    static var previews: some View {
//        // AlertButton(alertShowing: alertShowing)
//    }
//}
