//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct IPhoneView<Content: View>: View {
    let content: Content
    let multiplier: CGFloat

    init(multiplier: CGFloat = 2, @ViewBuilder content: () -> Content) {
        self.multiplier = multiplier
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 250 * multiplier, height: 500 * multiplier)
                .background(Color(red: 64 / 255, green: 64 / 255, blue: 70 / 255))
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: 220 * multiplier, height: 450 * multiplier)
                .overlay(alignment: .center) {
                    content
                }
        }
    }

}

struct ToDoObject: Identifiable, Hashable {
    let id = UUID().uuidString
    var title: String
    var status: Status

    mutating func updateStatus(status: Status) {
        self.status = status
    }

    enum Status {
        case finished, unfinished
    }
}

struct ToDoDetailsView: View {

    @EnvironmentObject var toDoDetailsViewModel: ToDoDetailsViewModel
    @FocusState private var textFieldInFocus: Bool
    @State var newTodoTitle = ""

    var body: some View {
        IPhoneView {
            VStack {
                List {
                    ForEach(toDoDetailsViewModel.todos) { todo in
                        VStack(alignment: .leading) {
                            Text(todo.title)
                        }
                    }
                    .onDelete { indexSet in
                        toDoDetailsViewModel.deleteTodo(indexSet: indexSet)
                    }
                }

                VStack(spacing: 16) {
                    TextField("New todo...", text: $newTodoTitle)
                        .onSubmit {
                            addTodoObject(toDoTitle: newTodoTitle)
                        }
                        .focused($textFieldInFocus)
                    Color.gray
                        .opacity(0.5)
                        .frame(minWidth: 1, maxHeight: 1)
                    Button("Add Todo") {
                        addTodoObject(toDoTitle: newTodoTitle)
                    }
                    .disabled(newTodoTitle.isEmpty)
                }
                .padding(20)
            }
        }
    }

    private func addTodoObject(toDoTitle: String) {
        let toDoObject = ToDoObject(title: toDoTitle, status: .unfinished)
        toDoDetailsViewModel.addTodo(todo: toDoObject)
        newTodoTitle = ""
        textFieldInFocus = true
    }
}

class ToDoDetailsViewModel: ObservableObject {
    @Published var todos: [ToDoObject]

    init(todos: [ToDoObject]) {
        self.todos = todos
    }

    func addTodo(todo: ToDoObject) {
        todos.append(todo)
    }

    func deleteTodo(indexSet: IndexSet) {
        todos.remove(atOffsets: indexSet)
    }
}

let fakeToDoDetailsViewModel = ToDoDetailsViewModel(
    todos: [
        ToDoObject(title: "Give Dog A Bath", status: .finished),
        ToDoObject(title: "Make playground for concurrency", status: .unfinished),
        ToDoObject(title: "Make project to demonstrate SwiftUI", status: .unfinished)
    ]
)

PlaygroundPage.current.setLiveView(ToDoDetailsView().environmentObject(fakeToDoDetailsViewModel))

//: [Next](@next)
