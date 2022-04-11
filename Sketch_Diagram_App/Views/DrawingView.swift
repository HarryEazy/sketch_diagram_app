//
//  DrawingView.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import SwiftUI

struct DrawingView: View {
    
    
    // MARK: - Properties
    
    // because we are using an observableObject we need a stateObject
    // replace all lines with drawingDocument.lines
    @StateObject var drawingDocument = DrawingDocument()
    let engine = DrawingEngine()
    var shapes = [Shapes]()
    
    let possibleShapes = ["pencil", "line", "circle", "triangle", "rectangle"]
    // MARK: - Private Properties
    @State private var alertShowing = false
    @State private var editMode: EditMode = .inactive
    @State private var deletedShapes = [Shapes]()
    @State private var selectedColor: Color = .black
    @State private var selectedLineWidth: CGFloat = 1
    @State private var showConfirmation: Bool = false
    @State private var showGrid: Bool = false
    @State private var shapeType: String = "pencil"
    @State private var showShapePicker: Bool = false

    
    
    // MARK: - UI Elements
    var body: some View {
        

        
        GeometryReader { geometry in
                       
            VStack {
                
                // MARK: - Canvas
                ZStack {
                    
                    Color.white
                    
                    ForEach(drawingDocument.shapes){ shape in
                        
                        DrawingShape(points: shape.points, shapeType: shape.shapeType)
                            .stroke(shape.color, style: StrokeStyle(lineWidth: shape.lineWidth, lineCap: .round, lineJoin: .round))
                    }
                    
                    // MARK: - G
                    if self.showGrid {
                        Path { path in
                            for y in 0 ... Int(geometry.size.height/15) {
                                path.move(to: CGPoint(x: 0, y: CGFloat(y)*15))
                                path.addLine(to: CGPoint(x: geometry.size.width, y: CGFloat(y)*15))
                            }
                            for x in 0 ... Int(geometry.size.width/15) {
                                path.move(to: CGPoint(x: CGFloat(x)*15, y: 0))
                                path.addLine(to: CGPoint(x: CGFloat(x)*15, y: geometry.size
                                                            .height))
                            }
                        }
                        .stroke(Color.gray, lineWidth: 1)
                        .transition(.opacity)
                        .ignoresSafeArea()
                    }
                    
                }
                
                
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ value in
                    let newPoint = value.location

                    if value.translation.width + value.translation.height == 0 {
                        drawingDocument.shapes.append(Shapes(points: [newPoint], color: selectedColor, lineWidth: selectedLineWidth, shapeType: shapeType))
                    } else {
                        let index = drawingDocument.shapes.count - 1
                        drawingDocument.shapes[index].points.append(newPoint)
                    }
                    
                }).onEnded({ value in
                    if let last = drawingDocument.shapes.last?.points, last.isEmpty {
                        drawingDocument.shapes.removeLast()
                    }
                })
                         
                )
                
                
                
                // MARK: - Toolbar
                
                HStack {
                    
                    Button(action: {
                        self.showShapePicker = true
                    }) {
                        Text("Shape: \(self.shapeType)")
//                            .multilineTextAlignment(.center)
                    }
                    .actionSheet(isPresented: self.$showShapePicker, content: {
                        ActionSheet(title: Text("Pick a Shape"), message: nil, buttons: self.getShapeButtons())
                    })
                    
                }
                
                // MARK: Grid Bar
                
                HStack {

                    Spacer()
                    
                    withAnimation {
                        Toggle(isOn: self.$showGrid) {
                            Text("Show Grid")
                        }
                    }.padding(.horizontal)
                }
                
            
                HStack {
                    ColorPicker("line color", selection: $selectedColor)
                        .labelsHidden()
                    Slider(value: $selectedLineWidth, in: 1...20) {
                        Text("linewidth")
                    }.frame(maxWidth: 100)
                    Text(String(format: "%.0f", selectedLineWidth))
                    
                    Spacer()
                    
                    Button {
                        let last = drawingDocument.shapes.removeLast()
                        deletedShapes.append(last)
                    } label: {
                        Image(systemName: "arrow.uturn.backward.circle")
                            .imageScale(.large)
                    }.disabled(drawingDocument.shapes.count == 0)
                    
                    Button {
                        let last = deletedShapes.removeLast()
                        
                        drawingDocument.shapes.append(last)
                    } label: {
                        Image(systemName: "arrow.uturn.forward.circle")
                            .imageScale(.large)
                    }.disabled(deletedShapes.count == 0)
                    
                    Spacer()
                    
                    AlertButton(alertShowing: $alertShowing)
                        .textFieldAlert(isPresented: $alertShowing) {
                            TextFieldAlert(title: "Enter Diagram Name", shapes: drawingDocument.shapes)
                        }
                    
                    Button(action: {
                        showConfirmation = true
                    }) {
                        Text("Delete")
                    }.foregroundColor(.red)
                        .confirmationDialog(Text("Are you sure you want to delete everything?"), isPresented: $showConfirmation) {
                            
                            Button("Delete", role: .destructive) {
                                drawingDocument.shapes = [Shapes]()
                                deletedShapes = [Shapes]()
                            }
                        }
                    
                }.padding()

                
            }
            .onAppear() {
                drawingDocument.shapes = shapes
            }
        }
        
    }
    
    func getShapeButtons() -> [Alert.Button] {
        var alertButtons = [Alert.Button]()
        for shape in possibleShapes {
            alertButtons.append(.default(Text(shape), action: {
                withAnimation {
                    self.shapeType = shape
                }
            }))
        }
        alertButtons.append(.cancel())
        return alertButtons
    }
    

}



struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(shapes: [])
    }
}



