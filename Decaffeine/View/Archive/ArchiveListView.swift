//
// ContentView.swift
// coffeeearchive
//
// Created by Sahar Asad Osmani on 15/2/2023.
//

import SwiftUI

struct ArchiveListView: View {
    //MARK: - PROPERTIES
    @StateObject var viewModel : ArchiveViewModel

    var beverage : SelectedBeverage
    var title: String
    var size: String
    var numberOfShots: Double
    var date: Date
    var image : String
    
    @State private var isDetailViewPresented = false
    
    //MARK: - BODY
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top, spacing: 5) {
                Text(viewModel.formatTime(time: date))
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .offset(y: 4)
                    .frame(maxWidth: 80,
                           alignment: .topLeading)
                
                HStack {
                    VStack{
                        Text(title)
                            .font(.system(size: 14).bold())
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .padding(.bottom, 16)
                        
                        Text(size)
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .padding(.bottom, 5)
                        
                        Text("\(String(format: "%.1f", numberOfShots)) Shots")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                }
                .padding(15)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("mainColor")))
                .onTapGesture {
                    isDetailViewPresented.toggle()
                }

            }
        }
        .fullScreenCover(isPresented: $isDetailViewPresented) {
            ArchiveListDetailView(viewModel: viewModel, beverage: beverage, day: date , date: date, time: date, month: date, detailImage: image, detailName: title)
        }
    }
    
    func formattedTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
}

//struct ArchiveListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        let time = dateFormatter.date(from: "11:35") ?? Date()
//        return ArchiveListView(beverage: SelectedBeverage(), title: "Cappuccino", size: "Large", numberOfShots: 2, date: time, image: "")
//    }
//}

