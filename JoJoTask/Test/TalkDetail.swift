//
//  TalkDetail.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkDetail: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ZStack {
                drawRectangle()
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
            
            Form {
                HStack {
                    Text("질문을 입력하세요")
                    Spacer()
                    Button("Send") {
                        
                    }
                }
                
                
            }
            .background(Color.white)
            .padding(.top, 250)
        }
    }
    
    func drawRectangle() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(.black, lineWidth: 2)
            .padding(10)
    }
}

struct TalkDetail_Previews: PreviewProvider {
    static var previews: some View {
        TalkDetail()
    }
}
