//
//  ContentView.swift
//  Instafilter
//
//  Created by Andrei Korikov on 09.09.2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
  @State private var image: Image?
  @State private var inputImage: UIImage?
  @State private var filterIntensity = 0.5
  @State private var showingImagePicker = false
  @State private var currentFilter = CIFilter.sepiaTone()
  
  let context = CIContext()

  var body: some View {
    let intensity = Binding<Double>(
      get: {
        filterIntensity
      },
      set: {
        filterIntensity = $0
        applyProcessing()
      }
    )
    
    return NavigationView {
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
          Slider(value: intensity)
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
    
    let beginImage = CIImage(image: inputImage)
    currentFilter.inputImage = beginImage
    applyProcessing()
  }
  
  func applyProcessing() {
    currentFilter.intensity = Float(filterIntensity)
    
    guard let outputImage = currentFilter.outputImage else {
      return
    }
    
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
      image = Image(decorative: cgimg, scale: CGFloat(1.0), orientation: .up)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
