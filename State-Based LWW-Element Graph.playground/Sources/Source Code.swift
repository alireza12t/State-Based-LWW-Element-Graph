import UIKit

/// Error enums to throw in occasions that needed to throw error instead of returning the result or do sth
public enum GraphError: Error {
    case vertexIsNotAvailable
    case indexOutOfRange
    case elementNotAvailable
    case invalidInput
    case unknownError
}

/// This is the object used for adding to Add-Set and Remove-Set with a time which let us compare the time the element added or removed
public class Element: NSObject {
    var time: TimeInterval
    var value: [String]
    
    public override var description: String {
        var descriptionText = ""
        switch value.count {
        case 1:
            descriptionText += "Vertex \(self.value.first!)"
        case 2:
            descriptionText += "Edge (\(self.value[0]), \(self.value[1]))"
        default:
            descriptionText += "\(self.value)"
        }
        descriptionText += " ---- time = \(self.time)"
        return descriptionText
    }
    
    /// create  the element with the time it added to Set
    /// - Parameter value: the list of vertices which represents edges or vertices of Graph and is going to store in Set
    init(value: [String]) {
        self.time = Date().timeIntervalSince1970
        self.value = value
    }
}


/// This keeps a list of vertices which represents the path between first vertex and last vertex
public class Path: NSObject {
    var pathVertices: [String] = []
    
    public override var description: String {
        var descriptionText = "Path -> "
        for vertex in self.pathVertices {
            descriptionText += vertex + " "
        }
        return descriptionText
    }
}

public class Graph {
    public var addSet: [Element] = []
    public var removeSet: [Element] = []
    
    public init() { }
    
    public func getAddSetTime(for value: [String]) throws -> TimeInterval {
        if let index = addSet.map({ $0.value }).firstIndex(of: value) {
            return addSet[index].time
        } else {
            throw GraphError.elementNotAvailable
        }
    }
    
    public func getRemoveSetTime(for value: [String]) throws -> TimeInterval {
        if let index = removeSet.map({ $0.value }).firstIndex(of: value) {
            return removeSet[index].time
        } else {
            throw GraphError.elementNotAvailable
        }
    }
    
    private func add(element: Element) {
        if let index = addSet.map({ element in
            element.value
        }).firstIndex(of: element.value) {
            addSet[index] = element
        } else {
            addSet.append(element)
        }
    }
    
    private func remove(element: Element) {
        if let index = removeSet.map({ element in
            element.value
        }).firstIndex(of: element.value) {
            removeSet[index] = element
        } else {
            removeSet.append(element)
        }
    }
    
    /// This method check whether a given element is in Graph
    /// - Parameter element: Element whose presence is the checked in Graph
    /// - Returns: Boolean
    
    
    
    /// This method check whether a given element is in Graph
    /// - Parameter element: Element whose presence is the checked in Graph
    /// - Throws: If an unexpected situation happens it throws error for handling the error
    /// - Returns: Boolean
    public func find(element: [String]) throws -> Bool{
        if !(addSet.map({ $0.value }).contains(element)) {
            // Element not in Add-Set
            return false
        }
        
        if !(removeSet.map({ $0.value }).contains(element)) {
            // Element in Add-Set and not in Remove-Set
            return true
        }
        
        guard let removeElementIndex = removeSet.map({ $0.value }).firstIndex(of: element) else { throw GraphError.elementNotAvailable }
        guard let addElementIndex = addSet.map({ $0.value }).firstIndex(of: element) else { throw GraphError.elementNotAvailable }
        
        if removeSet[removeElementIndex].time < addSet[addElementIndex].time {
            // Element in both Add-Set and Remove-Set, but addition is after removal
            return true
        }
        // Element in both Add-Set and Remove-Set, but addition is before removal
        return false
    }
    
    /// Add vertex to Add-Set or update the time of added element if it exists in Add-Set
    /// - Parameter vertex: The vertex to append to Add-Set
    public func add(vertex: String) {
        let element = Element(value: [vertex])
        add(element: element)
    }
    
    /// Add vertex to Remove-Set or update the time of added element if it exists in Remove-Set
    /// - Parameter vertex: The vertex to append to Remove-Set
    public func remove(vertex: String) {
        let element = Element(value: [vertex])
        remove(element: element)
    }
    
    /// Add edge to Add-Set or update the time of added element if it exists in Add-Set
    /// - Parameter vertices: The vertices that connected by the edge to append to Add-Set
    public func add(edgeFor vertices: [String]) throws{
        if vertices.count == 2 {
            let element = Element(value: vertices)
            add(element: element)
        } else {
            throw GraphError.invalidInput
        }
    }
    
    /// Add edge to Remove-Set or update the time of added element if it exists in Remove-Set
    /// - Parameter vertices: The vertices that connected by the edge to append to Remove-Set
    public func remove(edgeFor vertices: [String]) throws{
        if vertices.count == 2 {
            let element = Element(value: vertices)
            remove(element: element)
        } else {
            throw GraphError.invalidInput
        }
    }
    
    /// This function gives us a list of vertices in the Graph
    /// - Returns: List of all vertices in the graph
    func getVertices() -> [String] {
        let addVertices = addSet.filter { $0.value.count == 1 }
        let removeVertices = removeSet.filter { $0.value.count == 1 }
        var vertices = [String]()
        
        for element in addVertices {
            if let index = removeVertices.map({ $0.value }).firstIndex(of: element.value) {
                if removeVertices[index].time < element.time {
                    if let vertex = element.value.first {
                        vertices.append(vertex)
                    }
                }
            } else {
                if let vertex = element.value.first {
                    vertices.append(vertex)
                }
            }
        }
        return vertices
    }
    
    /// This function creates a dictionary of Graph vertices which have the vertices that they are connected with
    /// - Returns: The adjacency Dictionary that represents the Graph vertices and edges between them
    func getAdjacencyMatrix() -> [String : [String]] {
        var adjacencyDictionary: [String : [String]] = [ : ]
        let vertices = getVertices()
        for vertex in vertices {
            adjacencyDictionary[vertex] = []
        }
        
        let addEdges = addSet.filter { $0.value.count == 2 }
        let removeEdges = removeSet.filter { $0.value.count == 2 }
        
        for element in addEdges {
            if let index = removeEdges.map({ $0.value }).firstIndex(of: element.value) {
                if removeEdges[index].time < element.time {
                    let v1 = element.value[0]
                    let v2 = element.value[1]
                    
                    if vertices.contains(v1) && vertices.contains(v2) {
                        adjacencyDictionary[v1]?.append(v2)
                        adjacencyDictionary[v2]?.append(v1)
                    }
                }
            } else {
                let v1 = element.value[0]
                let v2 = element.value[1]
                
                if vertices.contains(v1) && vertices.contains(v2) {
                    adjacencyDictionary[v1]?.append(v2)
                    adjacencyDictionary[v2]?.append(v1)
                }
            }
        }
        return adjacencyDictionary
    }
    
    /// Returns the list of vertices that connected to a vertex of a Graph
    /// - Parameter vertex: the given vertex to check the connected vertices
    /// - Throws: If the vertex is not in the graph, throw vertexIsNotAvailable GraphError
    /// - Returns: list of vertices that are connected to a vertex directly
    public func getConnectedVertices(to vertex: String) throws -> [String] {
        if try find(element: [vertex]) {
            let adjMatrix = getAdjacencyMatrix()
            if let vertices = adjMatrix[vertex] {
                return vertices
            } else {
                throw GraphError.vertexIsNotAvailable
            }
        } else {
            throw GraphError.vertexIsNotAvailable
        }
    }
    
    /// This method merge the LWW with the given LWW Graph and returns a new LWW Graph without affecting the original LWW Graph
    /// - Parameter graph: LWW-Element Graph that is going to be merged with our LWW-Element Graph
    /// - Returns: LWW-Element Graph
    public func merge(with graph: Graph) -> Graph {
        let newGraph = Graph()
                
        // Merge Add-Set
        for element in self.addSet + graph.addSet {
            if newGraph.addSet.contains(element) {
                if let index = newGraph.addSet.firstIndex(of: element) {
                    // Update Graph with latest timestamp in Add-Set
                    newGraph.addSet[index].time = max(newGraph.addSet[index].time, element.time)
                } else  {
                    newGraph.add(element: element)
                }
            } else {
                newGraph.add(element: element)
            }
        }
        
        // Merge Remove-Set
        for element in self.removeSet + graph.removeSet {
            if newGraph.removeSet.contains(element) {
                if let index = newGraph.removeSet.firstIndex(of: element) {
                    // Update Graph with latest timestamp in Remove-Set
                    newGraph.removeSet[index].time = max(newGraph.removeSet[index].time, element.time)
                } else  {
                    newGraph.remove(element: element)
                }
            } else {
                newGraph.remove(element: element)
            }
        }
        return newGraph
    }
    
    /// Shows all possible paths between two vertices of an LWW-Element Graph
    /// - Parameters:
    ///   - source: the origin vertex of the wanted paths in the LWW-Element Graph
    ///   - destination: the destination vertex of the wanted paths in the LWW-Element Graph
    public func allPathsBetween(source: String, destination: String) throws -> [Path] {
        // Create a queue which stores the paths
        var pathQueue = [Path]()
        var results = [Path]()
        let adjMatrix = getAdjacencyMatrix()
        
        // Path object to store the current path
        let path = Path()
        path.pathVertices.append(source)
        pathQueue.append(path)
        
        while !pathQueue.isEmpty {
            guard let path = pathQueue.first else { throw  GraphError.unknownError }
            pathQueue.removeFirst()
            guard let lastVertex = path.pathVertices.last else { throw GraphError.indexOutOfRange}
            
            
            // If last vertex is the desired destination, then print the path
            if lastVertex == destination {
                results.append(path)
            }
            
            guard let lastVertexGraph = adjMatrix[lastVertex] else { throw GraphError.vertexIsNotAvailable }
            
            // Traverse to all the nodes connected to current vertex and push new path to queue
            for vertex in lastVertexGraph {
                if !path.pathVertices.contains(vertex) {
                    let newPath = Path()
                    newPath.pathVertices = path.pathVertices
                    newPath.pathVertices.append(vertex)
                    pathQueue.append(newPath)
                }
            }
        }
        return results
    }
}
