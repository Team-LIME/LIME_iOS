// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum ChatRoomTypeEnum: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case personal
  case group
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "PERSONAL": self = .personal
      case "GROUP": self = .group
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .personal: return "PERSONAL"
      case .group: return "GROUP"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: ChatRoomTypeEnum, rhs: ChatRoomTypeEnum) -> Bool {
    switch (lhs, rhs) {
      case (.personal, .personal): return true
      case (.group, .group): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [ChatRoomTypeEnum] {
    return [
      .personal,
      .group,
    ]
  }
}

public enum UserTypeEnum: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case student
  case teacher
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "STUDENT": self = .student
      case "TEACHER": self = .teacher
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .student: return "STUDENT"
      case .teacher: return "TEACHER"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: UserTypeEnum, rhs: UserTypeEnum) -> Bool {
    switch (lhs, rhs) {
      case (.student, .student): return true
      case (.teacher, .teacher): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [UserTypeEnum] {
    return [
      .student,
      .teacher,
    ]
  }
}

public final class ChatRoomsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ChatRooms {
      getChatRooms {
        __typename
        _id
        participants {
          __typename
          profileImages
        }
        name
        type
      }
    }
    """

  public let operationName: String = "ChatRooms"

  public let operationIdentifier: String? = "4ed36e099988c8b133cba2dbac6b1e7fb0bbb429e00fd8a63f2063f82e05ae00"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getChatRooms", type: .list(.nonNull(.object(GetChatRoom.selections)))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getChatRooms: [GetChatRoom]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getChatRooms": getChatRooms.flatMap { (value: [GetChatRoom]) -> [ResultMap] in value.map { (value: GetChatRoom) -> ResultMap in value.resultMap } }])
    }

    public var getChatRooms: [GetChatRoom]? {
      get {
        return (resultMap["getChatRooms"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [GetChatRoom] in value.map { (value: ResultMap) -> GetChatRoom in GetChatRoom(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetChatRoom]) -> [ResultMap] in value.map { (value: GetChatRoom) -> ResultMap in value.resultMap } }, forKey: "getChatRooms")
      }
    }

    public struct GetChatRoom: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ChatRoom"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("participants", type: .nonNull(.list(.nonNull(.object(Participant.selections))))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("type", type: .nonNull(.scalar(ChatRoomTypeEnum.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: String, participants: [Participant], name: String, type: ChatRoomTypeEnum) {
        self.init(unsafeResultMap: ["__typename": "ChatRoom", "_id": _id, "participants": participants.map { (value: Participant) -> ResultMap in value.resultMap }, "name": name, "type": type])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var _id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var participants: [Participant] {
        get {
          return (resultMap["participants"] as! [ResultMap]).map { (value: ResultMap) -> Participant in Participant(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Participant) -> ResultMap in value.resultMap }, forKey: "participants")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var type: ChatRoomTypeEnum {
        get {
          return resultMap["type"]! as! ChatRoomTypeEnum
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public struct Participant: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("profileImages", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(profileImages: [String]) {
          self.init(unsafeResultMap: ["__typename": "User", "profileImages": profileImages])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var profileImages: [String] {
          get {
            return resultMap["profileImages"]! as! [String]
          }
          set {
            resultMap.updateValue(newValue, forKey: "profileImages")
          }
        }
      }
    }
  }
}

public final class UsersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Users {
      getOtherUsers {
        __typename
        _id
        profileImages
        name
        type
        intro
        generation
      }
      getMyProfile {
        __typename
        profileImages
        name
        intro
      }
    }
    """

  public let operationName: String = "Users"

  public let operationIdentifier: String? = "f495cee096d57163a9301c3f90394d5f7c1ab620849be12644882a85309caf76"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getOtherUsers", type: .list(.nonNull(.object(GetOtherUser.selections)))),
        GraphQLField("getMyProfile", type: .object(GetMyProfile.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getOtherUsers: [GetOtherUser]? = nil, getMyProfile: GetMyProfile? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "getOtherUsers": getOtherUsers.flatMap { (value: [GetOtherUser]) -> [ResultMap] in value.map { (value: GetOtherUser) -> ResultMap in value.resultMap } }, "getMyProfile": getMyProfile.flatMap { (value: GetMyProfile) -> ResultMap in value.resultMap }])
    }

    public var getOtherUsers: [GetOtherUser]? {
      get {
        return (resultMap["getOtherUsers"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [GetOtherUser] in value.map { (value: ResultMap) -> GetOtherUser in GetOtherUser(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [GetOtherUser]) -> [ResultMap] in value.map { (value: GetOtherUser) -> ResultMap in value.resultMap } }, forKey: "getOtherUsers")
      }
    }

    public var getMyProfile: GetMyProfile? {
      get {
        return (resultMap["getMyProfile"] as? ResultMap).flatMap { GetMyProfile(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "getMyProfile")
      }
    }

    public struct GetOtherUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("_id", type: .nonNull(.scalar(String.self))),
          GraphQLField("profileImages", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("type", type: .nonNull(.scalar(UserTypeEnum.self))),
          GraphQLField("intro", type: .nonNull(.scalar(String.self))),
          GraphQLField("generation", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(_id: String, profileImages: [String], name: String, type: UserTypeEnum, intro: String, generation: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "_id": _id, "profileImages": profileImages, "name": name, "type": type, "intro": intro, "generation": generation])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var _id: String {
        get {
          return resultMap["_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "_id")
        }
      }

      public var profileImages: [String] {
        get {
          return resultMap["profileImages"]! as! [String]
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImages")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var type: UserTypeEnum {
        get {
          return resultMap["type"]! as! UserTypeEnum
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var intro: String {
        get {
          return resultMap["intro"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "intro")
        }
      }

      public var generation: Int? {
        get {
          return resultMap["generation"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "generation")
        }
      }
    }

    public struct GetMyProfile: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("profileImages", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("intro", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(profileImages: [String], name: String, intro: String) {
        self.init(unsafeResultMap: ["__typename": "User", "profileImages": profileImages, "name": name, "intro": intro])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var profileImages: [String] {
        get {
          return resultMap["profileImages"]! as! [String]
        }
        set {
          resultMap.updateValue(newValue, forKey: "profileImages")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var intro: String {
        get {
          return resultMap["intro"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "intro")
        }
      }
    }
  }
}
