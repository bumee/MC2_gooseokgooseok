//
//  LoginNameView.swift
//  Test
//
//  Created by 박상준 on 2023/05/04.
//

import SwiftUI

struct LoginNameView: View {
    @State var userName: String = ""
    
    var body: some View {
        VStack {
            Text("나는 우리 가족의 ____ 입니다.").bold()
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("별명을 입력해주세요", text: $userName, axis: .vertical)
                .frame(maxWidth: .infinity, alignment: .center)
                .autocorrectionDisabled()
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(12)
            
            Spacer()
            
            Button(action: {
            }, label: {
                Text("확인").bold()
                    .frame(maxWidth: .infinity, maxHeight: 40)
            })
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        
    }
}

struct LoginNameView_Previews: PreviewProvider {
    static var previews: some View {
        LoginNameView()
    }
}
