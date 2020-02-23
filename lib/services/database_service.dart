import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sofigram/models/post_model.dart';
import 'package:sofigram/models/user_model.dart';
import 'package:sofigram/utilities/constants.dart';

class DatabaseService {

  static Future<QuerySnapshot> searchUsers(String name ){
    Future<QuerySnapshot> users = usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }


  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.proflieImageUrl,
      'bio': user.bio
    });
  }

  static void createPost(Post post){
    postsRef.document(post.authorId).collection('usersPosts').add({
      'imageUrl':post.imageUrl,
      'caption': post.caption,
      'likes': post.likes,
      'authorId': post.authorId,
      'timestamp': post.timestamp ,
    });
    
  }
}
