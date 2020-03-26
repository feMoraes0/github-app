import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url = 'https://api.github.com/users/femoraes0';
  Map<String, dynamic> data = {};
  List repositories = [0, 1, 2, 3];

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  void getData() async {
    dynamic response = await http.get(this.url);
    dynamic jsonData = json.decode(response.body);
    setState(() {
      this.data = jsonData;
    });
    response = await http.get(jsonData['repos_url']);
    setState(() {
      this.repositories = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size screen = MediaQuery.of(context).size;
    print(data);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.add_circle_outline,
          size: 28.0,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.search,
              size: 28.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screen.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: theme.primaryColor,
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Container(
                    height: screen.width * 0.40,
                    width: screen.width * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: Colors.redAccent,
                        image: DecorationImage(
                          image: NetworkImage(this.data['avatar_url']),
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color.fromRGBO(224, 105, 198, 1.0),
                    ),
                    child: Text(
                      'Sponsor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 3.0,
                ),
                child: Text(
                  this.data['name'],
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                this.data['login'],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white54,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 4.0,
                ),
                child: Text(
                  this.data['bio'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      left: 2.0,
                    ),
                    child: Text(
                      this.data['location'],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  this.data['blog'],
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'Repositories',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: this.repositories.length,
                      itemBuilder: (context, index) {
                        Map element = this.repositories[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                element['name'],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  element['description'] ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 10.0,
                                    ),
                                    child: Text(
                                      element['language'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 10.0,
                                    ),
                                    child: Text(
                                      element['stargazers_count'].toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.verified_user,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 10.0,
                                    ),
                                    child: Text(
                                      element['forks'].toString(),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
