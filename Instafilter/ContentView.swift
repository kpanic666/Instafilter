//
//  ContentView.swift
//  Instafilter
//
//  Created by Andrei Korikov on 09.09.2021.
//

import SwiftUI

struct ContentView: View {
  @State private var image: Image?
  @State private var inputImage: UIImage?
  @State private var filterIntensity = 0.5
  @State private var showingImagePicker = false

  var body: some View {
    NavigationView {
      VStack {
        ZStack {
          Rectangle()
            .fill(Color.secondary)
          
          if image != nil {
            image?
              .resizable()
              .scaledToFit()
          } else {
            Text("Tap to select a picture")
              .font(.title2)
              .foregroundColor(Color.white)
          }
        }
        .onTapGesture {
          showingImagePicker = true
        }
        
        HStack {
          Text("Intensity")
          Slider(value: $filterIntensity)
        }
        .padding(.vertical)
        
        HStack {
          Button("Change Filter") {
            //
          }
          
          Spacer()
          
          Button("Save") {
            //
          }
        }
        
      }
      .padding([.leading, .bottom, .trailing])
      .navigationBarTitle("Instafilter")
      .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
        ImagePicker(image: $inputImage)
      })
    }
  }
  
  func loadImage() {
    guard let inputImage = inputImage else {
      return
    }
    image = Image(uiImage: inputImage)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
