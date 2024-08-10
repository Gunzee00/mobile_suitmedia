import 'package:flutter/material.dart';
import 'package:mobile_test/provider/palindrome_provider.dart';
import 'package:mobile_test/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fetchUsers();
    });

    _scrollController.addListener(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !userProvider.isLoading &&
          userProvider.hasMore) {
        userProvider.fetchUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading && userProvider.users.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (userProvider.users.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await userProvider.fetchUsers(refresh: true);
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  userProvider.users.length + (userProvider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == userProvider.users.length) {
                  return Center(child: CircularProgressIndicator());
                }

                final user = userProvider.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  onTap: () {
                    final palindromeProvider =
                        Provider.of<PalindromeProvider>(context, listen: false);
                    palindromeProvider
                        .updateName('${user.firstName} ${user.lastName}');
                    Navigator.pop(context);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
