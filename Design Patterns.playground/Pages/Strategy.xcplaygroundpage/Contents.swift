//: [Previous](@previous)

import Foundation
import SwiftUI
import PlaygroundSupport

protocol SortStrategy {
    func sort(_ data: [Int]) -> [Int]
}

class ForwardSort: SortStrategy {
    func sort(_ data: [Int]) -> [Int] {
        data.sorted()
    }
}

class BackwardSort: SortStrategy {
    func sort(_ data: [Int]) -> [Int] {
        data.sorted().reversed()
    }
}

class RandomSort: SortStrategy {
    func sort(_ data: [Int]) -> [Int] {
        data.shuffled()
    }
}

class Sorter {
    private var sortStrategy: SortStrategy

    init(sortStrategy: SortStrategy) {
        self.sortStrategy = sortStrategy
    }

    func sortData(_ data: [Int]) -> [Int] {
        return sortStrategy.sort(data)
    }
}

enum SortingStrategy: Int, CaseIterable, Equatable, Hashable {
    case forwardSort = 0
    case backwardSort
    case randomSort

    var title: String {
        switch self {
        case .forwardSort:
            "Forward Sort"
        case .backwardSort:
            "Backward Sort"
        case .randomSort:
            "Random Sort"
        }
    }
}

struct ContentView: View {

    @State var numbers = [1, 2, 3, 4, 5, 6]
    @State var newNumberText = String()
    @FocusState private var textFieldInFocus: Bool
    @State private var selectedSortingStrategy: SortingStrategy = .forwardSort

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        IPhoneView {
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(numbers, id: \.self) { number in
                            Text(String(number))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 50)
                                .background(.red, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                    }
                    .padding(10)
                }

                Spacer()

                VStack(spacing: 16) {
                    Text("Pick a Sorting Algorithim")
                    Picker(String(), selection: $selectedSortingStrategy) {
                        Text(SortingStrategy.forwardSort.title).tag(SortingStrategy.forwardSort)
                        Text(SortingStrategy.backwardSort.title).tag(SortingStrategy.backwardSort)
                        Text(SortingStrategy.randomSort.title).tag(SortingStrategy.randomSort)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedSortingStrategy) {
                        sortNumbers()
                    }

                    TextField("Add Number", text: $newNumberText)
                        .onSubmit {
                            guard
                                let newNumber = Int(newNumberText),
                                !numbers.contains(newNumber) else { return }
                            addNumer(int: newNumber)
                            sortNumbers()
                        }
                        .focused($textFieldInFocus)
                        .keyboardType(.numberPad)

                    Color.gray
                        .opacity(0.5)
                        .frame(minWidth: 1, maxHeight: 1)
                    Button("Add Number") {
                        guard
                            let newNumber = Int(newNumberText),
                            !numbers.contains(newNumber) else { return }
                        addNumer(int: newNumber)
                        sortNumbers()
                    }
                    .disabled(newNumberText.isEmpty)
                }
                .padding(20)
            }
        }
    }

    func addNumer(int: Int) {
        numbers.append(int)
        sortNumbers()
        newNumberText = String()
        textFieldInFocus = true
    }

    func sortNumbers() {
        switch selectedSortingStrategy {
        case .forwardSort:
            numbers = Sorter(sortStrategy: ForwardSort()).sortData(numbers)
        case .backwardSort:
            numbers = Sorter(sortStrategy: BackwardSort()).sortData(numbers)
        case .randomSort:
            numbers = Sorter(sortStrategy: RandomSort()).sortData(numbers)
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
//: [Next](@next)
