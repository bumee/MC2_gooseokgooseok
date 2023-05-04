//
//  TalkAnswer2.swift
//  Test
//
//  Created by 조용현 on 2023/05/04.
//

import SwiftUI

struct TalkAnswer2: View {
    var body: some View {
        VStack {
            Text("04월 21일 (토) 9:41")
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 80)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .foregroundColor(Color.gray)
                .overlay {
                    Text("지난 한 주 동안 당신의 삶에서 일어난 긍정적인 일은 무엇입니까?")
                }
            HStack() {
                Text("👨사용자1")
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 10)
                Spacer()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 80)
                .foregroundColor(Color.gray)
                .overlay {
                    Text("")
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 100))
            
        }
        
    }
}
    
    func drawRectangle() -> some View {
        RoundedRectangle(cornerRadius: 8)
//            .strokeBorder(.black, lineWidth: 2)
//            .padding(10)
//            .frame(height: 300)
    }

struct TalkAnswer2_Previews: PreviewProvider {
    static var previews: some View {
        TalkAnswer2()
    }
}
