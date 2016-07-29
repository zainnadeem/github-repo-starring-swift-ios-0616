//
//  ReposDataStore.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    private init() {}
    
    var repositories:[GithubRepository] = []
    
   func toggleStarStatusForRepository(repository: GithubRepository, completion:() -> ()){
    GithubAPIClient.checkIfRepositoryIsStarred(repository.fullName) { (starred) in
        
        if starred == true {
            
            GithubAPIClient.usStarRepository(repository.fullName, completion:{
            print("unstarring")
                completion()
            })
        
        }else{
                GithubAPIClient.starRepository(repository.fullName, completion:{
                    print("starring")
                    completion()
        })
    }
    
    
    completion()
    }
}
    
    
    func getRepositoriesWithCompletion(completion: () -> ()) {
        GithubAPIClient.getRepositoriesWithCompletion { (reposArray) in
            self.repositories.removeAll()
            for dictionary in reposArray {
                guard let repoDictionary = dictionary as? NSDictionary else { fatalError("Object in reposArray is of non-dictionary type") }
                let repository = GithubRepository(dictionary: repoDictionary)
                self.repositories.append(repository)
                
            }
            completion()
        }
    }

}
