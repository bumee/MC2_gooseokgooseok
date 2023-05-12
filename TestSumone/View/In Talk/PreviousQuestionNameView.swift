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
                    .font(.caption2)
                    .foregroundColor(Color(uiColor: .systemGray2))
                
                Spacer()
                
                
            }
            .padding(.bottom, -6)
            
            HStack {
                Text(Question)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
        .frame(height: 48)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
    }
}
