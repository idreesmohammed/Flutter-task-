import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/constantcolors.dart';
import '../../constants/constantvariables.dart';
import '../../controller/sharedpreferences.dart';
import 'mappage.dart';
import 'userscreen.dart';

class MyProject extends StatefulWidget {
  const MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  var allData;
  var uid;
  var lat;
  var long;
  @override
  void initState() {
    getCredentials();
    //getDetailsFromUid();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const UserScreen()));
        return Future.value(false);
      },
      child: Scaffold(
        body: uid == null || uid.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: height * 0.3,
                        width: width,
                        child: const Text(
                          ConstantVariables.myProject,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        //color: Colors.red,
                      ),
                      SizedBox(
                          height: height * 0.45,
                          width: width,
                          //color: Colors.blue,
                          child: Column(
                            children: [
                              customBox(
                                  hintText: allData[0]['projectName'] ??
                                      ConstantVariables.notAssigned),
                              customBox(
                                  hintText: allData[0]['companyName'] ??
                                      ConstantVariables.notAssignedCompany),
                              customBox(
                                  hintText: allData[0]['website'] ??
                                      ConstantVariables.notAssignedWebsite),
                              customBox(
                                  hintText: allData[0]['website'] == null
                                      ? ConstantVariables.notAssignedLocation
                                      : "${allData[0]['companyAddress']}"
                                          "${allData[0]['catchParse']}"),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: SizedBox(
                          height: height * 0.25,
                          width: width,
                          //color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.07,
                                width: width * 0.72,
                                child: TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.zero)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black)),
                                    onPressed: () {
                                      if (allData[0]['lat'] == null) {
                                        const snackBar = SnackBar(
                                          content: Text(
                                              ConstantVariables.locationError),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapPage(
                                                      latitude: allData[0]
                                                          ['lat'],
                                                      longitude: allData[0]
                                                          ['lng'],
                                                    )));
                                      }
                                    },
                                    child: const Text(
                                      ConstantVariables.getLocation,
                                      style: TextStyle(
                                          color: ConstantColors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Padding customBox({hintText}) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: ConstantColors.black, fontWeight: FontWeight.w500),
              filled: true,
              fillColor: ConstantColors.grey),
        ));
  }

  getCredentials() async {
    await LocalStore().localStorage().then((value) {
      uid = value.getString('items');
    });
    await getDetailsFromUid();
  }

  getDetailsFromUid() async {
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('users');
    var querySnapshot = await _collection.where('id', isEqualTo: uid).get();

    setState(() {
      allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      lat = allData[0]['lat'];
      long = allData[0]['lng'];
    });
    // var dat =Text(allData.tostring().replaceAll('[]\\,\\', '')
  }
}
