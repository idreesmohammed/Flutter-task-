import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'controller/companydetailsgetcontroller.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  var data;
  final l = Logger();
  List<GetDetailsController> getData = [];
  @override
  void initState() {
    super.initState();
    getDetailsController();
  }

  getDetailsController() async {
    await Provider.of<GetDetailsController>(context, listen: false)
        .getDetails();
    await Provider.of<GetDetailsController>(context, listen: false).finalvalue;
    l.w("${Provider.of<GetDetailsController>(context, listen: false).finalvalue}");
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
                child: Text(
                    Provider.of<GetDetailsController>(context, listen: true)
                        .finalvalue[0]
                        .name),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(50.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(50.0),
                height: height * 0.2,
                width: width,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
