import SwiftUI

struct CreateTextFile: View {

    @Binding var text: String
    @State private var isShowingFilePicker = false
    
    var body: some View {
        VStack(spacing: 16) {

            Button { isShowingFilePicker.toggle() }
            label: {
                Text("Сохранить в файл")
                    .foregroundColor(.black)
                    .padding(.all, 8)
                    .background(Color("gray"))
                    .cornerRadius(4)
            }
            .fileImporter(isPresented: $isShowingFilePicker, allowedContentTypes: [.plainText]) { result in
                do {
                    
                    let url = try result.get()
                    try text.write(to: url, atomically: true, encoding: .utf8)
                } catch { print("Ошибка при сохранении файла: \(error.localizedDescription)") }
            }
        }
    }
}

#Preview {
    CreateTextFile(text: .constant("someValue"))
}
