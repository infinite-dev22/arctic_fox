import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_rent/pages/user_details/bloc/user_details_bloc.dart';

class UserDetailsScreenLayout extends StatelessWidget {
  final int id;

  const UserDetailsScreenLayout({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User $id'),
      ),

      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (context, state) {

          if(state.status == UserDetailsStatus.initial){
            context.read<UserDetailsBloc>().add(ViewUserDetailsEvent(id));
          } if(state.status ==  UserDetailsStatus.loading){
            return Center(child: CircularProgressIndicator(),);
          } if(state.status == UserDetailsStatus.success){
            return Column(
              children: [
                Text(state.user!.data!.name.toString()),
                Text(state.user!.data!.color.toString()),
                Text(state.user!.data!.pantoneValue.toString()),
                Text(state.user!.data!.year.toString()),
                Text(state.user!.data!.id.toString()),
                SizedBox(height: 3.h,),
                Text(state.user!.support!.url.toString()),
                Text(state.user!.support!.text.toString()),
              ],
            );
          } if(state.status == UserDetailsStatus.empty){
            return Center(child: Text('Users doesnt exist'),);
          } if(state.status == UserDetailsStatus.error){
            return Center(child: Text('An Error Occured'),);
          }

          return Container();

        },
      ),

    );
  }
}
