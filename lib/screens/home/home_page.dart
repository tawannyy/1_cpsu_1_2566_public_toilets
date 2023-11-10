import 'package:flutter/material.dart';
import 'package:public_toilets/models/toilet.dart';
import 'package:public_toilets/repositories/toilet_repository.dart';
import 'package:public_toilets/screens/home/add_toilet.dart';
import 'package:public_toilets/screens/home/toilet_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool value1 = false;
  List<Toilet>? _toilets;
  var _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getToilets();
  }

  getToilets() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var toilets = await ToiletRepository().getToilets();
      debugPrint('Number of toilets: ${toilets.length}');

      setState(() {
        _toilets = toilets;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.2),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage ?? '', textAlign: TextAlign.center),
            SizedBox(height: 5.0),
            ElevatedButton(onPressed: getToilets, child: Text('Retry')),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: _toilets!.length,
      itemBuilder: (ctx, i) {
        Toilet toilet = _toilets![i];
        return ToiletListItem(toilet: toilet);
      },
    );
  }

  void handleClickAdd() {
    Navigator.pushNamed(context, AddToiletPage.routeName).whenComplete(() {
      getToilets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Review'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleClickAdd,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 222, 250, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CategoryButton(
                            text: 'Author',
                            icon: Icons.water_drop,
                            color: Colors.lightBlue,
                            isSelected: value1,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Expanded(
                          child: CategoryButton(
                            text: 'ISBN',
                            icon: Icons.bolt,
                            color: Colors.lightBlue,
                            isSelected: value1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 50.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CategoryButton(
                            text: 'Public Year',
                            icon: Icons.star,
                            color: Colors.lightBlue,
                            isSelected: value1,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Expanded(
                          child: CategoryButton(
                            text: 'Type',
                            icon: Icons.bookmark,
                            color: Colors.lightBlue,
                            isSelected: value1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                  ),
                  CategoryButton(
                    text: 'Book List',
                    icon: Icons.account_balance_wallet,
                    color: Colors.purpleAccent,
                    isSelected: true,
                  ),
                ],
              ),
            ),
          ),
          // Your existing toilet-related code here
          Expanded(
            child: Stack(
              children: [
                if (_toilets?.isNotEmpty ?? false) buildList(),
                if (_errorMessage != null) buildError(),
                if (_isLoading) buildLoadingOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final bool isSelected;

  CategoryButton({
    required this.text,
    required this.icon,
    required this.color,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isSelected ? color : Colors.grey,
        ),
      ),
      onPressed: () {
        // Handle button press
      },
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 4.0),
          Text(text),
        ],
      ),
    );
  }
}
