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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'Chat.dart';
import 'ChatItem.dart';
import 'Comment.dart';
import 'Post.dart';
import 'User.dart';
import 'UserChat.dart';

export 'Chat.dart';
export 'ChatItem.dart';
export 'ChatItemTyp.dart';
export 'Comment.dart';
export 'Post.dart';
export 'PostStatus.dart';
export 'PostTyp.dart';
export 'User.dart';
export 'UserChat.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "1cabd7544fdf2df511c5100446484c1a";
  @override
  List<ModelSchema> modelSchemas = [Chat.schema, ChatItem.schema, Comment.schema, Post.schema, User.schema, UserChat.schema];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;
  
  ModelType getModelTypeByModelName(String modelName) {
    switch(modelName) {
    case "Chat": {
    return Chat.classType;
    }
    break;
    case "ChatItem": {
    return ChatItem.classType;
    }
    break;
    case "Comment": {
    return Comment.classType;
    }
    break;
    case "Post": {
    return Post.classType;
    }
    break;
    case "User": {
    return User.classType;
    }
    break;
    case "UserChat": {
    return UserChat.classType;
    }
    break;
    default: {
    throw Exception("Failed to find model in model provider for model name: " + modelName);
    }
    }
  }
}