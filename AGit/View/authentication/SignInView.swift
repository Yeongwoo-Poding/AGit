//
//  SignInView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var userModel: UserModel
    @State var email = ""
    @State var password = ""
    
    @State var isSignUpView = false
    @State var isAlert = false
    
    var body: some View {
        VStack {
            NavigationBarView(title: "Sign In", hasBackButton: false)
            
            VStack(spacing: 30){
                Spacer()
                
                HStack {
                    TextField("email", text: $email)
                    Text("@pos.idserve.net")
                }
                SecureField("password", text: $password){
                    userModel.signIn(email: email, password: password) { result in
                        if result{
                            userModel.loadUser(id: userModel.loginId){_ in}
                        }else{
                            isAlert = true
                        }
                    }
                }
                
                Button(action: {
                    userModel.signIn(email: email, password: password) { result in
                        if result{
                            userModel.loadUser(id: userModel.loginId) { _ in}
                        }else{
                            isAlert = true
                        }
                    }
                }) {
                    Text("Sign In")
                        .frame(width: 120, height: 50)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("primary"))
                        }
                }
                
                Spacer()
                Button(action: {
                    isSignUpView = true
                }) {
                    Text("Sign Up")
                }
            }
            .padding()
        }
        .sheet(isPresented: $isSignUpView){
            SignUpView()
        }
        .alert("계정이 없습니다.", isPresented: $isAlert) {
            Text("계정이 없습니다.")
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(UserModel())
    }
}
