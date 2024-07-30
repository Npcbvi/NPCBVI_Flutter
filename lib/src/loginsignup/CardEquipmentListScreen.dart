import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class CardEquipmentListScreen extends StatefulWidget {
  final ListGovtPRivateModel orderHistoryData;

  CardEquipmentListScreen(this.orderHistoryData);

//no build method
  _CardEquipmentListScreen createState() =>
      _CardEquipmentListScreen(orderHistoryData); // connect using createState
}

class _CardEquipmentListScreen extends State<CardEquipmentListScreen> {
  ListGovtPRivateModel orderHistoryData;
  final _equipmentDetailQtyController = new TextEditingController();

  _CardEquipmentListScreen(this.orderHistoryData);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('@@orderHistoryData' + orderHistoryData.toString());
    print('@@orderHistoryData' + orderHistoryData.name.toString());
    // To generate number on loading of page
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      //                   <--- border color
                      width: 1.0,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    orderHistoryData.name,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 10, 4.0, 0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, //
                      width: 0.4,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _equipmentDetailQtyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(color: Colors.white, height: 1.0),
      ],
    );
  }
}
