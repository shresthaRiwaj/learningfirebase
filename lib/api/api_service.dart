// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:learningfirebase/api/constant_api.dart';
// import 'package:learningfirebase/api/model_api.dart';


// class ApiService {
//   Future<List<Welcome>?> getUsers() async {
//     try {
//       var url = Uri.parse(ConstantApi.baseUrl + ApiConstants.usersEndpoint);
//       var response = await http.get(url);
//       if (response.statusCode == 200) {
//         List<UserModel> _model = we(response.body);
//         return _model;
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }