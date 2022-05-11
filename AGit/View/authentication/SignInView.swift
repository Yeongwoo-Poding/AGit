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
        NavigationView {
            ZStack {
                Color("Background")
                
                VStack(spacing: 20){
                    Spacer()
                    
                    HStack {
                        TextField("email", text: $email)
                        Text("@pos.idserve.net")
                    }
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("Secondary"))
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
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("Secondary"))
                    }
                    
                    Button(action: {
                        userModel.signIn(email: email, password: password) { result in
                            if result{
                                userModel.loadUser(id: userModel.loginId){_ in}
                            }else{
                                isAlert = true
                            }
                        }
                    }) {
                        Text("Sign In")
                            .foregroundColor(Color("Black"))
                            .padding()
                            .padding(.horizontal)
                            .background{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("Primary"))
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
            .navigationTitle("Sign In")
        }
        .sheet(isPresented: $isSignUpView){
            SignUpView()
        }
        .alert("계정이 없습니다.", isPresented: $isAlert) {
            Text("계정이 없습니다.")
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("White"))
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(UserModel())
    }
}
