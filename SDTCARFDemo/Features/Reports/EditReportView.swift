//
//  EditReportView.swift
//  SDTCARFDemo
//
//  Created by Stephen Beitzel on 12/30/24.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct EditReportView: View {
    @Bindable var store: StoreOf<EditReport>

    var body: some View {
        Form {
            TextField("Issue title", text: $store.report.title.sending(\.setTitle))
            TextField("Issue description", text: $store.report.content.sending(\.setDescription), axis: .vertical)

            Picker("Priority", selection: $store.report.priority.sending(\.setPriority)) {
                Text("Low").tag(3)
                Text("Medium").tag(2)
                Text("High").tag(1)
            }
        }
        .navigationTitle("Edit Report")
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FeedbackReport.self, configurations: config)

    let report = FeedbackReport(title: "Preview Report",
                                content: "Some feedback goes here",
                                priority: 2)
    container.mainContext.insert(report)

    return EditReportView(store: StoreOf<EditReport>(
        initialState: EditReport.State(report: report),
        reducer: { EditReport() }))
        .modelContainer(container)
}
