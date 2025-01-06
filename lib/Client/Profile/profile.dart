import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Client/Profile/bloc/cubit.dart';
import 'package:programing_languages/Client/Profile/bloc/status.dart';


class ProfileClient extends StatelessWidget {
   ProfileClient({super.key});
ProfileModel? profileModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileClientCubit()..getProfile(),
      child: BlocConsumer<ProfileClientCubit, ProfileClientStatus>(
        listener: (context, state) {
          if(state is ProfileClientSuccessStatus)
            profileModel=state.profileModel;
        },
        builder: (context, state) {
          return Scaffold(
            body:4!=5? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/images/person.png'),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'name',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'phone Number',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _showEditProfileDialog(context);
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                            label: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              _showChangePasswordDialog(context);
                            },
                            icon: Icon(Icons.sync_lock, color: Colors.white),
                            label: Text('Change Password'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ):Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
}


void _showEditProfileDialog(BuildContext context) {
  String? newName;
  String? newPhone;
  String? newEmail;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => newName = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Phone',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => newPhone = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => newEmail = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              print('Updating profile...');
              print('New Name: $newName');
              print('New Phone: $newPhone');
              print('New Email: $newEmail');

              Navigator.of(context).pop();
            },
            child: Text('Save'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _showChangePasswordDialog(BuildContext context) {
  String? oldPassword;
  String? newPassword;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) => oldPassword = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) => newPassword = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              print('Changing password...');
              print('Old Password: $oldPassword');
              print('New Password: $newPassword');

              Navigator.of(context).pop();
            },
            child: Text('OK'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      );
    },
  );
}