import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertaskkssmart/controller/companydetailsgetcontroller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../constants/constantcolors.dart';
import '../../constants/constantvariables.dart';
import '../../controller/getuserdetails.dart';
import 'adminscreen.dart';
import 'package:logger/logger.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:convert';
import 'package:select_form_field/select_form_field.dart';

List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class CreateProject extends StatefulWidget {
  const CreateProject({Key? key}) : super(key: key);

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final l = Logger();
  var name;
  var catchParse;
  var getGeoLat, getGeoLng;
  var websiteDetails;
  var projectNameController = TextEditingController();
  var projectDate = TextEditingController();
  var companyAddress;
  var addressController = TextEditingController();
  var wesiteController = TextEditingController();
  var companyName = TextEditingController();
  var companyData;
  bool isLoading = false;
  var nameController = TextEditingController();
  List<Map<String, dynamic>> itemclass = [];
  String dropdownValue = list.first;
  var allData;
  var loop;
  //List<Map<String, dynamic>>  = [];
  var forLoopDatas;
  var dataLoop;
  var valuForuId;
  //The argument type 'List<dynamic>' can't be assigned to the parameter type 'List<Map<String, dynamic>>?'.
  List<Map<String, dynamic>> getWebsite = [];
  List<Map<String, dynamic>> nameList = [];
  List<Map<String, dynamic>> items = [];
  @override
  void initState() {
    getJsonPlaceHolder();
    setState(() {
      companyData = companyName.text;
    });

    getNetwork();
    //getDetailsController();
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  getDetailsController() async {
    await Provider.of<GetDetailsController>(context, listen: false)
        .getDetails();
    await Provider.of<GetDetailsController>(context, listen: false).finalvalue;
    l.w("hello${Provider.of<GetDetailsController>(context, listen: false).finalvalue}");
  }

  String dropdownvalue = 'select';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AdminScreen()));
        return Future.value(false);
      },
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: height * 0.17,
                    width: width,
                    child: const Text(
                      ConstantVariables.createProject,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    //color: Colors.red,
                  ),
                  SizedBox(
                      height: height * 0.7,
                      width: width,
                      //color: Colors.blue,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: TextFormField(
                                controller: projectNameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.projectName,
                                    hintStyle: TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: TextFormField(
                                readOnly: true,
                                controller: projectDate,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          datePicking();
                                        },
                                        icon: const Icon(
                                            Icons.arrow_drop_down_outlined)),
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.projectDate,
                                    hintStyle: const TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: SelectFormField(
                                type: SelectFormFieldType.dropdown,
                                onChanged: (val) {
                                  if (val != null) {
                                    getNetwork(website: val);
                                  } else {
                                    return;
                                  }
                                },
                                changeIcon: true,
                                items: getWebsite,
                                controller: wesiteController,
                                decoration: const InputDecoration(
                                    suffixIcon:
                                        Icon(Icons.arrow_drop_down_sharp),
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.website,
                                    hintStyle: TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: TextFormField(
                                controller: companyName,
                                onChanged: (val) {
                                  companyData = companyName.text;
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: companyData == "" ||
                                            companyData.isEmpty ||
                                            companyData == null
                                        ? "Company Name"
                                        : companyData,
                                    hintStyle: const TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: TextFormField(
                                controller: companyName,
                                onChanged: (val) {
                                  companyAddress = companyAddress.text;
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    //hintText: ,
                                    hintText: companyData == "" ||
                                            companyData.isEmpty ||
                                            companyData == null
                                        ? ConstantVariables.companyDetails
                                        : companyAddress + catchParse,
                                    hintStyle: const TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0),
                              child: SelectFormField(
                                type: SelectFormFieldType.dropdown,
                                onChanged: (val) {
                                  setState(() {
                                    getEmployeeNames();
                                  });
                                },
                                changeIcon: true,
                                items: nameList,
                                controller: nameController,
                                decoration: const InputDecoration(
                                    suffixIcon:
                                        Icon(Icons.arrow_drop_down_sharp),
                                    border: InputBorder.none,
                                    hintText: ConstantVariables.assignUser,
                                    hintStyle: TextStyle(
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.w500),
                                    filled: true,
                                    fillColor: ConstantColors.grey),
                              )),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: SizedBox(
                      height: height * 0.13,
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
                                            borderRadius: BorderRadius.zero)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ConstantColors.black)),
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (companyData == "" ||
                                      companyData.isEmpty ||
                                      companyData == null ||
                                      projectDate.text == "" ||
                                      projectNameController.text.isEmpty ||
                                      name == "" ||
                                      nameController.text.isEmpty) {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          ConstantVariables.createProjectError),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text(ConstantVariables
                                          .createdSuccessfully),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    getEmployeeNames();
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminScreen()));
                                    postFunction();
                                  }
                                },
                                child: const Text(
                                  ConstantVariables.submit,
                                  style: TextStyle(color: ConstantColors.white),
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
      ),
    );
  }

  fetchData() async {
    GetUserDetails().getData(allData: allData, loop: loop).then((value) {
      l.w(value);
      setState(() {
        valuForuId = value;
      });
      l.e("hi");
      l.w(valuForuId);
      l.e("hi");
      for (int i = 0; i < valuForuId.length; i++) {
        nameList.add(
            {"value": valuForuId[i]['name'], "label": valuForuId[i]['name']});
      }
      l.i(nameList);
    });
    //await filerFun();
  }

  getJsonPlaceHolder() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(url);
    var dataFiler = json.decode(response.body);
    l.w(dataFiler);

    for (int i = 0; i < dataFiler.length; i++) {
      l.e(dataFiler[i]['company']['name']);
      setState(() {
        //getWebsite.add(dataFiler[i]['website']);
        getWebsite.add({
          "value": dataFiler[i]['website'],
          "label": dataFiler[i]['website']
        });
      });
    }

    l.i(getWebsite);
  }

  getNetwork({website}) async {
    var choosWebsite;

    //hildegard.org
    //anastasia.net
    var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/users?website=$website');
    var response = await http.get(url);
    l.w(response.body);
    choosWebsite = json.decode(response.body);
    setState(() {
      companyData = choosWebsite[0]['company']['name'];
      companyAddress = choosWebsite[0]['address']['street'];
      websiteDetails = choosWebsite[0]['website'];
      getGeoLat = choosWebsite[0]['address']['geo']['lat'];
      getGeoLng = choosWebsite[0]['address']['geo']['lng'];
      catchParse = choosWebsite[0]['company']['catchPhrase'];
    });

    l.w(getGeoLng + getGeoLat);
    l.i(companyData);
    l.i(companyAddress);
    l.i(catchParse);
  }

  getEmployeeNames() async {
    List date = [];
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('users');
    var querySnapshot = _collection
        .where('name', isEqualTo: nameController.text)
        .snapshots()
        .listen((snapShotsValue) {
      setState(() {
        snapShotsValue.docs.map((doc) => l.e(doc.id)).toList();
        // name = snapShotsValue.docs.map((doc) => (doc.id)).toList();
        // snapShotsValue.docs.map((doc) => date.add(doc.id)).toString();
      });
      //print(snapShotsValue.id);
    });
    l.e(date);
    query();
  }

  query() async {
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await _collection.where('name', isEqualTo: nameController.text).get();
    allData = querySnapshot.docs.map((doc) => doc.id).toList();
    setState(() {
      // var dat =Text(allData.tostring().replaceAll('[]\\,\\', '')
    });
    l.w(allData[0].toString().replaceAll('[],\\', ''));
    return allData[0];
  }

  postFunction() async {
    final CollectionReference _collection =
        FirebaseFirestore.instance.collection('users');
    //docdatsa
    // final docData = ;
    _collection.doc(allData[0].toString().replaceAll('[],\\', '')).set({
      'projectName': projectNameController.text,
      'projectDate': projectDate.text,
      'website': websiteDetails.toString(),
      'companyName': companyData,
      'companyAddress': companyAddress.toString(),
      'catchParse': catchParse.toString(),
      'lat': getGeoLat,
      'lng': getGeoLng
    }, SetOptions(merge: true));
  }

  datePicking() async {
    var dateFormat = DateFormat('yyyy-MM-dd');
    var todaysDate = DateTime.now();
    var date = await showDatePicker(
        context: context,
        initialDate: todaysDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(todaysDate.year + 5));
    if (date == null) return;
    setState(() {
      projectDate.text = dateFormat.format(date);
    });
  }
}
