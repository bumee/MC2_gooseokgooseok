//
//  PreviousAnswerView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import SwiftUI

struct MessageBubble: Shape {
    var isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        let path = Path { p in
            p.move(to: CGPoint(x: 0, y: height - 20))
            p.addQuadCurve(to: CGPoint(x: 20, y: height),
                           control: CGPoint(x: 0, y: height))
            p.addLine(to: CGPoint(x: width - 30, y: height))
            p.addQuadCurve(to: CGPoint(x: width - 10, y: height - 20),
                           control: CGPoint(x: width - 10, y: height))
            p.addLine(to: CGPoint(x: width - 10, y: 20))
            p.addQuadCurve(to: CGPoint(x: width - 30, y: 0),
                           control: CGPoint(x: width - 10, y: 0))
            p.addLine(to: CGPoint(x: 20, y: 0))
            p.addQuadCurve(to: CGPoint(x: 0, y: 20),
                           control: CGPoint(x: 0, y: 0))
            p.closeSubpath()
        }
        
        return path
    }
}

struct MessageBubbleView: View {
    let message: String
    let isFromCurrentUser: Bool
    
    var body: some View {
        if isFromCurrentUser {
            HStack {
                Spacer()
                Text(message)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.blue)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                .cornerRadius(12)}
        } else {
            HStack {
                Text(message)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color(uiColor: .secondarySystemBackground))
                    .multilineTextAlignment(.leading)
                    .cornerRadius(12)
                Spacer()
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

