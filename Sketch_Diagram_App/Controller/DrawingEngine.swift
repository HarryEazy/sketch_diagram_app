//
//  DrawingEngine.swift
//  Sketch_Diagram_App
//
//  Created by Harry Camps on 11/04/2022.
//

import Foundation
import SwiftUI

class DrawingEngine {
    
    //MARK: - Create Shapes Method
    func createPath(for points: [CGPoint]) -> Path {
        var path = Path()
        
        if let firstPoint = points.first {
            path.move(to: firstPoint)
        }
        
        for index in 1..<points.count {
            let mid = calculateMidPoint(points[index - 1], points[index])
            path.addQuadCurve(to: mid, control: points[index - 1])
        }
        
        if let last = points.last {
            path.addLine(to: last)
        }
        
        return path
    }
    
    

    func createCircle(for points: [CGPoint]) -> Path {
        
        var path = Path()
        if let firstPoint = points.first {
                let radius = 20
                path.addArc(center: firstPoint, radius: CGFloat(radius), startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        }

        return path
    }
    
    
    func createLine(for points: [CGPoint]) -> Path {

        var path = Path()
        if let firstPoint = points.first {
            path.move(to: firstPoint)
            if let last = points.last {
                let radius = 2
                path.addArc(center: last, radius: CGFloat(radius), startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
            }

        }

        return path

    }
    
    func makeCircle(for points: [CGPoint]) -> Path {
        var path = Path()
        if let center = points.first {
            
            path.move(to: center)
            if let last = points.last {
                let radius = getDistanceBetween(center, and: last)
                path.addEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius*2, height: radius*2))
            }
            
            
        }
        return path
        
    }
    
   
    func createTriangle(for points: [CGPoint]) -> Path {
        
            var path = Path()
            if let firstPoint = points.first {
            
                path.move(to: firstPoint)
                
                if let last = points.last {
  
                    path.addLine(to: CGPoint(x: firstPoint.x + last.x / 2, y: last.x ))
                    path.addLine(to: last)
                    path.addLine(to: firstPoint)
                    
                }
                
            }
            
               return path
    }
    
    

    func createRectangle(for points: [CGPoint]) -> Path {
        var path = Path()
        if let firstPoint = points.first {
            
            path.move(to: firstPoint)
            if let last = points.last {
                //let radius = 20
                path.addRoundedRect(in: CGRect(x: firstPoint.x, y: firstPoint.y, width: last.x - firstPoint.x, height: last.y - firstPoint.y), cornerSize: CGSize(width: 5, height: 10))
            }
            
            
        }
        return path
    }
    
    //MARK: - Helper Methods
    func calculateMidPoint(_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        let newMidPoint = CGPoint(x: (point1.x + point2.x)/2, y: (point1.y + point2.y)/2)
        return newMidPoint
    }
    
    func getDistanceBetween(_ firstPoint: CGPoint, and secondPoint: CGPoint) -> CGFloat {
        return sqrt(pow((secondPoint.x - firstPoint.x), 2) + pow((secondPoint.y - firstPoint.y), 2))
    }
    
    
}
