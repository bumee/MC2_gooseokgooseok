//
//  HelpPopupView.swift
//  TestSumone
//
//  Created by moon on 2023/05/14.
//

import SwiftUI

struct HelpPopupView: View {
    var body: some View {
        VStack(spacing:0){
            Text("질문을 등록해주세요.")
                .padding(.top, 5)
            Text("등록된 질문은 내일 제공됩니다!")
                .padding(5)
        }
        .background( Color.gray.opacity(0.3) )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct HelpPopupView_Previews: PreviewProvider {
    static var previews: some View {
        HelpPopupView()
    }
}
