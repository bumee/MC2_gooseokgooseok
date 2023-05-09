//
//  QuestionNameView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import Foundation
import SwiftUI

struct PreviousQuestionNameView: View {
    var Date: String
    var Question: String
    
    var body: some View {
        VStack {
            HStack {
                Text(Date)
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
                
                Spacer()
            }
            .padding(.bottom, -1)
            
            HStack {
                Text(Question)
                
                Spacer()
            }
        }
    }
}
