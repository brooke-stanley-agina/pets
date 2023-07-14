import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pets/models/user_pets.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // For holding response as Userpets
  UserPets? userPets;

  // For data is loaded flag

  bool isDataLoaded = false;

  // error handling
  String? errorMesage;

  Future<UserPets> getDataFromAPI() async {
    Uri uri = Uri.parse(
        "https://jatinderji.github.io/users_pets_api/users_pets.json");

    var response = await http.get(uri);
    if (response.statusCode == 200) {
      //  All is ok

      UserPets userPets = userPetsFromJson(response.body);

      setState(() {
        isDataLoaded = true;
      });
      return userPets;
    } else {
      errorMesage = '${response.statusCode}: ${response.body}';
      return UserPets(data: []);
    }
  }

  callAPIanAssignData() async {
    userPets = await getDataFromAPI();
    setState(() {});
  }

  @override
  void initState() {
    callAPIanAssignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Pets"),
          centerTitle: true,
        ),
        body: !isDataLoaded
            ? errorMesage!.isNotEmpty
                ? Text("$errorMesage")
                : const Text("No Data")
            : userPets!.data.isEmpty
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: userPets!.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: userPets!.data[index].isFriendly
                                ? Colors.green
                                : Colors.red,
                            backgroundImage: NetworkImage(
                                "${userPets!.data[index].petImage}"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${userPets!.data[index].petName}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Dog: ${userPets!.data[index].userName}"),
                            ],
                          ),
                          trailing: Icon(
                            userPets!.data[index].isFriendly
                                ? Icons.pets
                                : Icons.do_not_touch,
                            color: userPets!.data[index].isFriendly
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      );
                    }));
  }
}
