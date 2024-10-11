import Foundation
import Alamofire


class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>) -> Void) -> DataRequest {
        return AF.request(route).responseDecodable(decoder: decoder) {(response: AFDataResponse<T>) in
            debugPrint(response.result)
            switch response.result {
                       case .success(let value):
                           // Simply pass the decoded value to the completion
                           completion(.success(value))
                           
                       case .failure(let error):
                           // Handle failure
                           print("Request failed with error: \(error)")
                           completion(.failure(error))
                       }
        }
    }
    static func fetchHomeScreenDetails(completion:@escaping(AFResult<[HomeScreenResModel]>)->Void){
        performRequest(route: APIRouter.fetchHomeScreenDetails,completion: completion)
     }
    
    

}



