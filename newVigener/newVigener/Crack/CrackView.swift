import SwiftUI

struct CrackView: View {
    @EnvironmentObject var viewModel:CrackViewModel
    var body: some View {
        VStack {
            ScrollView {
                //               MARK: chose alphabet
                Picker("SelectLanguage", selection: self.$viewModel.chosenLanguage) {
                    ForEach(Languages.allCases, id: \.self) { language in
                        Text(language.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top)
                
//                MARK: textForUnCrypt
                Group {
                    Text("Текст для расшифровки:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                        .padding(.leading, 16)
                    TextField("Текст для расшифровки", text: self.$viewModel.textForUnCrypt, axis: .vertical)
                        .lineLimit(4)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2)
                        }
                        .padding(.horizontal, 16)
                }
                
//              MARK: buttons
                Group {
                    HStack {
                        Group {
                            Button {} label: {
                                Text("Вставить")
                            }
                            Button {} label: {
                                Text("Загрузить с файла")
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.gray.opacity(0.2)))
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    }
                    HStack {
                        Group {
                            Button {
                                
                            } label: {
                                Text("Очистить")
                            }
                            Button {
                            
                            }label: {
                                Text("Постараться Взломать")
                                    .foregroundStyle(.red)
                            }
                        }
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(.gray.opacity(0.2)))
                        .padding(.horizontal, 16)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    CrackView()
        .environmentObject(CrackViewModel())
}
