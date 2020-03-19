import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sofigram/models/post_model.dart';
import 'package:sofigram/models/user_model.dart';
import 'package:sofigram/utilities/constants.dart';

class DatabaseService {
  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        usersRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();
    return users;
  }

  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.proflieImageUrl,
      'bio': user.bio
    });
  }

  static void createPost(Post post) {
    postsRef.document(post.authorId).collection('userPosts').add({
      'imageUrl': post.imageUrl,
      'caption': post.caption,
      'likes': post.likeCount,
      'authorId': post.authorId,
      'timestamp': post.timestamp,
    });
  }

  static void followUser({String currentUserId, String userId}) {
    //add the user to the current user's following collection
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(userId)
        .setData({});
    //add current user to the user's followers collection
    followersRef
        .document(userId)
        .collection('userFollowers')
        .document(currentUserId)
        .setData({});
  }

  static void unfollowUser({String currentUserId, String userId}) {
    //remove the user to the current user's following collection
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(userId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //remove current user to the user's followers collection
    followersRef
        .document(userId)
        .collection('userFollowers')
        .document(currentUserId)
          ..get().then((doc) {
            if (doc.exists) {
              doc.reference.delete();
            }
          });
  }

  static Future<bool> isFollowingUser(
      {String currentUserId, String userId}) async {
    DocumentSnapshot followingDoc = await followersRef
        .document(userId)
        .collection('userFollowers')
        .document(currentUserId)
        .get();
    return followingDoc.exists;
  }

  static Future<int> numFollowing(String userId) async {
    QuerySnapshot followingSnapshot = await followingRef
        .document(userId)
        .collection('userFollowing')
        .getDocuments();
    return followingSnapshot.documents.length;
  }

  static Future<int> numFollowers(String userId) async {
    QuerySnapshot followersSnapshot = await followersRef
        .document(userId)
        .collection('userFollowers')
        .getDocuments();
    return followersSnapshot.documents.length;
  }

  static Future<List<Post>> getFeedPosts(String userId) async {
    QuerySnapshot feedSnapshot = await feedsRef
        .document(userId)
        .collection('userFeed')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        feedSnapshot.documents.map((doc) => Post.fromDoc(doc)).toList();
    return posts;
  }

  static Future<List<Post>> getUserPosts(String userId) async {
    QuerySnapshot userPostsSnapshot = await postsRef
        .document(userId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        userPostsSnapshot.documents.map((doc) => Post.fromDoc(doc)).toList();
    return posts;
  }

  static Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }

  static void likePost({String currentUserId, Post post}) {
    DocumentReference postRef = postsRef
        .document(post.authorId)
        .collection('userPosts')
        .document(post.id);
    postRef.get().then((doc) {
      int likeCount = doc.data['likeCount'];
      likeCount ++;
      postRef.updateData({'likeCount': likeCount});
      likesRef
          .document(post.id)
          .collection('postLikes')
          .document(currentUserId)
          .setData({});
    });
  }

  static void unlikePost({String currentUserId, Post post}) {
    DocumentReference postRef = postsRef
        .document(post.authorId)
        .collection('userPosts')
        .document(post.id);
    postRef.get().then((doc) {
      int likeCount = doc.data['likeCount'];
      likeCount --;
      postRef.updateData({'likeCount': likeCount});
      likesRef
          .document(post.id)
          .collection('postLikes')
          .document(currentUserId)
          .get()
          .then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    });
  }

  static Future<bool> didLikePost({String currentUserId, Post post}) async {
    DocumentSnapshot userDoc = await likesRef
        .document(post.id)
        .collection('postLikes')
        .document(currentUserId)
        .get();
    return userDoc.exists;
  }
}
