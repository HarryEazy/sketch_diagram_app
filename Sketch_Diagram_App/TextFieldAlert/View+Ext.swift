//
//  View+Ext.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import SwiftUI

/*: Just like `alert` modifier, we create a modifier named `textAlert` in order to use the `TextAlert` object as an `Alert` object in our app. */
extension View {
    
    // MARK: - Methods
    func textFieldAlert(isPresented: Binding<Bool>, content: @escaping () -> TextFieldAlert) -> some View {
        TextFieldWrapper(isPresented: isPresented, presentingView: self, content: content)
    }
}
