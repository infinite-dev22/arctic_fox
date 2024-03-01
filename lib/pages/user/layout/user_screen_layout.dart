import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/pages/user/bloc/user_bloc.dart';
import 'package:smart_rent/pages/user_details/user_details_screen.dart';

class UserListScreenLayout extends StatelessWidget {
  const UserListScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List Screen'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        // bloc: UserBloc(),
        builder: (context, state) {
          print("Status is Initial: ${state.status == UserStatus.initial}");
          print("Status is Loading: ${state.status == UserStatus.loading}");
          print("Status is Success: ${state.status == UserStatus.success}");
          print("Status is Empty: ${state.status == UserStatus.empty}");
          print("Status is Error: ${state.status == UserStatus.error}");
          if (state.status == UserStatus.initial) {
            context.read<UserBloc>().add(LoadUserEvent());
          }
          if (state.status == UserStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == UserStatus.success) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.users!.length,
                  itemBuilder: (context, index) {
                    var user = state.users![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(
                              id: user.id!,
                            ),
                          ),
                        );
                      },
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(user.firstName.toString()),
                      )),
                    );
                  }),
            );
          }
          if (state.status == UserStatus.empty) {
            return const Center(
              child: Text('No Users'),
            );
          }
          if (state.status == UserStatus.error) {
            return const Center(
              child: Text('An error occurred'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
