



import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  String _imageUrl = '';

  Future<void> _getImage() async {
    final input = FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    await input.onChange.first;
    final file = input.files!.first;
    final reader = FileReader();

    reader.readAsDataUrl(file);

    await reader.onLoad.first;
    final encoded = reader.result as String;

    setState(() {
      _imageUrl = encoded;
    });


  }
  //List<>
  //final User currentUser = // получение данных текущего пользователя из базы данных
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchTextController,
          decoration: InputDecoration(
            hintText: 'Введите поисковый запрос',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              final query = searchTextController.text;
              // Обработка запроса поиска
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Мой профиль')),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Мой профиль',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'currentUser.name',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'currentUser.email',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Редактирование профиля
                    },
                    child: Text('Редактировать профиль'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Мои друзья',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 55,
                      itemBuilder: (context, index) {
                        //final friend = currentUser.friends[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://picsum.photos/250?image=9'),
                          ),
                          title: Text('maks'),
                          subtitle: Text('123@123.3'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            // Переход к профилю друга
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  */
  /*
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       GestureDetector(
         onTap: _getImage,
         child: CircleAvatar(
           radius: 100.0,
           backgroundImage: _imageUrl.isNotEmpty
               ? Image.memory(
             _decodeBase64(_imageUrl.split(',').last),
             fit: BoxFit.cover,
           ).image
               : AssetImage('assets/images/profile_default.png'),
         ),
       ),
      ],
    );
  }*/

  Uint8List _decodeBase64(String input) {
    final bytes = base64.decode(input);
    return bytes;
  }
}









/*import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class Subscriber {
  final String name;
  final String photoUrl;
  final String bio;

  Subscriber({required this.name, required this.photoUrl, required this.bio});
}

class TabsScreen extends StatelessWidget {
  final List<Subscriber> subscribersList = [
    Subscriber(name: 'John Doe', photoUrl: 'assets/images/john_doe.svg', bio: 'Web Developer'),
    Subscriber(name: 'Jane Smith', photoUrl: 'assets/images/jane_smith.svg', bio: 'Graphic Designer'),
    Subscriber(name: 'Mark Johnson', photoUrl: 'assets/images/mark_johnson.svg', bio: 'Mobile Developer'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список подписчиков'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final subscriber = subscribersList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(subscriber: subscriber)));
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  /*SvgPicture.asset(
                    subscriber.photoUrl,
                    height: 64,
                    width: 64,
                  ),*/
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subscriber.name, style: TextStyle(fontSize: 20)),
                      SizedBox(height: 8),
                      Text(subscriber.bio),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: subscribersList.length,
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Subscriber subscriber;

  ProfileScreen({required this.subscriber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subscriber.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*SvgPicture.asset(
              subscriber.photoUrl,
              height: 128,
              width: 128,
            ),*/
            SizedBox(height: 16),
            Text(subscriber.name, style: TextStyle(fontSize: 32)),
            SizedBox(height: 16),
            Text(subscriber.bio, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
*/




/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Subscriber {
  final String name;
  //final String photoUrl;

  Subscriber({required this.name/*, required this.photoUrl*/});
}

class Subscription {
  final String name;
  //final String photoUrl;

  Subscription({required this.name/*, required this.photoUrl*/});
}

class Code {
  final String title;
  final String value;

  Code({required this.title, required this.value});
}

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  bool _isLoading = false;
  List<Subscriber> _subscribersList = [Subscriber(name: '1name'), Subscriber(name: '2name'),Subscriber(name: '3name'),Subscriber(name: '4name')];
  List<Subscription> _subscriptionsList = [Subscription(name: 'name1'), Subscription(name: 'name2'),Subscription(name: 'name3'),Subscription(name: 'name4')];
  List<Code> _codesList = [Code(title: '1title', value: '1value'),Code(title: '2title', value: '2value'),Code(title: '3title', value: '3value')];

  Future<List<Subscriber>> _fetchSubscribers() async {
    setState(() {
      _isLoading = true;
    });
    //final response = await http.get(Uri.parse('https://example.com/subscribers'));
    setState(() {
      _isLoading = false;
      _subscribersList = [Subscriber(name: '1name'), Subscriber(name: '2name'),Subscriber(name: '3name'),Subscriber(name: '4name')];
      //final List<dynamic> subscribersJsonList = json.decode(response.body)['subscribers'];
     /* _subscribersList = subscribersJsonList.map((subscriberJson) => Subscriber(
        name: subscriberJson['name'],
        photoUrl: subscriberJson['photo_url'],
      )).toList();*/
    });
    return _subscribersList;
  }

  Future<List<Subscription>> _fetchSubscriptions() async {
    setState(() {
      _isLoading = true;
    });
    //final response = await http.get(Uri.parse('https://example.com/subscriptions'));
    setState(() {
      _isLoading = false;
      _subscriptionsList = [Subscription(name: 'name1'), Subscription(name: 'name2'),Subscription(name: 'name3'),Subscription(name: 'name4')];
      //final List<dynamic> subscriptionsJsonList = json.decode(response.body)['subscriptions'];
      //_subscriptionsList = subscriptionsJsonList.map((subscriptionJson) => Subscription(
      //  name: subscriptionJson['name'],
      //  photoUrl: subscriptionJson['photo_url'],
      //)).toList();
    });
    return _subscriptionsList;
  }

  Future<List<Code>> _fetchCodes() async {
    setState(() {
      _isLoading = true;
    });
    //final response = await http.get(Uri.parse('https://example.com/codes'));
    setState(() {
      _isLoading = false;
      _codesList = [Code(title: '1title', value: '1value'),Code(title: '2title', value: '2value'),Code(title: '3title', value: '3value')];
      //final List<dynamic> codesJsonList = json.decode(response.body)['codes'];
      //_codesList = codesJsonList.map((codeJson) => Code(
      //  title: codeJson['title'],
      //  value: codeJson['value'],
      //)).toList();
    });
    return _codesList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Мои данные'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Подписчики'),
              Tab(text: 'Подписки'),
              Tab(text: 'Коды'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
              itemBuilder: (context, index) {
                final subscriber = _subscribersList[index];
                return ListTile(
                  leading: Image.network(/*subscriber.photoUrl*/'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                  title: Text(subscriber.name),
                );
              },
              itemCount: _subscribersList.length,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
              itemBuilder: (context, index) {
                final subscription = _subscriptionsList[index];
                return ListTile(
                  leading: Image.network(/*subscription.photoUrl*/'https://picsum.photos/250?image=9'),
                  title: Text(subscription.name),
                );
              },
              itemCount: _subscriptionsList.length,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
              itemBuilder: (context, index) {
                final code = _codesList[index];
                return ListTile(
                  title: Text(code.title),
                  subtitle: Text(code.value),
                );
              },
              itemCount: _codesList.length,
            ),
          ],
        ),
      ),
    );
  }
}*/