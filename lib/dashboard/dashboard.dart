import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:educationapp/connect_cube/login_screen.dart';
import 'package:educationapp/dashboard/class_id_page.dart';
import 'package:educationapp/group_chat/chat_main_file.dart';
import 'package:educationapp/group_chat/my_home.dart';
import 'package:educationapp/login/login.dart';
import 'package:educationapp/networking/class_data.dart';
import 'package:educationapp/test_planner/test_planner.dart';
import 'package:educationapp/time_table/time_table.dart';
import 'package:educationapp/video_call/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:educationapp/connect_cube/src/utils/configs.dart' as config;

class Dashboard extends StatefulWidget {
  static String id = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ClassData classData = ClassData();
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String classID;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.displayName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();

    super.initState();
    init(
      config.APP_ID,
      config.AUTH_KEY,
      config.AUTH_SECRET,
    );
  }

  int _currentIndex = 0;
  final firestoreInstance = Firestore.instance;

  void RetrieveClass() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance
        .collection("Classes")
        .document(firebaseUser.uid)
        .get()
        .then((value) {
      print(value.data["Classes"]);
      classID = value.data["Classes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: ClassIDPage()));
          },
          backgroundColor: Color(0xFFF0F3F4),
          child: Icon(Icons.school, color: Colors.blueAccent),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFFAFC8FA),
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: TestPlannerHome(),
                              type: PageTransitionType.fade));
                    },
                  ),
                  Container(),
                  IconButton(
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    splashColor: Colors.white,
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: LoginScreen(),
                              type: PageTransitionType.fade));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: classData.getClassData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.deepPurpleAccent,
                                  fontFamily: 'Merriweather',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${loggedInUser.displayName}',
                                style: TextStyle(
                                  fontSize: 23.0,
                                  fontFamily: 'Merriweather',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/welcome.png',
                          height: 150.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '${snapshot.data['Items'][0]['Org-name']['S']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.deepPurpleAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '${snapshot.data['Items'][0]['Address']['S']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Container(
                        height: 155.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFAFC8FA),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      '${snapshot.data['Items'][0]['Subject']['S']}',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Container(
                                      height: 10.0,
                                      width: 10.0,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      '10:30 am - 11:30 am',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      'Live Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreenVideoCall()));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Container(
                                              height: 35.0,
                                              width: 70.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    'Join',
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/images/maths.png',
                              height: 150.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          'Subject Selection',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (index) {
                        return new StaggeredTile.count(
                            1, index.isEven ? 1.2 : 1.8);
                      },
                      itemCount: 5,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ChatMainFile(index: index)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFcaebfc),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            '${snapshot.data['Items'][index]['Subject']['S']}',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Icon(
                                            Icons.person_outline,
                                            color: Colors.blueGrey,
                                            size: 17.0,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            '${snapshot.data['Items'][index]['Prof']['S']}',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Icon(
                                            Icons.location_city,
                                            color: Colors.blueGrey,
                                            size: 17.0,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Class - ${snapshot.data['Items'][index]['Class']['S']}',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            height: 7.0,
                                            width: 7.0,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Container(
                                            height: 7.0,
                                            width: 7.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE7D524),
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Container(
                                            height: 7.0,
                                            width: 7.0,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF417623),
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(snapshot.data.length);
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              child: BuildClasses(
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              bottom: 10.0,
                                              top: 15.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 40.0,
                                                    width: 40.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                          child: Icon(
                                                              Icons.assignment,
                                                              color: Colors
                                                                  .purple)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'assets/images/pie.png',
                                              height: 80.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
