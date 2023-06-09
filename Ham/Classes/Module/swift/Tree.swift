//
//  DRouter.swift
//  
//
//  Created by hao yin on 2023/4/21.
//

import Foundation

public protocol TreeContent{
    associatedtype Content
    
    var query:Set<String> { get set }
    
    var key:String { get set }
    
    var value:Content? { get set }
    
    init(key: String, value: Content?)
    
    func match(value:String)->Bool
}

public struct TreeNodeContent<Content>:TreeContent{
    public func match(value: String) -> Bool {
        if(self.key.hasPrefix(":")){
            return true
        }else{
            return self.key == value
        }
    }
    

    public var key: String
    
    public var query: Set<String> = Set()
    
    public var value: Content?
    
    public init(key: String, value: Content? = nil) {
        self.key = key
        self.value = value
    }
    
}

public enum Dog{
    
    public class Tree<T:TreeContent,E> where T.Content == E{
        public var content:T
        public var next:[String:Tree<T,E>] = [:]
        public init(content: T) {
            self.content = content
        }
        public func add(routes:ArraySlice<String>,content:E? = nil){
            guard let first = routes.first else { return }
            if(first.count == 0){
                self.addTail(routes: routes.dropFirst(), content: content)
            }else{
                self.addTail(routes: routes, content: content)
            }
        }
        
        public func isEquel(left:ArraySlice<String>,right:ArraySlice<String>)->Bool{
            let a = self.match(routes: left)
            let b = self.match(routes: right)
            return a == b
        }
        
        public func match(routes:ArraySlice<String>)->[String]?{
            if(routes.first?.count == 0){
                guard let result = self.match(routes: routes.dropFirst(), subtrees: self.next) else { return nil }
                return [""] + result
            }else{
                return self.match(routes: routes, subtrees: self.next)
            }
        }
        public func content(routes:ArraySlice<String>)->T?{
            if(routes.first?.count == 0){
                return self.content(routes: routes.dropFirst(), subtrees: self.next)
            }else{
                return self.content(routes: routes, subtrees: self.next)
            }
        }
        public subscript(routes:ArraySlice<String>)->Tree<T,E>?{
            if(routes.first?.count == 0){
                return self.child(routes: routes.dropFirst(), subtrees: self.next)
            }else{
                return self.child(routes: routes, subtrees: self.next)
            }
        }
        
        public func content(routes:ArraySlice<String>,subtrees:[String:Tree<T,E>])->T?{
            if let first = routes.first{
                if let subtree = subtrees[first]{
                    guard let result =  subtree.content(routes: routes.dropFirst(), subtrees: subtree.next) else {
                        return nil
                    }
                    return result
                }else if let subtree = subtrees.filter({$0.key.hasPrefix(":")}).first(where: {$0.value.content.match(value: first)}){
                    guard let result =  subtree.1.content(routes: routes.dropFirst(), subtrees: subtree.1.next) else {
                        return nil
                    }
                    return result
                }else{
                    return nil
                }
            }else{
                return self.content
            }
        }
        
        func match(routes:ArraySlice<String>,subtrees:[String:Tree<T,E>])->[String]?{
            if let first = routes.first{
                if let subtree = subtrees[first]{
                    guard let result =  subtree.match(routes: routes.dropFirst(), subtrees: subtree.next) else {
                        return nil
                    }
                    return [subtree.content.key] + result
                }else if let subtree = subtrees.filter({$0.key.hasPrefix(":")}).first(where: {$0.value.content.match(value: first)}){
                    guard let result = subtree.1.match(routes: routes.dropFirst(), subtrees: subtree.1.next) else {
                        return nil
                    }
                    return [subtree.1.content.key] + result
                }else{
                    return nil
                }
            }else{
                return []
            }
        }
        func child(routes:ArraySlice<String>,subtrees:[String:Tree<T,E>])->Tree<T,E>?{
            if let first = routes.first{
                if let subtree = subtrees[first]{
                    return subtree.child(routes: routes.dropFirst(), subtrees: subtree.next)
                }else if let subtree = subtrees.filter({$0.key.hasPrefix(":")}).first(where: {$0.value.content.match(value: first)}){
                    return subtree.1.child(routes: routes.dropFirst(), subtrees: subtree.1.next)
                }else{
                    return nil
                }
            }else{
                return self
            }
        }
        func addTail(routes:ArraySlice<String>,content:E?){
            guard let sec = routes.first else {
                self.content.value = content
                return
            }
            if let secroute = self.next[sec]{
                secroute.addTail(routes: routes.dropFirst(), content: content)
            }else{
                let n = Tree(content: T(key: sec, value: content))
                self.next[sec] = n
                n.addTail(routes: routes.dropFirst(), content: content)
            }
        }
    }
}

//OC

@objcMembers
public class RouterDefine:NSObject{
    public var cls:AnyClass?
    public var name:String?
    public init(cls: AnyClass?,name: String?) {
        self.cls = cls
        self.name = name
    }
}
@objcMembers
public class RouterMatch:NSObject{
    public var cls:AnyClass?
    public var name:String?
    public var param:[String:String]?
    init(cls: AnyClass?, name:String?, param: [String : String]?) {
        self.cls = cls
        self.name = name
        self.param = param
    }
}
public class RouterTree:NSObject{
    public private(set) var root: Dog.Tree<TreeNodeContent<RouterDefine>,RouterDefine> = Dog.Tree(content: TreeNodeContent(key: "/"))
    
    @objc
    public func register(route:String,cls:AnyClass){
        self.root.add(routes: ArraySlice(route.components(separatedBy: "/")), content: RouterDefine(cls: cls, name: nil))
    }
    @objc
    public func register(route:String,name:String){
        self.root.add(routes: ArraySlice(route.components(separatedBy: "/")), content: RouterDefine(cls: nil, name: name))
    }
    
    @objc
    public func generate(route:String)->RouterMatch?{
        guard let temp = self.matchClass(route: route) else { return nil }
        if temp.0.value?.cls == nil && temp.0.value?.name == nil {
            return nil
        }
        return RouterMatch(cls:temp.0.value?.cls, name: temp.0.value?.name, param: temp.1)
    }
    
    private func matchClass(route:String)->(TreeNodeContent<RouterDefine>,[String:String])?{
        guard let uc = URLComponents(string: route) else { return nil }
        let arr = ArraySlice(uc.path.components(separatedBy: "/"))
        
        guard let p = self.root.match(routes: arr) else { return nil }
        let param = (0..<p.count).reduce(into: [:]) { partialResult, i in
            partialResult[p[i]] = arr[i]
        }.filter { k in
            k.key.hasPrefix(":")
        }
        let fullparam = uc.queryItems?.reduce(into: param, { partialResult, ui in
            partialResult[ui.name] = ui.value
        }) ?? param
        
        guard let factory = self.root.content(routes:arr) else { return nil  }
        return (factory,fullparam)
    }
}
