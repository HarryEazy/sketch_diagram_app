//
//  TextFieldAlertViewController.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import Combine
import SwiftUI


/*:
 Currently we can edit and delete the `List` object cells, but we cannot add a new `Note` object. That’s why, our app does not make any sense right now, as there is no `Diagram` object attached. If we create UI elements to add new `Diagram` objects, our app will become what we want.
 We will use an `Alert` object to add a new `Diagram` object. This may seem easy to you, but SwiftUI still doesn't have an `Alert` object with `TextField` object(s) in it. Therefore, we need to create custom `Alert` object with `UIViewControllerRepresentable`.
 The first thing we will do is create a new `UIViewController`, just like defining a custom `UIAlertViewController` in UIKit. To do this, you can create a Swift file named "TextFieldAlertViewController" and import “SwiftUI” and “Combine” frameworks.
 */
class TextFieldAlertViewController: UIViewController {

    // MARK: - Properties
    @ObservedObject var customFileManager = CustomFileManager.shared
    
    // MARK: - Private Properties
    private let diagramName: String
    private let shapes: [Shapes]
    private var isPresented: Binding<Bool>?
    private var subscription: AnyCancellable?
        
    // MARK: - Life Cycle
    init(title: String, shapes: [Shapes], isPresented: Binding<Bool>?) {
        self.diagramName = title
        self.shapes = shapes
        self.isPresented = isPresented

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentAlertController()
    }
    
    

    // MARK: - Methods
    private func presentAlertController() {
        guard subscription == nil else { return }
        
        let ac = UIAlertController(title: diagramName, message: "Name your diagram to save it", preferredStyle: .alert)
        
        ac.view.tintColor = .red
        ac.addTextField()
        ac.textFields![0].placeholder = "Name"

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.isPresented?.wrappedValue = false
        }
        
        let createAction = UIAlertAction(title: "Save", style: .default) { [unowned ac] _ in
            let title = ac.textFields![0].text!
            
            self.customFileManager.createDiagram(name: title, shapes: self.shapes)
            
        }
        
        ac.addAction(cancelAction)
        ac.addAction(createAction)
        present(ac, animated: true, completion: nil)
    }
}
