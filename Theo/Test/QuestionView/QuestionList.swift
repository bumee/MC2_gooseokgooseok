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
                            NavigationLink {
                                QuestionEdit()
                            } label: {
                                QuestionRowQue()
                            }
                        }
                    }
                    
                    
                    Section(header: Text("물어본 질문")) {
                        ForEach(1..<10) {i in
                            NavigationLink {
                                TalkDetail()
                            } label: {
                                QuestionRow()
                            }
                        }
                    }
                    
                }
                .toolbar(.visible, for: .tabBar)
                .navigationTitle("나의 질문")
                .toolbar() {
                    Button() {
                        self.showModal = true
                    } label: {
                        Image(systemName: "plus").bold()
                            .font(.footnote)
                        Text("추가")
                            .font(.footnote)
                            .fontWeight(.black)
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(16)
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
