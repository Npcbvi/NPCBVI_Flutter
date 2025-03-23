import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';

class EquipmentListWidget extends StatefulWidget {
  @override
  _EquipmentListWidgetState createState() => _EquipmentListWidgetState();
}

class _EquipmentListWidgetState extends State<EquipmentListWidget> {
  List<ListGovtPRivateModel> offerList = [];
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await ApiController.getEquipmentGovtPRivateModel();
    if (response.status) {
      setState(() {
        offerList = response.list;
        _controllers = List.generate(offerList.length, (index) => TextEditingController());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true, // ✅ Important to prevent infinite scrolling issue
          physics: NeverScrollableScrollPhysics(), // ✅ Disables ListView's scroll to prevent conflict
          itemCount: offerList.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20.0, 0),
                    child: Text(offerList[index].name, style: TextStyle(fontSize: 15)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 5, 4.0, 0),
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        offerList[index].quantity = value;
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

}
