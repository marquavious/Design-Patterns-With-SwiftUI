//: [Previous](@previous)

import Foundation

let arrayOfNumbers = [1,6,4,5,3,9,43,2,7,23,10]

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
        data.reversed()
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

let forwardSortSorter = Sorter(sortStrategy: ForwardSort())
let backwardSortSorter = Sorter(sortStrategy: BackwardSort())
let randomSortSorter = Sorter(sortStrategy: RandomSort())

print(forwardSortSorter.sortData(arrayOfNumbers)) // [1, 2, 3, 4, 5, 6, 7, 9, 10, 23, 43]
print(backwardSortSorter.sortData(arrayOfNumbers)) // [10, 23, 7, 2, 43, 9, 3, 5, 4, 6, 1]
print(randomSortSorter.sortData(arrayOfNumbers)) // [43, 23, 6, 9, 1, 2, 10, 7, 4, 3, 5] (Random)

//: [Next](@next)
