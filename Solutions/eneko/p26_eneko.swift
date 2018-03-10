import NinetyNineSwiftProblems

extension List {
    /// P26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list.
    /// - complexity: O(n)
    public func combinations(group: Int) -> List<List<T>>? {
        var resultList: List<List<T>>?
        var resultListLast: List<List<T>>?
        if group > 1 {
            var current: List? = self
            var theOthers: List? = self
            while let value = current?.value {
                theOthers = theOthers?.remove(at: 0).0
                let theirCombinations = theOthers?.combinations(group: group - 1)
                var innerCurrent = theirCombinations
                while let innerList = innerCurrent?.value {
                    let myCombinations = List(value)
                    var myCombinationsLast = myCombinations
                    var currentItem: List? = innerList
                    while let innerValue = currentItem?.value {
                        let newCombinationItem = List(innerValue)
                        myCombinationsLast.nextItem = newCombinationItem
                        myCombinationsLast = newCombinationItem
                        currentItem = currentItem?.nextItem
                    }
                    let newItem = List<List<T>>(myCombinations)
                    if resultList == nil {
                        resultList = newItem
                    } else {
                        resultListLast?.nextItem = newItem
                    }
                    resultListLast = newItem
                    innerCurrent = innerCurrent?.nextItem
                }
                current = current?.nextItem
            }
        } else {
            // N groups of 1 item
            var current: List? = self
            while let value = current?.value {
                let newList = List<List<T>>(List(value))
                if resultList == nil {
                    resultList = newList
                } else {
                    resultListLast?.nextItem = newList
                }
                resultListLast = newList
                current = current?.nextItem
            }
        }
        return resultList
    }
}
