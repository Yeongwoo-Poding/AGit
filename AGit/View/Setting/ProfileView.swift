//
//  ProfileView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userModel: UserModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    @State var isAddingTag = false
    @State var isDeletingTag = false
    @State var isAddingLink = false
    @State var addTag = ""
    
    var body: some View {
        VStack {
            ZStack {
                Color("Background")
                
                if let user = userModel.user{
                    VStack{
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(user.isStudying ? Color("Primary") : Color("Secondary"))
                                    .frame(width: screenWidth/2.5)
                                
                                Image("defaultImage")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: screenWidth/3)
                            }
                            
                            VStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Secondary"))
                                        .frame(height: 50)
                                    
                                    VStack {
                                        Text("오늘 공부 시간")
                                        
                                        Text(secondToTime(second: user.todayStudyTime))
                                    }
                                }
                                
                                Spacer().frame(height: 15)
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Secondary"))
                                        .frame(height: 50)
                                    
                                    VStack {
                                        Text("평균 공부 시간")
                                        
                                        Text(secondToTime(second: user.totalStudyTime/user.days))
                                    }
                                }
                            }
                        }
                        .frame(height: 200)
                        
                        ScrollView(.horizontal){
                            HStack{
                                if user.tags != nil{
                                    ForEach(user.tags!, id: \.self){ tag in
                                        ZStack(alignment: .leading) {
                                            Text(tag)
                                                .padding(.vertical, 10)
                                                .padding(.horizontal)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .foregroundColor(Color("Secondary"))
                                                }
                                                .onTapGesture {
                                                    isDeletingTag = true
                                                }
                                            
                                            if isDeletingTag{
                                                Button(action: {
                                                    userModel.deleteUserTag(tag: tag)
                                                }) {
                                                    Image(systemName: "x.circle.fill")
                                                        .background(Color("Secondary"))
                                                }
                                                .offset(x: 7)
                                            }
                                        }
                                    }
                                }
                                
                                if isAddingTag{
                                    HStack {
                                        Text("#")
                                        TextField("태그", text: $addTag){
                                            userModel.addUserTag(tag: addTag)
                                            addTag = ""
                                            isAddingTag = false
                                        }
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background{
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(Color("Secondary"))
                                    }
                                }else{
                                    if !isDeletingTag{
                                        Button(action: {
                                            isAddingTag = true
                                        }) {
                                            Text(" 태그 추가 ")
                                                .padding(.vertical, 10)
                                                .padding(.horizontal)
                                                .background{
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .foregroundColor(Color("Secondary"))
                                                }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        if isDeletingTag {
                            Button(action: {
                                isDeletingTag = false
                            }) {
                                Text("완료")
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 30)
                                    .background{
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(Color("Secondary"))
                                    }
                            }
                            .frame(height: 50)
                        }else{
                            Spacer().frame(height: 65)
                        }
                        
                        HStack{
                            Text("Links")
                            
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        
                        ScrollView{
                            VStack(spacing: 5){
                                if user.links != nil{
                                    ForEach(user.links!, id: \.self){ link in
                                        HStack{
                                            Button(action: {
                                                print(link.linkUrl)
                                                openURL(URL(string: link.linkUrl)!)
                                            }) {
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .frame(width: screenWidth*4/5, height: 30)
                                                        .foregroundColor(Color("Secondary"))
                                                    Text(link.linkDescription)
                                                }
                                            }
                                            
                                            Button(action: {
                                                userModel.deleteUserLink(linkUrl: link.linkUrl)
                                            }) {
                                                Image(systemName: "x.circle.fill")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            isAddingLink = true
                        }) {
                            Text("Add Link")
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background{
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color("Secondary"))
                                }
                        }
                        .sheet(isPresented: $isAddingLink) {
                            AddLinkView(isAddingLink: $isAddingLink)
                        }
                    }
                    .padding()
                }
                
            }
            
            Color.black
                .frame(height: 5)
        }
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("White"))
        .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {  presentationMode.wrappedValue.dismiss() }, label: {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color("White"))

                        Text("Back")
                            .foregroundColor(Color("White"))
                    }
                })
            )
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserModel())
    }
}
