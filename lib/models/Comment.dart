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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Comment type in your schema. */
@immutable
class Comment extends Model {
  static const classType = const _CommentModelType();
  final String id;
  final String? _commentText;
  final TemporalDateTime? _createdOn;
  final TemporalDateTime? _updatedOn;
  final String? _postID;
  final Post? _post;
  final String? _userId;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get commentText {
    try {
      return _commentText!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  TemporalDateTime? get updatedOn {
    return _updatedOn;
  }
  
  String? get postID {
    return _postID;
  }
  
  Post? get post {
    return _post;
  }
  
  String? get userId {
    return _userId;
  }
  
  const Comment._internal({required this.id, required commentText, createdOn, updatedOn, postID, post, userId}): _commentText = commentText, _createdOn = createdOn, _updatedOn = updatedOn, _postID = postID, _post = post, _userId = userId;
  
  factory Comment({String? id, required String commentText, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, String? postID, Post? post, String? userId}) {
    return Comment._internal(
      id: id == null ? UUID.getUUID() : id,
      commentText: commentText,
      createdOn: createdOn,
      updatedOn: updatedOn,
      postID: postID,
      post: post,
      userId: userId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
      id == other.id &&
      _commentText == other._commentText &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn &&
      _postID == other._postID &&
      _post == other._post &&
      _userId == other._userId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("commentText=" + "$_commentText" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null") + ", ");
    buffer.write("postID=" + "$_postID" + ", ");
    buffer.write("post=" + (_post != null ? _post!.toString() : "null") + ", ");
    buffer.write("userId=" + "$_userId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comment copyWith({String? id, String? commentText, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, String? postID, Post? post, String? userId}) {
    return Comment(
      id: id ?? this.id,
      commentText: commentText ?? this.commentText,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      postID: postID ?? this.postID,
      post: post ?? this.post,
      userId: userId ?? this.userId);
  }
  
  Comment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _commentText = json['commentText'],
      _createdOn = json['createdOn'] != null ? TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? TemporalDateTime.fromString(json['updatedOn']) : null,
      _postID = json['postID'],
      _post = json['post']?['serializedData'] != null
        ? Post.fromJson(new Map<String, dynamic>.from(json['post']['serializedData']))
        : null,
      _userId = json['userId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'commentText': _commentText, 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'postID': _postID, 'post': _post?.toJson(), 'userId': _userId
  };

  static final QueryField ID = QueryField(fieldName: "comment.id");
  static final QueryField COMMENTTEXT = QueryField(fieldName: "commentText");
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField UPDATEDON = QueryField(fieldName: "updatedOn");
  static final QueryField POSTID = QueryField(fieldName: "postID");
  static final QueryField POST = QueryField(
    fieldName: "post",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField USERID = QueryField(fieldName: "userId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";
    
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
      key: Comment.COMMENTTEXT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.UPDATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.POSTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Comment.POST,
      isRequired: false,
      targetName: "commentPostId",
      ofModelName: (Post).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CommentModelType extends ModelType<Comment> {
  const _CommentModelType();
  
  @override
  Comment fromJson(Map<String, dynamic> jsonData) {
    return Comment.fromJson(jsonData);
  }
}