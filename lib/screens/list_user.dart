import 'package:crud/widgets/lists.dart';
import 'package:crud/screens/create_user_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/inf.dart';
import '../widgets/my_bar.dart';

class ListUserScreen extends StatefulWidget {
  static const String list = '/list_route';

  const ListUserScreen({Key? key}) : super(key: key);

  @override
  State<ListUserScreen> createState() => _ListUserScreenState();
}

Future<void> refresh(BuildContext context) async {
  await fetshAndSetUsers();
}

var isInit = true;
var isLoading = false;

class _ListUserScreenState extends State<ListUserScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    void didChangeDependencies() {
      if (isInit) {
        setState(() {
          isLoading = true;
        });
        fetshAndSetUsers().then((_) => {
              setState(() {
                isLoading = false;
                isInit = false;
              })
            });
      }

      super.didChangeDependencies();
    }

    didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    double x1 = mediaQuery.size.width * 0.05;
    double x2 = (mediaQuery.size.width - x1) * 0.13;
    double x3 = (mediaQuery.size.width - x2) * 0.33;
    double x4 = (mediaQuery.size.width - x3) * 0.28;
    double x5 = (mediaQuery.size.width - x4) * 0.1;
    double x6 = (mediaQuery.size.width - x5) * 0.12;
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Mybar(co1: Colors.black, co2: Colors.blue),
          bottom: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: const Color.fromARGB(34, 152, 217, 254),
            shadowColor: Colors.blue,
            foregroundColor: Colors.blue,
            surfaceTintColor: Colors.blue,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: x1 - 5,
                    child: const Text(
                      textAlign: TextAlign.center,
                      '#',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: x2,
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Name',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: x3,
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Email',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: x4,
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Mobile',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: x6 * 2,
                  ),
                ]),
          ),
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                strokeWidth: 4,
                edgeOffset: 20,
                color: Colors.blue,
                onRefresh: () => refresh(context),
                child: myList.isEmpty
                    ? Center(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              const Icon(
                                size: 50,
                                Icons.no_accounts_outlined,
                                color: Colors.black,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 12),
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'There are no users yet',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      CreateUserScreen.create);
                                },
                                child: Container(
                                  height: 50,
                                  width: 250,
                                  color: Colors.blue,
                                  child: const Center(
                                    child: Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      'Click here to create new one',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: myList.length,
                        itemBuilder: (_, i) => Column(
                          children: [
                            Inf(
                              id: i + 1,
                              id1: myList[i].id1,
                              name: myList[i].name,
                              email: myList[i].email,
                              m: myList[i].m,
                            )
                          ],
                        ),
                      ),
              ),
      );
    });
  }
}
