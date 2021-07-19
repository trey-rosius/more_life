/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _username;
  final String? _firstName;
  final String? _lastName;
  final bool? _isVerified;
  final String? _profilePicUrl;
  final String? _email;
  final List<Post>? _post;
  final List<UserChat>? _userChats;
  final TemporalDateTime? _createdOn;
  final TemporalDateTime? _updatedOn;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get firstName {
    try {
      return _firstName!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get lastName {
    try {
      return _lastName!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  bool get isVerified {
    try {
      return _isVerified!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get profilePicUrl {
    return _profilePicUrl;
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<Post>? get post {
    return _post;
  }
  
  List<UserChat>? get userChats {
    return _userChats;
  }
  
  TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  TemporalDateTime? get updatedOn {
    return _updatedOn;
  }
  
  const User._internal({required this.id, required username, required firstName, required lastName, required isVerified, profilePicUrl, required email, post, userChats, createdOn, updatedOn}): _username = username, _firstName = firstName, _lastName = lastName, _isVerified = isVerified, _profilePicUrl = profilePicUrl, _email = email, _post = post, _userChats = userChats, _createdOn = createdOn, _updatedOn = updatedOn;
  
  factory User({String? id, required String username, required String firstName, required String lastName, required bool isVerified, String? profilePicUrl, required String email, List<Post>? post, List<UserChat>? userChats, TemporalDateTime? createdOn, TemporalDateTime? updatedOn}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      isVerified: isVerified,
      profilePicUrl: profilePicUrl,
      email: email,
      post: post != null ? List<Post>.unmodifiable(post) : post,
      userChats: userChats != null ? List<UserChat>.unmodifiable(userChats) : userChats,
      createdOn: createdOn,
      updatedOn: updatedOn);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _username == other._username &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _isVerified == other._isVerified &&
      _profilePicUrl == other._profilePicUrl &&
      _email == other._email &&
      DeepCollectionEquality().equals(_post, other._post) &&
      DeepCollectionEquality().equals(_userChats, other._userChats) &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("isVerified=" + (_isVerified != null ? _isVerified!.toString() : "null") + ", ");
    buffer.write("profilePicUrl=" + "$_profilePicUrl" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? username, String? firstName, String? lastName, bool? isVerified, String? profilePicUrl, String? email, List<Post>? post, List<UserChat>? userChats, TemporalDateTime? createdOn, TemporalDateTime? updatedOn}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isVerified: isVerified ?? this.isVerified,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      email: email ?? this.email,
      post: post ?? this.post,
      userChats: userChats ?? this.userChats,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _isVerified = json['isVerified'],
      _profilePicUrl = json['profilePicUrl'],
      _email = json['email'],
      _post = json['post'] is List
        ? (json['post'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Post.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _userChats = json['userChats'] is List
        ? (json['userChats'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UserChat.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdOn = json['createdOn'] != null ? TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? TemporalDateTime.fromString(json['updatedOn']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'firstName': _firstName, 'lastName': _lastName, 'isVerified': _isVerified, 'profilePicUrl': _profilePicUrl, 'email': _email, 'post': _post?.map((e) => e?.toJson())?.toList(), 'userChats': _userChats?.map((e) => e?.toJson())?.toList(), 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstName");
  static final QueryField LASTNAME = QueryField(fieldName: "lastName");
  static final QueryField ISVERIFIED = QueryField(fieldName: "isVerified");
  static final QueryField PROFILEPICURL = QueryField(fieldName: "profilePicUrl");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField POST = QueryField(
    fieldName: "post",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField USERCHATS = QueryField(
    fieldName: "userChats",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserChat).toString()));
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField UPDATEDON = QueryField(fieldName: "updatedOn");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.FIRSTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LASTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ISVERIFIED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILEPICURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.POST,
      isRequired: false,
      ofModelName: (Post).toString(),
      associatedKey: Post.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.USERCHATS,
      isRequired: false,
      ofModelName: (UserChat).toString(),
      associatedKey: UserChat.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.UPDATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}