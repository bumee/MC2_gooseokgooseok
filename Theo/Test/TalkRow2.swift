//
//  TalkRow2.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkRow2: View {
    var body: some View {
        VStack {
            HStack {
//                Circle()
//                    .frame(width: 8)
//                    .foregroundColor(.white)
                Text("04/24")
                    .font(.footnote)
                    .opacity(0.6)
                    .padding(.bottom, 1)
                
                Spacer()
            }
            
            HStack {
                Text("지난 한 주 동안 당신의 삶에서 일어난 긍정적인 일들은 무엇입니까?")
                
                Spacer()
            }
        }
//        .padding(.leading)
    }
}

struct TalkRow2_Previews: PreviewProvider {
    static var previews: some View {
        TalkRow2()
    }
}
