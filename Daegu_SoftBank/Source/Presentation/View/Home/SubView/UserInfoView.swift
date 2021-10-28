//
//  UserInfoView.swift
//  Daegu_SoftBank
//
//  Created by 박세은 on 2021/10/09.
//

import SwiftUI

struct UserInfoView: View {
    var profileImage: String?
    var name: String
    
    var body: some View {
        HStack {
            if let profileImage = profileImage {
                URLImage(withURL: profileImage)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipped()
                    .clipShape(Circle())
            }
            else {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(Color(.secondarySystemFill))
            }
            
            Text(name)
                .font(.title3)
                .bold()
            
            Spacer()
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(profileImage: nil, name: "로미")
    }
}
