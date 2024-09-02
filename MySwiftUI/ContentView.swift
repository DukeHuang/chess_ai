//
//  ContentView.swift
//  MySwiftUI
//
//  Created by yongyou on 2024/4/2.
//

import SwiftUI

struct Park: Identifiable, Hashable {
    var id: UUID = UUID()

    let name: String
}


struct ContentView: View {


    @State var parks:[Park] = [Park(name:"xinchuan"),Park(name:"xinglonghu")]

    var body: some View {

        NavigationStack {
            List(parks) { park in
                NavigationLink(park.name, value: park)
            }
            .navigationDestination(for: Park.self) { park in
                ParkDetails(park: park)
            }
        }
    }

//    @State var navigationSplitViewStyle: any NavigationSplitViewStyle
//    var body: some View {
//        NavigationSplitView {
//            Form {
//                Text("1")
//                Text("2")
//                Text("3")
//            }
//        } content: {
//            Text("content")
//        } detail: {
//            Text("detail")
//        }
//        .navigationSplitViewStyle(.automatic)
//        .toolbar(content: {
//            Button("automatic") {
//                navigationSplitViewStyle = .automatic
//            }
//        })
//    }
}

struct ParkDetails: View {
    var park: Park

    var body: some View {

        VStack(alignment: .leading) {
            Text(park.name)
        }
    }
}

#Preview {
    ContentView(parks: [Park(name:"xinchuan"),Park(name:"xinglonghu")])
}
