//
//  ContentView.swift
//  randomImg
//
//  Created by Cloud Secrets on 09/05/2022.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: Image?;
    func fetchNewImage(){
        guard let url = URL(string: "https://random.imagecdn.app/500/500")else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data,_,_ in
            guard let data = data else {return}
            DispatchQueue.main.async {
                guard let uiImage =  UIImage(data: data)else{return}
                self.image = Image(uiImage: uiImage);
            }
        }
        task.resume();
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel();
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                if let image = viewModel.image{
                    image
                        .resizable()
                        .foregroundColor(Color.green)
                        .frame(width: 250, height: 250)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.green)
                        .frame(width: 250, height: 250)
                        .padding()
                }
                Spacer()
                Button(action: {
                    viewModel.fetchNewImage();
                },
                       label: {
                    Text("Get New Image")
                        .bold()
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        .padding()
                    
                })
            }
            .navigationTitle("Random Image")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
