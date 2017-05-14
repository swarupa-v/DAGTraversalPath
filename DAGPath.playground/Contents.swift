




//Logic used

/*
 1. Created a class of Vertex
 2. Created an Edge class
 3. Interface having functions to createVertex, addEdge and sort
 To get sorted path following is the logic:
 Find the nodes that do not have any input point and push it on to the stack
 Remove the nodes that do not have input point and also delete the  edge that has that respective node
 Repeat the process till all the nodes are removed in a recursive sort function.
  */

public class Vertex{
    
    var key: String?
    var neighbors: Array<Edge>
    
    
    init(){
        self.neighbors = Array<Edge>()
        
    }
}

public class Edge{
    
    var neighbor: Vertex

    init() {
       self.neighbor = Vertex()
    }
    
}

protocol GraphDelegate{
  func  addVertex(key:String) -> Vertex
  func  addEdge(source:Vertex, neighbor:Vertex)
  func sort()
}

public class Graph:GraphDelegate{
    
    private var canvas: Array<Vertex>
    private var inDegreeArray: Array<Vertex>
   
    
    var stack = Stack<Vertex>()
    
    init() {
        canvas = Array<Vertex>()
       
        inDegreeArray = Array<Vertex>()
    }
    
    //create a new vertex
    func addVertex(key:String) -> Vertex{
        let childVertex: Vertex = Vertex()
        childVertex.key = key
        
        //add the vertex to the graph canvas
        canvas.append(childVertex)
        return childVertex
    }
    
    func addEdge(source:Vertex, neighbor:Vertex){
        let newEdge =  Edge()
        newEdge.neighbor = neighbor
    
        source.neighbors.append(newEdge)
        
       
    }
    
    
    //This function will check if node is not having any input node
    func checkIfIndegree(targetNode:Vertex,sourceNode:Vertex)->Bool {
        for edge in sourceNode.neighbors{
            
            if(edge.neighbor.key == targetNode.key){
                
                return false
            }
            
        }
        return true
    }
    
    
    //Function to fine nodes that do not have any input node.
    func findinDegree(){
        //Loop throuh all Nodes
        for node in canvas{
            var count = 0
            
            for node1 in canvas{
                if(node.key != node1.key){
                    
                    if(!checkIfIndegree(targetNode: node, sourceNode: node1)){
                        count += 1
                        
                    }
                }
            }
            if(count == 0){
                
                inDegreeArray.append(node)
                stack.push(node)
                
            }
        }
        
        
    }
    
    func getIndexOfNodeToBeRemoved(targetNode:Vertex,sourceNode:Vertex)->Int {
        
        
        if(sourceNode.neighbors.count == 0){
            return -1
        }
        for  i in 0...sourceNode.neighbors.count - 1 {
            let edge = sourceNode.neighbors[i]
            
            if edge.neighbor.key == targetNode.key{
                
                return i
            }
            
        }
        return -1
    }
   
    // Remove node from the edge
    func removeNodeFromEdge(nodeToBeremoved:Vertex){
        
        for node in canvas{
            
            let index = getIndexOfNodeToBeRemoved(targetNode: nodeToBeremoved, sourceNode: node)
            
            if(index != -1){
                
                node.neighbors.remove(at: index)
            }
        }
        
    }
    
    //to remove node that do not have input node from the canvas
    func removeNodeFromCanvas(node:Vertex){
        var index:Int = -1
        for i in 0...canvas.count{
            let vertex = canvas[i]
            if vertex.key == node.key{
                index = i
                break
            }
        }
        if index != -1{
            canvas.remove(at: index)
        }
        
    }
    
    
    // Function to get sorted path
    func sort(){
        
        //Find the nodes that do not have input node
        findinDegree()
        
        for i in 0...inDegreeArray.count - 1{
            let vertex = inDegreeArray[i]
            
            
            //Before removing node from the canvas remove the respective node from the edge
            removeNodeFromEdge(nodeToBeremoved: vertex)
            removeNodeFromCanvas(node: vertex)
            
            print(stack.peek()?.key)
            
            stack.pop()
        }
        
        // Retrurn if all the nodes are processed
        if canvas.count == 0{
            return
        }
       
        //clear indegree array
        inDegreeArray.removeAll()
        
        //Repeat till all the nodes are processed
        sort()
        
    }
    
}


struct Stack<Element> {
    fileprivate var array: [Element] = []
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    mutating func pop() -> Element? {
        return array.popLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
    
    func empty()->Bool{
        if(array.count == 0){
            return true
        }
        else{
            return false
        }
    }
}



//Test Cases




/* Path 2,1,3,5,4 */

//let graph = Graph()
//let node1 = graph.addVertex(key: "1")
//let node2 = graph.addVertex(key: "2")
//let node5 = graph.addVertex(key: "5")
//let node3 = graph.addVertex(key: "3")
//let node4 = graph.addVertex(key: "4")
//
//
//graph.addEdge(source: node1, neighbor: node3 )
//graph.addEdge(source: node2, neighbor: node3)
//graph.addEdge(source: node2, neighbor: node5)
//graph.addEdge(source: node5, neighbor: node4)
//graph.addEdge(source: node3, neighbor: node4)
//
//graph.sort()


/* Path 1,2,5,3,4 */


//let graph = Graph()
//let node2 = graph.addVertex(key: "2")
//let node1 = graph.addVertex(key: "1")
//
//let node3 = graph.addVertex(key: "3")
//let node5 = graph.addVertex(key: "5")
//let node4 = graph.addVertex(key: "4")
//
//
//graph.addEdge(source: node1, neighbor: node3 )
//graph.addEdge(source: node2, neighbor: node3)
//graph.addEdge(source: node2, neighbor: node5)
//graph.addEdge(source: node5, neighbor: node4)
//graph.addEdge(source: node3, neighbor: node4)
//
//graph.sort()


/* Path 1,2,3,5,4 */

//let graph = Graph()
//let node2 = graph.addVertex(key: "2")
//let node1 = graph.addVertex(key: "1")
//let node5 = graph.addVertex(key: "5")
//let node3 = graph.addVertex(key: "3")
//
//let node4 = graph.addVertex(key: "4")
//
//
//graph.addEdge(source: node1, neighbor: node3 )
//graph.addEdge(source: node2, neighbor: node3)
//graph.addEdge(source: node2, neighbor: node5)
//graph.addEdge(source: node5, neighbor: node4)
//graph.addEdge(source: node3, neighbor: node4)
//
//graph.sort()



/*Path 2,1,5,3,4 */

let graph = Graph()

let node1 = graph.addVertex(key: "1")
let node2 = graph.addVertex(key: "2")
let node3 = graph.addVertex(key: "3")
let node4 = graph.addVertex(key: "4")
let node5 = graph.addVertex(key: "5")


graph.addEdge(source: node1, neighbor: node3 )
graph.addEdge(source: node2, neighbor: node3)
graph.addEdge(source: node2, neighbor: node5)
graph.addEdge(source: node5, neighbor: node4)
graph.addEdge(source: node3, neighbor: node4)

graph.sort()













