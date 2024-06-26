import 'package:flutter/material.dart';
import 'package:mohfw_npcbvi/src/apihandler/ApiController.dart';
import 'package:mohfw_npcbvi/src/utils/AppColor.dart';
import 'package:mohfw_npcbvi/src/utils/Utils.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/ContactusHtmlDisplayScreen.dart';
import 'package:mohfw_npcbvi/src/widgets/web_view/DarpanWebview.dart';


class MainDashboard extends StatefulWidget {

  _MainDashboard createState() => _MainDashboard(); // connect using createState
}

class _MainDashboard extends State<MainDashboard> {
  bool isLoadingApi = true;

  String ngoCount,gH_CHC_Count,ppCount,campCount,satellitecentreCount,patientCount,dpm,
      pmcCount,totalEB,totalEd,spo;


  @override
  void initState() {
    super.initState();
    ApiController.getDashbaord().then((value) {
      setState(() {
        isLoadingApi = false;
        print('@@MainDashboard--' + value.message);
        if (value.status) {
          print('@@MainDashboard--' + value.status.toString());
          ngoCount=value.data.ngoCount;
          gH_CHC_Count=value.data.gHCHCCount;
          ppCount=value.data.ppCount;
          campCount=value.data.campCount;
          satellitecentreCount=value.data.satellitecentreCount;
          patientCount=value.data.patientCount;
          dpm=value.data.dpm;
          pmcCount=value.data.pmcCount;
          totalEB=value.data.totalEB;
          totalEd=value.data.totalEd;
          spo=value.data.spo;
            print('@@ngoCount--' + ngoCount);
          print('@@spo--' + spo);
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          'Dashboard',
          style: new TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Utils.hideKeyboard(context);
            return Navigator.pop(context, false); //is used to removed the top-most route off the navigator.
            // To go to a new screen, use the Navigator.push()
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.contact_page,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactusHtmlDisplayScreen()),
              );
              // do something
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height - MediaQuery
              .of(context)
              .padding
              .top,
          child:SingleChildScrollView( child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      '${ngoCount}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },

                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                        '${ngoCount}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Card(

                  color: Colors.white,
                  elevation: 5,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Stack(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Align(

                            child: Column(

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child:Container(
                                      child: Text(
                                        'NGO(s)',
                                        style: TextStyle(
                                            color: green2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),

                                    ),
                                  ),
                                ),
                                /*Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(

                                    child: Image.asset(
                                      'images/close.png', fit: BoxFit.fitWidth,),
                                  ),
                                ),*/
                                Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                    child: Text(
                                      "  title",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(6,4,6,4),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Text(
                                        'more..',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,20,10,10),

              ),
            ],
          ),),

        ),
      ),
    );
  }

}