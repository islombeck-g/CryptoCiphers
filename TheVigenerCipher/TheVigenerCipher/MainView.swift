import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack{
            Spacer().frame(height: 10)
            
            ScrollView {
                
                Group {
                    CreateTextFile(text: $viewModel.encryptText_result)
                    LoadTxtFile(result: $viewModel.textForCrypt)
                }
                
                Group {
                    
                    Picker("Tip percentage", selection: $viewModel.language) {
                        ForEach(viewModel.languages, id: \.self) { i in Text(i) }
                    }
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .pickerStyle(.segmented)
                }
                
                Group {
                    
                    Spacer().frame(height: 30)
                    
                    Text("Текст для шифрования:")
                        .padding(.horizontal, 8)
                        .background(Color("LightGray"))
                        .clipShape(.rect(cornerRadius: 8))
                    
                    MultilineTextField(text: $viewModel.textForCrypt)
                }
                
                Group {
                    
                    Spacer().frame(height: 30)
                    
                    Text("Ключ")
                        .padding(.horizontal, 8)
                        .background(Color("LightGray"))
                        .clipShape(.rect(cornerRadius: 8))
                    
                    TextField("Ведите ключ", text: $viewModel.keyForCrypt)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color("DarkGray")))
                        .padding(.horizontal, 16)
                    
                    Spacer().frame(height: 30)
                }
                
                Group {
                    HStack {
                        
                        Spacer().frame(width: 16)
                        
                        Button {
                            UIPasteboard.general.string = viewModel.encryptText_result
                        } label: {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 9)
                                    .frame(width: UIScreen.main.bounds.size.width/2 - 10, height: 40)
                                    .foregroundColor(Color("LightGray"))
                                
                                Text("Kопировать текст")
                            }
                        }
                        
                        Spacer()
                        
                        Button { 
                            self.viewModel.crypt()
                        } label: {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 9)
                                    .frame(
                                        width: UIScreen.main.bounds.size.width/2 - 10,
                                        height: 40)
                                    .foregroundColor(Color("LightGray"))
                                
                                Text("Зашифровать")
                            }
                        }
                        
                        Spacer().frame(width: 16)
                    }
                    
                    HStack {
                        
                        Spacer().frame(width: 16)
                        
                        Button {
                            self.viewModel.clearAll()
                        } label: {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 9)
                                    .frame(
                                        width: UIScreen.main.bounds.size.width/2 - 10,
                                        height: 40)
                                    .foregroundColor(Color("LightGray"))
                                
                                Text("Очистить все поля")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Button {
                            self.viewModel.uncrypt()
                        } label: {
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 9)
                                    .frame(
                                        width: UIScreen.main.bounds.size.width/2 - 10,
                                        height: 40)
                                    .foregroundColor(Color("LightGray"))
                                
                                Text("Расшифровать")
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer().frame(width: 16)
                    }
                }
                
                Group {
                    if self.viewModel.encryptText_result != "" {
                        
                        Text(self.viewModel.encryptText_result)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                            .padding(.horizontal, 16)
                    }
                    
                    if self.viewModel.errorMessage != "" {
                       
                        Text(self.viewModel.errorMessage)
                            .padding()
                            .foregroundStyle(.red)
                    }
                }
                Group {
                    if self.viewModel.uncryptResult != "" {
                        
                        Text(self.viewModel.uncryptResult)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
                            .padding(.horizontal, 16)
                    }
                    if self.viewModel.uncryptErrorMessage != "" {
                        
                        Text(self.viewModel.uncryptErrorMessage)
                            .padding()
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
