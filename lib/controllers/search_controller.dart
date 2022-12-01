import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user_model.dart';

class SearchController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String searchText) async {
    _searchedUsers.bindStream(
      fireStore
          .collection('users')
          .where('userName', isEqualTo: searchText)
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<User> retVal = [];
          for (var element in querySnapshot.docs) {
            retVal.add(User.fromSnap(element));
          }
          return retVal;
        },
      ),
    );
  }
}
