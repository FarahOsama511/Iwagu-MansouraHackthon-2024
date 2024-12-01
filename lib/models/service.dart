// import 'package:dio/dio.dart';
// import 'package:store_app/model/usermodel.dart';
// import 'package:store_app/services/Endpoints.dart';

// class Userservice {
//   static final String baseurl = "https://fakestoreapi.com";
//   static final Dio dio = Dio();
//   static Future<List<Usermodel>> getusers() async {
//     Response response = await dio.get("$baseurl/${Endpoints.users}");
//     final users = (response.data as List)
//         .map((user) => Usermodel.fromjson(user))
//         .toList();
//     print(response.data);
//     return users;
//   }

//   static Future<Usermodel?> checkemailandpass(
//       String username, String password) async {
//     List<Usermodel> user = await getusers();
//     for (var item in user) {
//       if (item.username == username && item.password == password) {
//         return item;
//       }
//     }
//     return null;
//   }

//   static Future<void> Signup(Map<String, dynamic> user) async {
//     try {
//       Response response = await dio.post('$baseurl/${Endpoints.users}',
//           data: user,
//           options: Options(headers: {'Content type': 'application/json'}));
//       if (response.statusCode == 200) {
//         print('User signed up successfully');
//       } else {
//         print("Failed to sign up");
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
