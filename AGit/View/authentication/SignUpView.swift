//
//  SignUpView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userModel: UserModel
    @State var nickname = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            NavigationBarView(title: "Sign Up", hasBackButton: true)
            
            VStack(spacing: 30){
                Spacer()
                
                TextField("nickname", text: $nickname)
                HStack {
                    TextField("email", text: $email)
                    Text("@pos.idserve.net")
                }
                SecureField("password", text: $password){
                    userModel.signUp(nickname: nickname, email: email, password: password) { result in
                        if result{
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                
                Button(action: {
                    userModel.signUp(nickname: nickname, email: email, password: password) { result in
                        if result{
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }) {
                    Text("Sign Up")
                        .frame(width: 120, height: 50)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("primary"))
                        }
                }
                
                Spacer()
            }
            .padding()
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(UserModel())
    }
}
