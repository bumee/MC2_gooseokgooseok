//
//  QuestionList.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct QuestionList: View {
    @State private var showModal = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: Text("대기중")) {
                        ForEach(1..<2) {i in
                            QuestionRowQue()
                        }
                    }
                    
                    
                    Section(header: Text("물어본 질문")) {
                        ForEach(1..<10) {i in
                            NavigationLink {
//                                TalkDetail()
                            } label: {
                                QuestionRow()
                            }
                        }
                    }
                    
                }
                .navigationTitle("나의 질문")
                .toolbar {
                    Button("추가") {
                        self.showModal = true
                    }
                    .sheet(isPresented: self.$showModal) {
                        QuestionAddModal()
                    }
                }
            }
        }
    }
}

struct QuestionList_Previews: PreviewProvider {
    static var previews: some View {
        QuestionList()
    }
}
