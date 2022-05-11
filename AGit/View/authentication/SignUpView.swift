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
        NavigationView {
            ZStack {
                Color("Background")
                
                VStack(spacing: 20){
                    TextField("nickname", text: $nickname)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("Secondary"))
                        }
                    
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
                        userModel.signUp(nickname: nickname, email: email, password: password) { result in
                            if result{
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("Secondary"))
                    }
                    
                    Button(action: {
                        userModel.signUp(nickname: nickname, email: email, password: password) { result in
                            if result{
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        Text("Sign Up")
                            .foregroundColor(Color("Black"))
                            .padding()
                            .padding(.horizontal)
                            .background{
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("Primary"))
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Sign Up")
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("White"))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(UserModel())
    }
}
