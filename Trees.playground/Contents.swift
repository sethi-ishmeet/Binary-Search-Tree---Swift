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
            if node.data < temp.data {
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
                if num < temp.data {
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
        
        var node: Node = search(num)!
        
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
        
        var node: Node! = search(num)!
        
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
        
        let node = search(num)
        
        if node?.left == nil {
            replace(node!, with: node?.right)
        } else if node?.right == nil {
            replace(node!, with: node?.left)
        } else {
            let subTree = Tree()
            subTree.root = node?.right
            let minimum = subTree.minimum()
            
            if minimum?.parent?.data != node?.data {
                replace(minimum!, with: minimum?.right)
                minimum?.right = node?.right
                minimum?.right?.parent = minimum
            }
            replace(node!, with: minimum)
            minimum?.left = node?.left
            minimum?.left?.parent = minimum
        }
    }
    
    func inOrderTraversal(node: Node?) {
        if node != nil {
            inOrderTraversal(node!.left)
            print(node!.data)
            inOrderTraversal(node!.right)
        }
    }
    
    func preOrderTraversal(node: Node?) -> Void {
        if node != nil {
            print(node?.data)
            preOrderTraversal(node?.left)
            preOrderTraversal(node?.right)
        }
    }
    
    func postOrderTraversal(node: Node?) -> Void {
        if node != nil {
            postOrderTraversal(node?.left)
            postOrderTraversal(node?.right)
            print(node?.data)
        }
    }
}

var tree = Tree()
tree.addNode(5)
tree.addNode(8)
tree.addNode(2)
tree.addNode(14)
tree.addNode(1)
tree.addNode(4)
tree.addNode(56)
tree.addNode(1347)
tree.addNode(30)
tree.addNode(3241)
tree.addNode(9)
tree.addNode(0)

//tree.inOrderTraversal(tree.root)
//tree.preOrderTraversal(tree.root)
//tree.postOrderTraversal(tree.root)
tree.count
tree.search(8)?.data
tree.minimum()?.data
tree.maximum()?.data
tree.successor(8)?.data
tree.predecessor(5)?.data
tree.delete(4)
tree.search(56)?.data
tree.predecessor(5)?.data