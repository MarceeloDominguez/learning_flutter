import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<dynamic> users = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Call API'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.cyan,
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: ((context, index) {
//           final user = users[index];
//           final name = user['name']['first'];
//           final email = user['email'];
//           final imageUrl = user['picture']['thumbnail'];
//           return ListTile(
//             leading: ClipRRect(
//               borderRadius: BorderRadius.circular(100),
//               child: Image.network(imageUrl),
//             ),
//             title: Text(name),
//             subtitle: Text(email),
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: fetchUsers,
//       ),
//     );
//   }

//   void fetchUsers() async {
//     print('fetchUser called');
//     const url = 'https://randomuser.me/api/?results=20';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     final json = jsonDecode(body);
//     setState(() {
//       users = json['results'];
//     });
//     print('fetchUser completed');
//   }
// }

// ***************** //

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final String apiUrl = 'https://jsonplaceholder.typicode.com/users';

//   Future<List<dynamic>> fetchUsers() async {
//     final result = await http.get(Uri.parse(apiUrl));
//     return json.decode(result.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Call API'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.cyan,
//       ),
//       body: Center(
//         child: FutureBuilder<List<dynamic>>(
//           future: fetchUsers(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (!snapshot.hasData) return const CircularProgressIndicator();

//             return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     title: Text(snapshot.data[index]['name']),
//                     subtitle: Text(snapshot.data[index]['email']),
//                   );
//                 });
//           },
//         ),
//       ),
//     );
//   }
// }

// ***************** //

class User {
  String email;
  String name;
  String picture;

  User({required this.email, required this.name, required this.picture});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> _listUser;

  Future<List<User>> _getUser() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=20'));

    List<User> users = [];
    //print(users);

    if (response.statusCode == 200) {
      //print(response.body);
      final jsonData = jsonDecode(response.body);

      for (var item in jsonData['results']) {
        users.add(User(
          email: item['email'],
          name: item['name']['first'],
          picture: item['picture']['thumbnail'],
        ));
      }

      //print(users);

      return users;
    } else {
      throw Exception('Falló la conexión');
    }
  }

  @override
  void initState() {
    super.initState();
    _listUser = _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Fetch api'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: FutureBuilder(
        future: _listUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.data);
            return ListView(
              children: _listWidgetUser(snapshot.data),
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> _listWidgetUser(List<User>? data) {
    List<Widget> users = [];

    for (var user in data!) {
      users.add(Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(user.picture)),
              Text(user.email),
              Text(user.name),
            ],
          ),
        ),
      ));
    }

    return users;
  }
}
