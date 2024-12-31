//
//  ContentView.swift
//  SDTCARFDemo
//
//  Created by Stephen Beitzel on 12/30/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    var body: some View {
        MainView(store: StoreOf<Main>(
            initialState: Main.State(context: modelContext),
            reducer: { Main() }
        ))
    }
}

struct MainView: View {
    @Bindable var store: StoreOf<Main>

    var body: some View {
        NavigationStack(path: $store.navigationPath.sending(\.setNavigationPath)) {
            List(store.reports) { report in
                NavigationLink(value: report) {
                    VStack(alignment: .leading) {
                        Text(report.title)
                            .font(.headline)

                        Text(report.content)
                            .lineLimit(2)
                    }
                }
                .onTapGesture {
                    store.send(.selectReport(report))
                }
            }
            .navigationTitle("Feedback Assistant")
            .navigationDestination(item: $store.selectedReport.sending(\.selectReport),
                                   destination: { report in
                EditReportView(store: StoreOf<EditReport>(initialState: EditReport.State(report: report),
                                                          reducer: { EditReport() }))
            })
            .toolbar {
                Button("New report", systemImage: "plus", action: { store.send(.createButtonTapped) })
            }
        }
        .onAppear { store.send(.onAppear) }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FeedbackReport.self, configurations: config)

    let report = FeedbackReport(title: "Preview Report",
                                content: "Some feedback goes here",
                                priority: 2)
    container.mainContext.insert(report)

    return ContentView()
        .modelContainer(container)
}
