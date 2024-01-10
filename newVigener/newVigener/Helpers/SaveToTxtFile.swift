import SwiftUI

struct SaveToTxtFile: View {
    
    @Binding var text: String?
    @State private var isShowingFilePicker = false
    
    var body: some View {
            Button { isShowingFilePicker.toggle() }
            label: {
                Text("Сохранить в файл")
            }
            .fileImporter(isPresented: $isShowingFilePicker, allowedContentTypes: [.plainText]) { result in
                do {
                    let url = try result.get()
                    try text!.write(to: url, atomically: true, encoding: .utf8)
                } catch { print("Ошибка при сохранении файла: \(error.localizedDescription)") }
            }
        
    }
}

#Preview {
    SaveToTxtFile(text: .constant("someValue"))
}
