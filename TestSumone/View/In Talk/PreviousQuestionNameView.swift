//
//  QuestionNameView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import Foundation
import SwiftUI

struct PreviousQuestionNameView: View {
    var date : String
    var Question: String
    
    var body: some View {
        VStack {
            HStack {
                Text(date)
                    .font(.footnote).bold()
                    .foregroundColor(Color(uiColor: .systemGray))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote).bold()
                    .foregroundColor(Color(uiColor: .systemGray))
            }
            .padding(.bottom, -4)
            
            HStack {
                Text(Question)
                    .font(.title2).bold()
                    .foregroundColor(.black).opacity(0.9)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-4)
                    .lineLimit(1)
                
                Spacer()
            }
            
        }
        .padding()
        .cornerRadius(12)
        .background(Color(uiColor: .systemGray6))
    }
}
