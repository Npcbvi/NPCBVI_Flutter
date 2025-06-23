import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_EyeScreeningEdit.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';

class EyeScreeningForm extends StatelessWidget {
  final Future<List<DataGetDPM_EyeScreeningEdit>> futureData;
  final TextEditingController controllerNameofSchool;
  final TextEditingController controllerAddressofSchool;
  final TextEditingController controllerNameofPrincipal;
  final TextEditingController controllerTeacherTrained;
  final TextEditingController controllerNumberofchildrenscreening;
  final TextEditingController controllerChildrendetectedwithRefractive;
  final TextEditingController controllerNumberoffreeGlasses;
  final VoidCallback onUpdate;
  final VoidCallback onReset;

  const EyeScreeningForm({
    Key key,
     this.futureData,
     this.controllerNameofSchool,
     this.controllerAddressofSchool,
     this.controllerNameofPrincipal,
     this.controllerTeacherTrained,
     this.controllerNumberofchildrenscreening,
     this.controllerChildrendetectedwithRefractive,
     this.controllerNumberoffreeGlasses,
     this.onUpdate,
     this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataGetDPM_EyeScreeningEdit>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Utils.getEmptyView("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Utils.getEmptyView("No data found");
        } else {
          List<DataGetDPM_EyeScreeningEdit> data = snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
// Set controller values from item
              controllerNameofSchool.text = item.schoolName ?? '';
              controllerAddressofSchool.text = item.schoolAddress ?? '';

              controllerNameofPrincipal.text = item.principal ?? '';
              controllerTeacherTrained.text=item.trainedTeacher.toString()??'';
              controllerNumberofchildrenscreening.text=  item.childScreen.toString()??'';
              controllerChildrendetectedwithRefractive.text=item.childDetect.toString()??'';
              controllerNumberoffreeGlasses.text=item.freeglass.toString()??'';
              return Column(
                children: [
                  _buildTextField(controllerNameofSchool, "Enter School Name", item.schoolName),
                  _buildTextField(controllerAddressofSchool, "Enter School Address", item.schoolAddress),
                  _buildTextField(controllerNameofPrincipal, "Enter Principal Name", item.principal),
                  _buildTextField(controllerTeacherTrained, "Enter Trainer Teacher", item.trainedTeacher.toString(), keyboardType: TextInputType.number),
                  _buildHeader("School Eye Screening"),
                  _buildTextField(controllerNumberofchildrenscreening, "Enter Child Screen", item.childScreen.toString(), keyboardType: TextInputType.number),
                  _buildTextField(controllerChildrendetectedwithRefractive, "Enter Child Detect", item.childDetect.toString(), keyboardType: TextInputType.number),
                  _buildTextField(controllerNumberoffreeGlasses, "Enter Free Glasses", item.freeglass.toString(), keyboardType: TextInputType.number),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("Update", onUpdate),
                      _buildButton("Reset", onReset),
                    ],
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)],
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ElevatedButton(
          child: Text(text),
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
