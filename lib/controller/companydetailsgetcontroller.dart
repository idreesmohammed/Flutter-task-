import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import '../model/detailsmodel.dart';

class GetDetailsController extends ChangeNotifier {
  final l = Logger();
  var finalvalue;

  Future getDetails() async {

    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {

      var result = jsonDecode(response.body);
      l.wtf(result);
      var companyDetailsModell = result;
      l.i(companyDetailsModell);
      finalvalue = companyDetailsModell
          .map((val) => CompanyDetailsModel(
              id: val["id"],
              name: val["name"],
              username: val["username"],
              email: val["email"],
              address: Address(
                  street: val["address"]["street"],
                  suite: val["address"]["suite"],
                  city: val["address"]["city"],
                  geo: Geo(
                      lat: val["address"]["geo"]["lat"],
                      lng: val["address"]["geo"]["lng"]),
                  zipcode: val["address"]["zipcode"]),
              phone: val["phone"],
              website: val["website"],
              company: Company(
                  name: val["company"]["name"],
                  catchPhrase: val["company"]["catchPhrase"],
                  bs: val["company"]["bs"])))
          .toList();
      // companyDetailsModell.map((value))

      notifyListeners();
    }
  }
}
