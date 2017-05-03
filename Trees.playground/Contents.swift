class Node {
    var left: Node?
    var right: Node?
    var parent: Node?
    var data: Int?
}

class Tree {
    var root: Node?
    var count = 0
    
    func addNode(num: Int) -> Void {
        let node = Node()
        node.data = num
        
        if (root == nil) {
            root = node
            root?.parent = nil
            count += 1
            return
        }
        
        var temp: Node = root!
        
        while true {
            if node.data! < temp.data! {
                if (temp.left == nil) {
                    temp.left = node
                    temp.left?.parent = temp
                    count += 1
                    return
                }
                temp = temp.left!
            }
            else {
                if temp.right == nil {
                    temp.right = node
                    temp.right?.parent = temp
                    count += 1
                    return
                }
                temp = temp.right!
            }
        }
    }
    
    func search(num: Int) -> Node? {
        var temp: Node = root!
        
        while temp.data != num {
            if temp.data != nil {
                if num < temp.data! {
                    temp = temp.left!
                }
                else {
                    temp = temp.right!
                }
            }
            else {
                return nil
            }
        }
        
        return temp
    }
    
    func minimum() -> Node? {
        if root == nil {
            return nil
        }
        
        var temp = root!
        while temp.left != nil {
            temp = temp.left!
        }
        return temp
    }
    
    func maximum() -> Node? {
        if root == nil {
            return nil
        }
        
        var temp = root!
        while temp.right != nil {
            temp = temp.right!
        }
        
        return temp
    }
    
    func successor(num: Int) -> Node? {
        if root == nil {
            return nil
        }
        
        var node: Node = search(num: num)!
        
        if node.right != nil {
            let subTree: Tree? = Tree()
            subTree?.root = node.right
            
            return subTree?.minimum()
        } else {
            var temp = node.parent
            while temp != nil && temp?.right?.data == node.data {
                node = temp!
                temp = node.parent
            }
            return temp
        }
    }
    
    func predecessor(num: Int) -> Node? {
        if root == nil {
            return nil
        }
        
        var node: Node! = search(num: num)!
        
        if node.left != nil {
            let subTree: Tree = Tree()
            subTree.root = node.left
            return subTree.maximum()
        } else {
            var temp = node.parent
            while temp != nil  && temp?.left?.data == node.data {
                node = temp
                temp = node.parent
            }
            return temp
        }
        
    }
    
    func replace(a: Node, with b: Node?) -> Void {
        if a.parent == nil {
            self.root = b
        } else if a.data == a.parent?.left?.data {
            a.parent?.left = b
        } else {
            a.parent?.right = b
        }
        if b != nil {
            b!.parent = a.parent
        }
    }
    
    func delete(num: Int) -> Void {
        if root == nil {
            return
        }
        
        let node = search(num: num)
        
        if node?.left == nil {
            replace(a: node!, with: node?.right)
        } else if node?.right == nil {
            replace(a: node!, with: node?.left)
        } else {
            let subTree = Tree()
            subTree.root = node?.right
            let minimum = subTree.minimum()
            
            if minimum?.parent?.data != node?.data {
                replace(a: minimum!, with: minimum?.right)
                minimum?.right = node?.right
                minimum?.right?.parent = minimum
            }
            replace(a: node!, with: minimum)
            minimum?.left = node?.left
            minimum?.left?.parent = minimum
        }
    }
    
    func inOrderTraversal(node: Node?) {
        if node != nil {
            inOrderTraversal(node: node!.left)
            print(node!.data!)
            inOrderTraversal(node: node!.right)
        }
    }
    
    func preOrderTraversal(node: Node?) -> Void {
        if node != nil {
            print(node?.data! ?? "nil")
            preOrderTraversal(node: node?.left)
            preOrderTraversal(node: node?.right)
        }
    }
    
    func postOrderTraversal(node: Node?) -> Void {
        if node != nil {
            postOrderTraversal(node: node?.left)
            postOrderTraversal(node: node?.right)
            print(node?.data! ?? "nil")
        }
    }
    
    func split(at num: Int) -> Node? {
        let node: Node! = search(num: num)
        let nextNode = node?.right
        
        node?.right = nil
        nextNode?.parent = nil
        
        return nextNode
    }
}

var tree = Tree()
tree.addNode(num: 5)
tree.addNode(num: 8)
tree.addNode(num: 2)
tree.addNode(num: 14)
tree.addNode(num: 1)
tree.addNode(num: 4)
tree.addNode(num: 56)
tree.addNode(num: 1347)
tree.addNode(num: 30)
tree.addNode(num: 3241)
tree.addNode(num: 9)
tree.addNode(num: 0)

//tree.inOrderTraversal(tree.root)
//tree.preOrderTraversal(tree.root)
//tree.postOrderTraversal(tree.root)
//tree.count
//tree.search(num: 8)?.data
//tree.minimum()?.data
//tree.maximum()?.data
//tree.successor(num: 8)?.data
//tree.predecessor(num: 5)?.data
//tree.delete(num: 4)
//tree.search(num: 56)?.data
//tree.predecessor(num: 5)?.data

tree.split(at: 14)?.parent
tree.search(num: 14)?.right