import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  static const methodChannel = MethodChannel('com.anohene.insurance');

  Future initialize() async {
    await methodChannel.invokeMethod("hoverInitial");
  }

  Future sendUssd(
      {@required String actionId, String licenseNumber}) async =>
      await methodChannel.invokeMethod(
          "hoverStartTransaction", {"action_id": actionId, "number": licenseNumber});


  @override
  void initState() {
    super.initState();
    initialize();
  }

  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E2329),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  labelText: 'Enter car license number',
                  labelStyle: TextStyle(color: Colors.white24),
                  hintText: 'eg: AS 45 21',
                  hintStyle: TextStyle(color: Colors.white24),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24),
                  ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFEA4934))
                )
                // border: InputBorder.none
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                height: 55,
                width: 200,
                child: Center(
                    child: Text(
                      'Check Insurance',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid)),
              ),
              onTap: () {
                if (_controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter car license number')));
                } else {
                  sendUssd(actionId: '26293b6d', licenseNumber: _controller.text);
                  _controller.clear();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
