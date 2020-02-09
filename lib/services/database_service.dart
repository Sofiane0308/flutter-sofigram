import 'package:sofigram/models/user_model.dart';
import 'package:sofigram/utilities/constants.dart';

class DatabaseService {
  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.proflieImageUrl,
      'bio': user.bio
    });
  }
}
