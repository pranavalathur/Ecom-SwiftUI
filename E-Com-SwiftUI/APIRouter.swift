import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {

    case fetchHomeScreenDetails




    // MARK: - HTTPMethod
    private var method : HTTPMethod {
        switch self {
        case .fetchHomeScreenDetails:
            return .get
        }
    }
    
    private var path: String 
    {
        switch self {
        case .fetchHomeScreenDetails:
            return "Todo"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .fetchHomeScreenDetails:
            return nil
        }
    }
    
    func encodeURLRequestWithoutQuestionMark(urlRequest: URLRequest, with parameters: Parameters) throws -> URLRequest {
        var modifiedRequest = urlRequest
        let query = parameters.map { "\($0.key)\($0.value)" }.joined(separator: "&")
        
        if let url = urlRequest.url {
            var urlString = url.absoluteString
            // Remove the existing query if any
            if let existingQueryRange = urlString.range(of: "?") {
                urlString.removeSubrange(existingQueryRange)
            }
            print("ree \(urlString) \(query)")
            urlString += "/\(query)"
            if let modifiedURL = URL(string: urlString) {
                modifiedRequest.url = modifiedURL
            }
        }
        return modifiedRequest
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let urlString = "https://64bfc2a60d8e251fd111630f.mockapi.io/api/"
        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch path 
        {
        case "create_user":
        break // "No auth token needed
        case "user/login":
        break // "No auth token needed
        case "chatbot_questions":
        break
        default:
            urlRequest.setValue(UserDefaults.standard.string(forKey: "Authorization"), forHTTPHeaderField: "Authorization")
            debugPrint("user token \(UserDefaults.standard.string(forKey: "Authorization"))");
        }
        // Parameters
        if let parameters = parameters {
            do
            {
                    
                        urlRequest = try URLEncoding(destination: .queryString).encode(urlRequest, with: parameters)
                    
                    
                
            } catch
            {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        debugPrint("URL:\(urlRequest)")
        return urlRequest
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
