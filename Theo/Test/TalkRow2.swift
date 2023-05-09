//
//  TalkRow2.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkRow2: View {
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

struct TalkRow2_Previews: PreviewProvider {
    static var previews: some View {
        TalkRow2(Date: "05/24", Question: "지난 한 주 동안 당신의 삶에서 일어난 긍정적인 일들은 무엇입니까?")
    }
}
