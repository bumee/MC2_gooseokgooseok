//
//  QuestionNameView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import Foundation
import SwiftUI

struct QuestionNameView: View {
    var text : String
    var now = Date()
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .foregroundColor(.red)
                    .frame(width: 10, height: 10)
                Text("\(now)")
                Spacer()
            }
            HStack {
                Text(text)
                    .font(.headline)
                Spacer()
            }
        }
    }
}
