//
//  Onboarding2.swift
//  Bloomy
//
//  Created by Wilton Ramos on 02/03/21.
//

import SwiftUI

struct Onboarding2: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var textFieldInput = ""
    
    func setUser() {
        let userName = textFieldInput
        if (UserManager.shared.getUser() != nil) {
            _ = UserManager.shared.deleteUser()
            _ = UserManager.shared.newUser(withName: userName)
        } else {
            _ = UserManager.shared.newUser(withName: userName)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack() {
                
                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image("botao_back")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                }.frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                Spacer()
                    .frame(height: geometry.size.height * 0.03)
                
                Text("Como posso te chamar?")
                    .font(.custom("Poppins-Medium", size: 30))
                    .foregroundColor(Color("cor_fonte"))
                    .padding(.trailing)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                TextField("Aninha", text: $textFieldInput)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                Rectangle()
                    .background(Color("cor_fonte"))
                    .opacity(0.4)
                    //.position(x: geometry.size.width * 0.30)
                    .frame(width: geometry.size.width * 0.9, height: 3, alignment: .leading) //0.75
                
                Spacer()
                
                if textFieldInput == "" {
                    Button(action: {}) {
                        Text("continuar")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color("cor_fonte"))
                            .padding(.vertical, geometry.size.height * 0.02)
                            .padding(.horizontal, geometry.size.width * 0.15)
                    }
                    .background(Color("cor_botao"))
                    .opacity(0.2)
                    .clipShape(Capsule())
                    .disabled(true)
                } else {
                    NavigationLink(
                        destination: Onboarding3().onAppear(perform: {
                            self.setUser()
                            print(UserManager.shared.getUserName()!)
                        }),
                        label: {
                            Text("continuar")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(Color("cor_fonte"))
                                .padding(.vertical, geometry.size.height * 0.02)
                                .padding(.horizontal, geometry.size.width * 0.15)
                        })
                        .background(Color("cor_botao"))
                        .clipShape(Capsule())
                }
                
            }
            .padding(.bottom, geometry.size.height * 0.05)
            .padding(.top, geometry.size.height * 0.025)
            .frame(width: geometry.size.width)
            
        }.background(Color("cor_fundo").edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}

struct Onboarding2_Previews: PreviewProvider {
    static var previews: some View {
        
        Onboarding2()
        Onboarding2()
            .previewDevice("iPhone 12 Pro Max")
        Onboarding2()
            .previewDevice("iPod touch (7th generation)")
    }
}
