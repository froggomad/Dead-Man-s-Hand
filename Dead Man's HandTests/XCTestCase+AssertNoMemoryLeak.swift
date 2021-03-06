//
//  XCTestCase+AssertNoMemoryLeak.swift
//  Dead Man's HandTests
//
//  Created by Kenneth Dubroff on 8/25/21.
//

import XCTest

extension XCTestCase {
    // Credit: https://www.essentialdeveloper.com/
    func assertNoMemoryLeak(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential retain cycle.", file: file, line: line)
        }
    }
}
