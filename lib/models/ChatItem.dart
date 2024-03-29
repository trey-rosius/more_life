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


/** This is an auto generated class representing the ChatItem type in your schema. */
@immutable
class ChatItem extends Model {
  static const classType = const _ChatItemModelType();
  final String id;
  final String? _senderId;
  final String? _receiverId;
  final String? _message;
  final String? _imageUrl;
  final ChatItemTyp? _chatItemType;
  final String? _chatID;
  final TemporalTimestamp? _createdOn;
  final Chat? _chat;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get senderId {
    try {
      return _senderId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get receiverId {
    try {
      return _receiverId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get message {
    return _message;
  }
  
  String? get imageUrl {
    return _imageUrl;
  }
  
  ChatItemTyp get chatItemType {
    try {
      return _chatItemType!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get chatID {
    return _chatID;
  }
  
  TemporalTimestamp? get createdOn {
    return _createdOn;
  }
  
  Chat? get chat {
    return _chat;
  }
  
  const ChatItem._internal({required this.id, required senderId, required receiverId, message, imageUrl, required chatItemType, chatID, createdOn, chat}): _senderId = senderId, _receiverId = receiverId, _message = message, _imageUrl = imageUrl, _chatItemType = chatItemType, _chatID = chatID, _createdOn = createdOn, _chat = chat;
  
  factory ChatItem({String? id, required String senderId, required String receiverId, String? message, String? imageUrl, required ChatItemTyp chatItemType, String? chatID, TemporalTimestamp? createdOn, Chat? chat}) {
    return ChatItem._internal(
      id: id == null ? UUID.getUUID() : id,
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      imageUrl: imageUrl,
      chatItemType: chatItemType,
      chatID: chatID,
      createdOn: createdOn,
      chat: chat);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatItem &&
      id == other.id &&
      _senderId == other._senderId &&
      _receiverId == other._receiverId &&
      _message == other._message &&
      _imageUrl == other._imageUrl &&
      _chatItemType == other._chatItemType &&
      _chatID == other._chatID &&
      _createdOn == other._createdOn &&
      _chat == other._chat;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ChatItem {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("senderId=" + "$_senderId" + ", ");
    buffer.write("receiverId=" + "$_receiverId" + ", ");
    buffer.write("message=" + "$_message" + ", ");
    buffer.write("imageUrl=" + "$_imageUrl" + ", ");
    buffer.write("chatItemType=" + (_chatItemType != null ? enumToString(_chatItemType)! : "null") + ", ");
    buffer.write("chatID=" + "$_chatID" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.toString() : "null") + ", ");
    buffer.write("chat=" + (_chat != null ? _chat!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ChatItem copyWith({String? id, String? senderId, String? receiverId, String? message, String? imageUrl, ChatItemTyp? chatItemType, String? chatID, TemporalTimestamp? createdOn, Chat? chat}) {
    return ChatItem(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      imageUrl: imageUrl ?? this.imageUrl,
      chatItemType: chatItemType ?? this.chatItemType,
      chatID: chatID ?? this.chatID,
      createdOn: createdOn ?? this.createdOn,
      chat: chat ?? this.chat);
  }
  
  ChatItem.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _senderId = json['senderId'],
      _receiverId = json['receiverId'],
      _message = json['message'],
      _imageUrl = json['imageUrl'],
      _chatItemType = enumFromString<ChatItemTyp>(json['chatItemType'], ChatItemTyp.values),
      _chatID = json['chatID'],
      _createdOn = json['createdOn'] != null ? TemporalTimestamp.fromSeconds(json['createdOn']) : null,
      _chat = json['chat']?['serializedData'] != null
        ? Chat.fromJson(new Map<String, dynamic>.from(json['chat']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'senderId': _senderId, 'receiverId': _receiverId, 'message': _message, 'imageUrl': _imageUrl, 'chatItemType': enumToString(_chatItemType), 'chatID': _chatID, 'createdOn': _createdOn?.toSeconds(), 'chat': _chat?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "chatItem.id");
  static final QueryField SENDERID = QueryField(fieldName: "senderId");
  static final QueryField RECEIVERID = QueryField(fieldName: "receiverId");
  static final QueryField MESSAGE = QueryField(fieldName: "message");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageUrl");
  static final QueryField CHATITEMTYPE = QueryField(fieldName: "chatItemType");
  static final QueryField CHATID = QueryField(fieldName: "chatID");
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField CHAT = QueryField(
    fieldName: "chat",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Chat).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ChatItem";
    modelSchemaDefinition.pluralName = "ChatItems";
    
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
      key: ChatItem.SENDERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatItem.RECEIVERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatItem.MESSAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatItem.IMAGEURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatItem.CHATITEMTYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatItem.CHATID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ChatItem.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.timestamp)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ChatItem.CHAT,
      isRequired: false,
      targetName: "chatItemChatId",
      ofModelName: (Chat).toString()
    ));
  });
}

class _ChatItemModelType extends ModelType<ChatItem> {
  const _ChatItemModelType();
  
  @override
  ChatItem fromJson(Map<String, dynamic> jsonData) {
    return ChatItem.fromJson(jsonData);
  }
}