//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
  
    
    
    class func starRepository(fullName: String, completion:()->()){
        // got url string
        let urlString = "\(Secrets.githubStarAPIURL)\(fullName)"
        
        //convert to url
        let url = NSURL(string: urlString)
        
        //created a session for downloading content
        let session = NSURLSession.sharedSession()
        
        //unwrapped version of our URL
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        // create a request -- request allows us to change things like header, we are altering something -- if we are just requesting from json we can use task -- without mutable you cant addValue
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "PUT"
        request.addValue("\(Secrets.accessToken)", forHTTPHeaderField: "Authorization")
        let task = session.dataTaskWithRequest(request){data, response, error in
            guard let responseValue = response as? NSHTTPURLResponse else{ assertionFailure("Hey this assignment didn't work")
                return
            }
            
            if responseValue.statusCode == 204{
                completion()
            }else {
                print("other status code \(responseValue.statusCode)")
            }
            
            
            print(data)
            print(response)
            print(error)
        }
        task.resume()
        
        completion()
        }
    
        class func usStarRepository(fullName: String, completion:()->()){
            let urlString = "\(Secrets.githubStarAPIURL)\(fullName)"
            let url = NSURL(string: urlString)
            
            let session = NSURLSession.sharedSession()
            guard let unwrappedURL = url else { fatalError("Invalid URL") }
            
            let request = NSMutableURLRequest(URL: unwrappedURL)
            request.HTTPMethod = "DELETE"
            request.addValue("token " + Secrets.accessToken, forHTTPHeaderField: "Authorization")
            
            let task = session.dataTaskWithRequest(request){data, response, error in
                guard let responseValue = response as? NSHTTPURLResponse else{
                    assertionFailure("Hey this assignment didnt work")
                    return
                }
                
                
                if responseValue.statusCode == 204 {
                    completion()
                }else if responseValue.statusCode == 404{
                    completion()
                }else{
                    print("Other Status conde \(responseValue.statusCode)")
                }
                
                completion()
            }
            
    
    }
    
    class func getRepositoriesWithCompletion(completion: (NSArray) -> ()) {
        let urlString = "https://api.github.com/repositories?client_id=\(Secrets.githubClientID)&client_secret=\(Secrets.githubClientSecret)"
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSArray {
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }
        task.resume()
            }
    
    class func checkIfRepositoryIsStarred(fullName:String, completion:(Bool)->()){
        // got url string
        let urlString = "\(Secrets.githubStarAPIURL)\(fullName)"
        
        //convert to url
        let url = NSURL(string: urlString)
        
        //created a session for downloading content
        let session = NSURLSession.sharedSession()
        
        //unwrapped version of our URL
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        
        // create a request -- request allows us to change things like header, we are altering something -- if we are just requesting from json we can use task -- without mutable you cant addValue
        let request = NSMutableURLRequest(URL: unwrappedURL)
        request.HTTPMethod = "GET"
        request.addValue("\(Secrets.accessToken)", forHTTPHeaderField: "Authorization")
        
        //create a task -- run through completion block -- check status code -- convert response to NSHTTPResponse so we can access "Status code"
        let task = session.dataTaskWithRequest(request){data, response, error in
            guard let responseValue = response as? NSHTTPURLResponse else{ assertionFailure("Hey this assignment didn't work")
                return
            }
            
            if responseValue.statusCode == 204{
                completion(true)
            }else if responseValue.statusCode == 404{
                completion(false)
            }else{
                print("other status code \(responseValue.statusCode)")
            }
            
            
            print(data)
            print(response)
            print(error)
        }
        task.resume()
            
            
        }
  
    }
    

