import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.put(SearchController());
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onFieldSubmitted: (value) => searchController.searchUser(value),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? const Center(
                  child: Text(
                    'Search User',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              : Obx(
                  () {
                    return ListView.builder(
                      itemCount: searchController.searchedUsers.length,
                      itemBuilder: (context, index) {
                        final searchedData =
                            searchController.searchedUsers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(uid: searchedData.uid),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  NetworkImage(searchedData.userImageUrl),
                            ),
                            title: Text(searchedData.userName),
                          ),
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
