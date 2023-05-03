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
            //            Spacer()
            drawRectangle()
                .overlay {
                    VStack {
                        Text("04/21")
                        Text("가장 소중하게 여기는 우리 가족의 추억은 뭔가요?")
                            .padding(.bottom, 16)
                        
                        VStack {
                            Text("답변자")
                                .padding(.leading, 250)
                            Text("🧑👩🏼‍🦱")
                                .padding(.leading, 250)
                        }
                    }
                }
            //            Spacer()
            HStack(alignment:.top) {
                        ScrollView {
                            TextField("Note", text: $text.note, axis: .vertical)
                                .focused($focus, equals: true)
                                .padding(.leading, 20)
                        }
                        Spacer()
                        Button {
                            if text.updating {
                                
                            } else {
                                
                            }
                        } label: {
                            Text("Send")
                            
                        }
                        .padding(.trailing, 20)
                        .buttonStyle(.borderedProminent)
                        .disabled(text.incomplete)
                    }
            .frame(height: 100)
            .padding()
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
