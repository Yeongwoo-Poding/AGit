//
//  AddLinkView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/09.
//

import SwiftUI

struct AddLinkView: View {
    @EnvironmentObject var userModel: UserModel
    
    @Binding var isAddingLink: Bool
    
    @State var linkType = ""
    @State var linkDescription = ""
    @State var linkUrl = ""
    
    var body: some View {
        VStack{
            NavigationBarView(title: "Add Link", hasBackButton: true)
            
            Spacer()
            
            VStack(spacing: 30){
                TextField("type", text: $linkType)
                TextField("description", text: $linkDescription)
                TextField("url", text: $linkUrl){
                    userModel.addUserLink(linkType: linkType, linkDescription: linkDescription, linkUrl: linkUrl)
                    isAddingLink = false
                }
                
                Button(action: {
                    userModel.addUserLink(linkType: linkType, linkDescription: linkDescription, linkUrl: linkUrl)
                    isAddingLink = false
                }) {
                    Text("Submit")
                        .frame(width: 120, height: 50)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("primary"))
                        }
                }
            }
            .padding()
            
            Spacer()
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
    }
}

struct AddLinkView_Previews: PreviewProvider {
    static var previews: some View {
        AddLinkView(isAddingLink: .constant(true))
            .environmentObject(UserModel())
    }
}
