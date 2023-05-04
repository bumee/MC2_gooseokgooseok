//
//  TalkDetail.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkDetail: View {
    
    @StateObject var text: TextStruct
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
    var body: some View {
        VStack() {
//            drawRectangle()
//                .overlay {
            Form() {
                Text("04월 21일 (토) 9:41")
                Text("가장 소중하게 여기는 우리 가족의 추억은 뭔가요?")
                    .padding(.bottom, 16)
                    .listRowSeparator(.hidden)
                
                VStack(alignment: .trailing) {
                    Text("답변자")
//                        .padding(.leading, 250)
                    Text("🧑👩🏼‍🦱")
//                        .padding(.leading, 250)
                }
                HStack(alignment:.top) {
                            ScrollView {
                                TextField("Note", text: $text.note, axis: .vertical)
                                    .focused($focus, equals: true)
                            }
                            Spacer()
                            Button {
                                if text.updating {
                                    
                                } else {
                                    
                                }
                            } label: {
                                Text("Send")
                                
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(text.incomplete)
                        }
                .frame(height: 100)
            .padding()
            }
            Spacer()
        }
    }
    
    func drawRectangle() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(.black, lineWidth: 2)
            .padding(10)
            .frame(height: 300)
    }
}

struct TalkDetail_Previews: PreviewProvider {
    static var previews: some View {
        TalkDetail(text: TextStruct())
    }
}
