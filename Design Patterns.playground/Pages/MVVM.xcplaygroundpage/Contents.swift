//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct ToDoDetailsView: View {

    @EnvironmentObject var toDoDetailsViewModel: ToDoDetailsViewModel
    @State var toDoTitle = ""
    @State var toDoDescription = ""

    var body: some View {
        ZStack {}
            .frame(width: 300, height: 500)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text(toDoDetailsViewModel.toDo.title)
                    Text(toDoDetailsViewModel.toDo.description)

                    TextField("Title", text: $toDoTitle)
                    TextField("Description", text: $toDoDescription)

                    Button("Update Todo") {
                        updateTodo()
                    }
                }
            }.onAppear {
                setUpTodo()
            }
    }

    private func updateTodo() {
        toDoDetailsViewModel.updateTodoTitle(title: toDoTitle)
        toDoDetailsViewModel.updateDescription(description: toDoDescription)
    }

    private func setUpTodo() {
        toDoTitle = toDoDetailsViewModel.toDo.title
        toDoDescription = toDoDetailsViewModel.toDo.description
    }
}

struct Todo: Identifiable, Hashable {
    let id = UUID().uuidString
    var title: String
    var description: String
    var status: Status

    mutating func updateTitle(title: String) {
        self.title = title
    }

    mutating func updateDescription(description: String) {
        self.description = description
    }

    enum Status {
        case finished, unfinished
    }
}

class ToDoDetailsViewModel: ObservableObject {
    @Published var toDo: Todo

    init(toDo: Todo) {
        self.toDo = toDo
    }

    func updateTodoTitle(title: String) {
        toDo.updateTitle(title: title)
    }

    func updateDescription(description: String) {
        toDo.updateDescription(description: description)
    }
}

func setUpPageViewObject() -> ToDoDetailsViewModel {
    ToDoDetailsViewModel(toDo: Todo(title: "Give Dog A Bath", description: "Fido needs his bath, it's been 6 months...", status: .unfinished))
}

PlaygroundPage.current.setLiveView(ToDoDetailsView().environmentObject(setUpPageViewObject()))

//: [Next](@next)
