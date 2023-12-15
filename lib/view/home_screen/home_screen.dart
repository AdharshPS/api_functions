import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:model_scample/controller/home_screen_controller.dart';
// import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreen = HomeScreenController();

  Future<void> fetchData() async {
    setState(() {});
    await homeScreen.getData();
    setState(() {});
    // await Provider.of<HomeScreenController>(context, listen: false).getData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  final titleData = TextEditingController();
  final desData = TextEditingController();
  int itemIndex = 0;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    // final details = Provider.of<HomeScreenController>(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: homeScreen.detailsModel.employees?.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homeScreen.detailsModel.employees?[index].employeeName ??
                          "",
                    ),
                    Text(
                      homeScreen.detailsModel.employees?[index].designation ??
                          "",
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          titleData.text = homeScreen.detailsModel
                                  .employees?[index].employeeName ??
                              "";
                          desData.text = homeScreen
                                  .detailsModel.employees?[index].designation ??
                              "";
                          itemIndex = index;
                          bottomSheet(context);
                          isEditing = true;
                        },
                        icon: Icon(Icons.edit)),
                    SizedBox(width: 10),
                    IconButton(
                        onPressed: () async {
                          await homeScreen.deleteData(
                            id: homeScreen.detailsModel.employees?[index].id,
                          );
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            isEditing = false;
            bottomSheet(context);
          }),
    );
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                controller: titleData,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "title",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: TextFormField(
                controller: desData,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "description",
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                isEditing == false
                    ? await homeScreen.postData(
                        empName: titleData.text.trim(),
                        des: desData.text.trim(),
                      )
                    : await homeScreen.updateData(
                        empName: titleData.text,
                        des: desData.text,
                        id: homeScreen.detailsModel.employees?[itemIndex].id ??
                            "");
                Navigator.pop(context);
                setState(() {});
                titleData.clear();
                desData.clear();
              },
              child: Text(
                isEditing == false ? "add" : "edit",
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
