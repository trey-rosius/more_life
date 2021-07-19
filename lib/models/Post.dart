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


/** This is an auto generated class representing the Post type in your schema. */
@immutable
class Post extends Model {
  static const classType = const _PostModelType();
  final String id;
  final String? _content;
  final String? _postImageUrl;
  final PostTyp? _postType;
  final PostStatus? _postStatus;
  final String? _userID;
  final TemporalDateTime? _createdOn;
  final TemporalDateTime? _updatedOn;
  final List<Comment>? _comments;
  final User? _user;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get content {
    try {
      return _content!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get postImageUrl {
    return _postImageUrl;
  }
  
  PostTyp get postType {
    try {
      return _postType!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  PostStatus? get postStatus {
    return _postStatus;
  }
  
  String? get userID {
    return _userID;
  }
  
  TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  TemporalDateTime? get updatedOn {
    return _updatedOn;
  }
  
  List<Comment>? get comments {
    return _comments;
  }
  
  User? get user {
    return _user;
  }
  
  const Post._internal({required this.id, required content, postImageUrl, required postType, postStatus, userID, createdOn, updatedOn, comments, user}): _content = content, _postImageUrl = postImageUrl, _postType = postType, _postStatus = postStatus, _userID = userID, _createdOn = createdOn, _updatedOn = updatedOn, _comments = comments, _user = user;
  
  factory Post({String? id, required String content, String? postImageUrl, required PostTyp postType, PostStatus? postStatus, String? userID, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, List<Comment>? comments, User? user}) {
    return Post._internal(
      id: id == null ? UUID.getUUID() : id,
      content: content,
      postImageUrl: postImageUrl,
      postType: postType,
      postStatus: postStatus,
      userID: userID,
      createdOn: createdOn,
      updatedOn: updatedOn,
      comments: comments != null ? List<Comment>.unmodifiable(comments) : comments,
      user: user);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Post &&
      id == other.id &&
      _content == other._content &&
      _postImageUrl == other._postImageUrl &&
      _postType == other._postType &&
      _postStatus == other._postStatus &&
      _userID == other._userID &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn &&
      DeepCollectionEquality().equals(_comments, other._comments) &&
      _user == other._user;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Post {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("postImageUrl=" + "$_postImageUrl" + ", ");
    buffer.write("postType=" + (_postType != null ? enumToString(_postType)! : "null") + ", ");
    buffer.write("postStatus=" + (_postStatus != null ? enumToString(_postStatus)! : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Post copyWith({String? id, String? content, String? postImageUrl, PostTyp? postType, PostStatus? postStatus, String? userID, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, List<Comment>? comments, User? user}) {
    return Post(
      id: id ?? this.id,
      content: content ?? this.content,
      postImageUrl: postImageUrl ?? this.postImageUrl,
      postType: postType ?? this.postType,
      postStatus: postStatus ?? this.postStatus,
      userID: userID ?? this.userID,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      comments: comments ?? this.comments,
      user: user ?? this.user);
  }
  
  Post.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _content = json['content'],
      _postImageUrl = json['postImageUrl'],
      _postType = enumFromString<PostTyp>(json['postType'], PostTyp.values),
      _postStatus = enumFromString<PostStatus>(json['postStatus'], PostStatus.values),
      _userID = json['userID'],
      _createdOn = json['createdOn'] != null ? TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? TemporalDateTime.fromString(json['updatedOn']) : null,
      _comments = json['comments'] is List
        ? (json['comments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Comment.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'content': _content, 'postImageUrl': _postImageUrl, 'postType': enumToString(_postType), 'postStatus': enumToString(_postStatus), 'userID': _userID, 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'comments': _comments?.map((e) => e?.toJson())?.toList(), 'user': _user?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "post.id");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField POSTIMAGEURL = QueryField(fieldName: "postImageUrl");
  static final QueryField POSTTYPE = QueryField(fieldName: "postType");
  static final QueryField POSTSTATUS = QueryField(fieldName: "postStatus");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField UPDATEDON = QueryField(fieldName: "updatedOn");
  static final QueryField COMMENTS = QueryField(
    fieldName: "comments",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Comment).toString()));
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Post";
    modelSchemaDefinition.pluralName = "Posts";
    
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
      key: Post.CONTENT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.POSTIMAGEURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.POSTTYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.POSTSTATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Post.UPDATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Post.COMMENTS,
      isRequired: false,
      ofModelName: (Comment).toString(),
      associatedKey: Comment.POSTID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Post.USER,
      isRequired: false,
      targetName: "postUserId",
      ofModelName: (User).toString()
    ));
  });
}

class _PostModelType extends ModelType<Post> {
  const _PostModelType();
  
  @override
  Post fromJson(Map<String, dynamic> jsonData) {
    return Post.fromJson(jsonData);
  }
}