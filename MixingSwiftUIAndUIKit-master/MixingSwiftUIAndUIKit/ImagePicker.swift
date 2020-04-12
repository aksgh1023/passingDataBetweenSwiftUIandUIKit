//
//  ImagePicker.swift
//  MixingSwiftUIAndUIKit
//
//  Created by 박만호 on 2020/04/13.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI
struct imagePickerView : View {
    
    
    @State private var image : Image?
    @State private var showingImagePicker = false
    @State private var inputimage : UIImage?
    
    
    
    var body: some View {
        
        VStack{
            image?.resizable().scaledToFit()
            
            Button("Select Image"){
                self.showingImagePicker = true
                
            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                
                ImagePicker(image: self.$inputimage)
                
            }
            
        }
        
    }
    
    
    func loadImage(){
        
        guard let inputImage = inputimage else {return}
        image = Image(uiImage: inputImage)
        
    }
}


struct ImagePicker: UIViewControllerRepresentable {

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent : ImagePicker
        
        init(_ parent: ImagePicker){
            
            self.parent = parent
            
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                
                parent.image = uiImage
                
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    
    @Binding var image : UIImage?
    @Environment(\.presentationMode) var presentationMode
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
       
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}



