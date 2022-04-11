//
//  TextFieldAlert.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI

/*: As our custom `Alert` object that we will use in our main `View` object, we create a custom UI object named “TextFieldAlert”. */
struct TextFieldAlert {

    // MARK: Properties
    let title: String
    let shapes: [Shapes]
    var isPresented: Binding<Bool>? = nil

    // MARK: - Methods
    func dismissable(_ isPresented: Binding<Bool>) -> TextFieldAlert {
        TextFieldAlert(title: title, shapes: shapes, isPresented: isPresented)
    }
}
/*: We use the `UIViewControllerRepresentable` protocol to use a custom UIKit elements in SwiftUI. Likewise, we will use it with `TextAlert` object. */
/*: Then, create a `View` element named “TextFieldWrapper” to define what needs to be done when `TextAlert` object will not and will be displayed in our main `View` object. */
extension TextFieldAlert: UIViewControllerRepresentable {

    typealias UIViewControllerType = TextFieldAlertViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<TextFieldAlert>) -> UIViewControllerType {
        TextFieldAlertViewController(title: title, shapes: shapes, isPresented: isPresented)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<TextFieldAlert>) {}
}
