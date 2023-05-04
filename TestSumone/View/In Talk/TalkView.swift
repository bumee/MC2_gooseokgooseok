//
//  TalkView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import Foundation
import SwiftUI

struct TalkView: View {
    @EnvironmentObject var QuestionList : QuestionData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(QuestionList.questions.reversed(), id: \.self) { Question in
                    NavigationLink(
                        destination:  MessageShowingView()
                    ){
                        QuestionNameView(text: "\(Question)")
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationTitle("Talk")
        }
    }
}
