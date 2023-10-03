import SwiftUI

struct FirstView: View {
    @StateObject private var viewModel = FirstViewModel()
    
    @State private var languages:[String] = ["EN", "RU"]
    @State private var textForCrypt:String = ""
    @State private var keyForCrypt:String = ""
    
    var body: some View {
        ScrollView {
            Group {
                
                Spacer()
                    .frame(height: 40)
                
                Picker("Tip percentage", selection: $viewModel.language) {
                    ForEach(languages, id: \.self) { i in Text(i) }
                }
                .frame(width: UIScreen.main.bounds.width - 32)
                .pickerStyle(.segmented)
                
                Spacer()
                    .frame(height: 25)
            }
            Group {
                HStack {
                    
                    Text("Текст для шифрования:")
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                .background(Color("gray"))
                .cornerRadius(4)
                .padding(.horizontal, 16)
                
                MultilineTextField(text: $textForCrypt)
                
                Spacer().frame(height: 25)
            }
            Group {
                HStack{
                    
                    Text("Ключ:")
                        .padding(.horizontal, 16)
                    
                    Spacer()
                }
                    .background(Color("gray"))
                    .cornerRadius(4)
                    .padding(.horizontal, 16)

                TextField("Ведите ключ", text: $keyForCrypt)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color("darkGray")))
                    .padding(.horizontal, 16)
                
                Spacer().frame(height: 20)
            }
            Group {
                HStack {
                    
                    Spacer().frame(width: 16)
                    
                    Button { UIPasteboard.general.string = viewModel.result }
                    label: {
                        Text("Kопировать текст")
                            .foregroundColor(.black)
                            .padding(.all, 8)
                            .background(Color("gray"))
                            .cornerRadius(4)
                    }
                    
                    Spacer()
                    
                    Button { self.viewModel.crypt(textForCrypt, key1: keyForCrypt) }
                    label: {
                            Text("Зашифровать")
                                .foregroundColor(.blue)
                                .padding(.all, 8)
                                .background(Color("gray"))
                                .cornerRadius(4)
                    }
                    
                    Spacer().frame(width: 16)
                }
                HStack {
                    
                    Spacer().frame(width: 16)
                    
                    Button {
                        self.viewModel.language = "EN"
                        self.viewModel.errorMessage = ""
                        self.viewModel.result = ""
                        self.textForCrypt = ""
                        self.keyForCrypt = ""
                        self.viewModel.uncryptResult = ""
                        self.viewModel.uncryptErrorMessage = ""
                    } label: {
                        Text("Очистить все поля")
                            .foregroundColor(.red)
                            .padding(.all, 8)
                            .background(Color("gray"))
                            .cornerRadius(4)
                    }
                    
                    Spacer()
                    
                    Button { self.viewModel.uncrypt(self.viewModel.result, nkey: self.keyForCrypt) }
                    label: {
                        Text("Расшифровать")
                            .foregroundColor(.blue)
                            .padding(.all, 8)
                            .background(Color("gray"))
                            .cornerRadius(4)
                    }
                    
                    Spacer().frame(width: 16)
                }
            }
            Group {
                HStack {
                    if viewModel.resultIsReady == true {
                        Text(viewModel.result)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                                .padding(.horizontal, 16)
                    
                        Spacer()
                    }
                    
                    if viewModel.errorMessage != "" {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    }
                }
            }
            
            Spacer().frame(height: 10)
            
            Group {
                HStack {
                    if viewModel.uncryptIsReady == true {
                        Text(viewModel.uncryptResult)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                            .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                }
                
                if viewModel.uncryptErrorMessage != "" {
                    Text(viewModel.uncryptErrorMessage)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
