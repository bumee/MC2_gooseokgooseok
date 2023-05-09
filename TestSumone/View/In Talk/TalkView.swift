//
//  TalkView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import Foundation
import SwiftUI

struct TalkView: View {
    @EnvironmentObject var PreviousQuestions: PreviousQuestionData
    var userName: String
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    MessageBlockView(text: AnswerTextData(), Title: "테스트", userName: userName)
                } label: {
                    TodayQuestionView()
                }
                
                Section(header: Text("지난 대화")) {
                    ForEach(0..<PreviousQuestions.questions.count, id: \.self) { idx in
                        NavigationLink(
                            destination:  MessageShowingView(Title: PreviousQuestions.questions[idx])
                        )
                        {
                            PreviousQuestionNameView(Date: PreviousQuestions.Dates[idx], Question: PreviousQuestions.questions[idx])
                        }
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationTitle("Talk")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
