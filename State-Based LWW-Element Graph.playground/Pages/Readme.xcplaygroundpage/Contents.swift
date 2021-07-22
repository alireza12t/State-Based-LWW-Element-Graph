/*:
 __README__
 
 
 This is an  __State-Based LWW-Element Graph__ Data structure source code using Conflict-Free Replicated Data Types
 Which Every Vertex of graph has a name and every two vertices can has an edge between them


* Requirements for this project:
    * Xcode Version 12.5 (12E262)
    * Swift Version 5.4
 
 
 * Installation instructions:
    * Install Xcode Version 12.5 (12E262) and open *State-Based LWW-Element Graph.playground*  file with Xcode
 
 *  GoodNotes Expectations:
    * The graph must contain functionalities to:
        * add a vertex/edge ✅
        * remove a vertex/edge ✅
        * check if a vertex is in the graph ✅
        * query for all vertices connected to a vertex ✅
        * find any path between two vertices ✅
        * merge with concurrent changes from other graph/replica ✅
    * Clean test cases for CRDT aspects  and other functionalities in __LWW-Element Graph Class__ such as:
        * addition/removal in different timing
        * merge different replicas
        * and etc...
 
    * Spending time for doing the test:
        * Reading : 2 Hours 15 Minutes 30 Second
        * Implementing : 1 Hours 59 Minutes 56 Second
        * Writing Tests : 57 Minutes 51 Second
        * Commenting the code, Writing The Documentation and Readme : 35 Minutes 32 Seconds
        
        Total Time spent on Reading & Code : 5 Hours 48 minutes 49 seconds
 
 
 
 
 
    * Time Complexity:
        V is number of vertices in the Graph
        E is number of adjacent edges
 
        * add\remove vertex\edge : O(n)
        * find element : O(4*n) = O(n)
        * getVertices : O(n^2)
        * getAdjacencyMatrix : O(n^2 + 2*n + 2*n^2) = O(n^2)
        * getConnectedVertices : O(n^2)
        * merge : O(4*n^2) = O(n^2)
        * all Paths Between two vertices : O(V*E)
 
    * Please let me know if you have any questions
        * Contact Info:
            * alirezaToghyiani@gmail.com
            * +989202072717
            * https://linkedin.com/in/alireza12t
 
 
 */

//: [Next](@next)
