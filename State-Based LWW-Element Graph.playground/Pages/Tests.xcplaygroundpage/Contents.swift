//: [Previous](@previous)
import Foundation
import XCTest

class GraphTests: XCTestCase {
    var graph: Graph!

    override func setUp() {
        super.setUp()
        graph = Graph()
    }

    
    
//    /// This functions test the successful addition of the element  into the Graph
//    func testAdd() {
//        graph = Graph()
//
//        graph.add(vertex: "v1")
//        graph.add(vertex: "v2")
//        graph.add(vertex: "v3")
//        graph.add(vertex: "v4")
//
//        try? graph.add(edgeFor: ["v1", "v2"])
//        try? graph.add(edgeFor: ["v2", "v3"])
//
//        XCTAssertTrue(try graph.find(element: ["v1"]))
//        XCTAssertTrue(try graph.find(element: ["v2"]))
//        XCTAssertFalse(try graph.find(element: ["v7"]))
//
//        XCTAssertTrue(try graph.find(element: ["v1", "v2"]))
//        XCTAssertTrue(try graph.find(element: ["v2", "v3"]))
//        XCTAssertFalse(try graph.find(element: ["v4", "v3"]))
//        XCTAssertFalse(try graph.find(element: ["v1", "v5"]))
//    }
//
//    /// This function test the successful removal of the element from the Graph
//    func testRemove() {
//        graph.remove(vertex: "v1")
//        XCTAssertFalse(try graph.find(element: ["v1"]))
//
//        graph.add(vertex: "v1")
//        XCTAssertTrue(try graph.find(element: ["v1"]))
//
//        try? graph.add(edgeFor: ["v1", "v2"])
//        XCTAssertTrue(try graph.find(element: ["v1", "v2"]))
//
//        try? graph.remove(edgeFor: ["v1", "v2"])
//        try? graph.remove(edgeFor: ["v1", "v3"])
//        XCTAssertFalse(try graph.find(element: ["v1", "v2"]))
//        XCTAssertFalse(try graph.find(element: ["v1", "v3"]))
//    }
//
//    /// This function test the merge method of Graph
//    func testMerge() {
//        let graph1 = Graph()
//        let graph2 = Graph()
//
//        graph1.add(vertex: "v1")
//        graph1.add(vertex: "v2")
//        graph1.remove(vertex: "v2")
//        try? graph1.add(edgeFor: ["v1", "v2"])
//
//        graph2.add(vertex: "v1")
//        graph2.add(vertex: "v2")
//        graph2.add(vertex: "v3")
//        try? graph1.add(edgeFor: ["v1", "v3"])
//        try? graph1.add(edgeFor: ["v2", "v1"])
//
//        graph1.remove(vertex: "v2")
//
//        graph1.remove(vertex: "v3")
//
//        graph2.remove(vertex: "v1")
//        try? graph2.remove(edgeFor: ["v2", "v1"])
//
//        graph = graph1.merge(with: graph2)
//
//        XCTAssertTrue(try graph.getAddSetTime(for: ["v1"]) == graph2.getAddSetTime(for: ["v1"]))
//        XCTAssertTrue(try graph.getAddSetTime(for: ["v1"]) > graph1.getAddSetTime(for: ["v1"]))
//        XCTAssertTrue(try graph.getAddSetTime(for: ["v3"]) < graph1.getRemoveSetTime(for: ["v3"]))
//        XCTAssertTrue(try graph.getRemoveSetTime(for: ["v2", "v1"]) == graph2.getRemoveSetTime(for: ["v2", "v1"]))
//    }
//
//    /// This function test the exception handling of the add Edge
//    func testAddException() {
//        graph = Graph()
//        XCTAssertThrowsError(try graph.add(edgeFor: ["v2", "v1", "v3"])) { error in
//            XCTAssertEqual(error as! GraphError, GraphError.invalidInput)
//          }
//    }
//
//    /// This function test the exception handling of the remove Edge
//    func testRemoveException() {
//        graph = Graph()
//        XCTAssertThrowsError(try graph.add(edgeFor: [])) { error in
//            XCTAssertEqual(error as! GraphError, GraphError.invalidInput)
//          }
//    }
//
//    /// This function validates internal element timestamps
//    func testInternalTimestamps() {
//        graph = Graph()
//
//        graph.add(vertex: "v1")
//        graph.add(vertex: "v2")
//        graph.add(vertex: "v3")
//        graph.remove(vertex: "v4")
//        graph.remove(vertex: "v2")
//
//        XCTAssertTrue(try graph.getRemoveSetTime(for: ["v2"]) > graph.getAddSetTime(for: ["v2"]))
//        XCTAssertTrue(try graph.getAddSetTime(for: ["v3"]) > graph.getAddSetTime(for: ["v2"]))
//        XCTAssertTrue(try graph.getRemoveSetTime(for: ["v4"]) > graph.getAddSetTime(for: ["v1"]))
//        XCTAssertTrue(try graph.getRemoveSetTime(for: ["v4"]) < graph.getRemoveSetTime(for: ["v2"]))
//
//        try? graph.add(edgeFor: ["v2", "v1"])
//        try? graph.add(edgeFor: ["v2", "v3"])
//        try? graph.add(edgeFor: ["v1", "v3"])
//        try? graph.remove(edgeFor: ["v1", "v3"])
//        try? graph.remove(edgeFor: ["v1", "v6"])
//
//        XCTAssertTrue(try graph.getAddSetTime(for: ["v2", "v1"]) < graph.getAddSetTime(for: ["v1", "v3"]))
//        XCTAssertTrue(try graph.getAddSetTime(for: ["v2", "v3"]) > graph.getAddSetTime(for: ["v2"]))
//        XCTAssertTrue(try graph.getRemoveSetTime(for: ["v1", "v6"]) > graph.getAddSetTime(for: ["v1"]))
//        XCTAssertTrue(try graph.getRemoveSetTime(for: ["v1", "v6"]) > graph.getRemoveSetTime(for: ["v1", "v3"]))
//
//    }
//
//    /// This function validates repeated addtition of same vertex
//    func testReAddVertex() {
//        graph = Graph()
//
//        graph.remove(vertex: "v1")
//        graph.add(vertex: "v1")
//        graph.remove(vertex: "v1")
//        graph.add(vertex: "v1")
//
//        XCTAssertTrue(try graph.find(element: ["v1"]))
//    }
//
//
//    /// This function validates repeated addtition of same edge
//    func testReAddEdge() {
//        graph = Graph()
//
//        graph.add(vertex: "v1")
//        graph.add(vertex: "v2")
//        try? graph.remove(edgeFor: ["v1", "v2"])
//        try? graph.add(edgeFor: ["v1", "v2"])
//        try? graph.remove(edgeFor: ["v1", "v2"])
//        try? graph.add(edgeFor: ["v1", "v2"])
//
//        XCTAssertTrue(try graph.find(element: ["v1", "v2"]))
//    }
//
//    /// This function validates repeated removal of same vertex
//    func testReRemoveVertex() {
//        graph = Graph()
//
//        graph.add(vertex: "v1")
//        graph.remove(vertex: "v1")
//        graph.add(vertex: "v1")
//        graph.remove(vertex: "v1")
//
//        XCTAssertFalse(try graph.find(element: ["v1"]))
//    }
//
//    /// This function validates repeated removal of same edge
//    func testReRemoveEdge() {
//        graph = Graph()
//
//        graph.add(vertex: "v1")
//        graph.add(vertex: "v2")
//        try? graph.add(edgeFor: ["v1", "v2"])
//        try? graph.remove(edgeFor: ["v1", "v2"])
//        try? graph.add(edgeFor: ["v1", "v2"])
//        try? graph.remove(edgeFor: ["v1", "v2"])
//
//        XCTAssertFalse(try graph.find(element: ["v1", "v2"]))
//    }
//
//    /// This function validates remove Vertex followed by addition
//    func testRemoveAddVertex() {
//        graph = Graph()
//
//        graph.remove(vertex: "v1")
//        graph.add(vertex: "v1")
//
//        XCTAssertTrue(try graph.find(element: ["v1"]))
//    }
//
//    /// This function validates remove Eddge followed by addition
//    func testRemoveAddEdge() {
//        graph = Graph()
//
//        graph.add(vertex: "v1")
//        graph.add(vertex: "v2")
//        try? graph.remove(edgeFor: ["v1", "v2"])
//        try? graph.add(edgeFor: ["v1", "v2"])
//
//        XCTAssertTrue(try graph.find(element: ["v1", "v2"]))
//    }
//
//    /// This function validates repeated remove of element
//    func testRemoveRepeatedly() {
//        graph = Graph()
//
//        graph.remove(vertex: "v1")
//        graph.add(vertex: "v1")
//        graph.remove(vertex: "v1")
//
//        XCTAssertFalse(try graph.find(element: ["v1"]))
//
//
//        graph.add(vertex: "v1")
//        graph.add(vertex: "v2")
//        try? graph.remove(edgeFor: ["v1", "v2"])
//        try? graph.add(edgeFor: ["v1", "v2"])
//        try? graph.remove(edgeFor: ["v1", "v2"])
//
//        XCTAssertFalse(try graph.find(element: ["v1", "v2"]))
//    }
//
//    /// This function validates empty find in the Grap
//    func testEmptyFind() {
//        graph = Graph()
//        XCTAssertFalse(try graph.find(element: ["v1"]))
//    }
    
    func fuck() {
        graph = Graph()

        graph.add(vertex: "v1")
        let t1 = try? graph.getAddSetTime(for: ["v1"])
        graph.add(vertex: "v1")
        let t2 = try? graph.getAddSetTime(for: ["v1"])

        XCTAssertTrue(t1 != nil)
        XCTAssertTrue(t2 != nil)
        XCTAssertTrue((t1 ?? 0) < (t2 ?? 0))

    }
}

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}


let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)
GraphTests.defaultTestSuite.run()
