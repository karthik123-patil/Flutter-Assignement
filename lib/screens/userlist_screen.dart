import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/userList.dart';
import 'package:flutter_assignment/repository/repo_provider.dart';
import 'package:flutter_assignment/screens/post_by_user.dart';
import 'package:flutter_assignment/screens/user_albums.dart';
import 'package:flutter_assignment/screens/user_to_dos.dart';

import '../utils/colors.dart';
import 'package:http/http.dart' as http;

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  RepoProvider repoProvider = RepoProvider();
  List userList = [];
  List<UserList> myModels = [];

  @override
  void initState() {
    getUserList();
    super.initState();
  }

  void getUserList() async {
    var response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    setState(() {
      myModels = (json.decode(response.body) as List)
          .map((i) => UserList.fromJson(i))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: const Text(
          "User List",
          style: TextStyle(
              color: AppColors.primaryColor,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              fontSize: 14,
              letterSpacing: 0.2),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: myModels.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/img_assignment.jpeg",
                                width: 50,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myModels[index].name.toString(),
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    letterSpacing: 0.2),
                              ),
                              Text(
                                myModels[index].email.toString(),
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    fontSize: 10,
                                    letterSpacing: 0.2),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/img_drop.png",
                                    color: AppColors.iconDarkColor,
                                    scale: 2,
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(
                                    myModels[index].address!.street.toString() + "," + myModels[index].address!.suite.toString() + ",\n" +myModels[index].address!.city.toString() + "-" + myModels[index].address!.zipcode.toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        fontSize: 10,
                                        letterSpacing: 0.2),
                                  ),
                                ],
                              ),


                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 5,),
                    ElevatedButton(
                      onPressed: () async{
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> PostByUserScreen(userId: myModels[index].id.toString())));
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:const BorderSide(color: AppColors.whiteColor)
                            )
                        ),
                      ),
                      child: const Text("Post", style: TextStyle(color:AppColors.primaryColor,fontSize: 14, fontWeight: FontWeight.w500,letterSpacing: 1, fontFamily: "poppinsNormal")),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> AlbumsScreen(userId: myModels[index].id.toString())));
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:const BorderSide(color: AppColors.whiteColor)
                            )
                        ),
                      ),
                      child: const Text("Album", style: TextStyle(color:AppColors.primaryColor,fontSize: 14, fontWeight: FontWeight.w500,letterSpacing: 1, fontFamily: "poppinsNormal")),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> UserToDosScreen(userId: myModels[index].id.toString())));
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:const BorderSide(color: AppColors.whiteColor)
                            )
                        ),
                      ),
                      child: const Text("To-Dos", style: TextStyle(color:AppColors.primaryColor,fontSize: 14, fontWeight: FontWeight.w500,letterSpacing: 1, fontFamily: "poppinsNormal")),
                    ),
                    const SizedBox(width: 5,),
                  ],
                ),
                const Divider(
                  color: AppColors.primaryColor,
                ),
              ],
            );
          }),
    );
  }
}
