import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:mohfw_npcbvi/src/apihandler/ApiConstants.dart';
import 'package:mohfw_npcbvi/src/database/SharedPrefs.dart';
import 'package:mohfw_npcbvi/src/dpmdashboard/DPMDashboard.dart';
import 'package:mohfw_npcbvi/src/loginsignup/ForgotPasswordScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/LoginScreen.dart';
import 'package:mohfw_npcbvi/src/loginsignup/RegisterScreen.dart';
import 'package:mohfw_npcbvi/src/model/DashboardStateModel.dart';
import 'package:mohfw_npcbvi/src/model/LoginModel.dart';
import 'package:mohfw_npcbvi/src/model/changePassword/ChangePassword.dart';
import 'package:mohfw_npcbvi/src/model/contactus/ContactUS.dart';
import 'package:mohfw_npcbvi/src/model/dahbaord/GetDashboardModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMGovtPrivateOrganisationTypeData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRegistartionModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRivateMEdicalColleges.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMScreeningCamp.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMsatteliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPMDashboardData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_MOUApprove.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_PrivatePartition.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetNewHospitalData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientAPprovedwithFinanceYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientPendingwithFinance.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/NGOAPPlicationDropDownDPm.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_EyeScreeningEdit.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_EyeScreeningEdit.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetEyeScreening.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/SchoolEyeScreening_Registration.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPMGH_clickAPProved.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPM_NGOApprovedPending/GetDPM_NGOAPProved_pending.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_cataract.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_Glaucoma.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisonregister_diabitic.dart';
import 'package:mohfw_npcbvi/src/model/forgot/ForgotPasswordModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/Registration_of_Govt_Private_Other_Hospital_model.dart';
import 'package:mohfw_npcbvi/src/model/spoRegistartion/SPORegisterModel.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Utils.dart';
import 'dart:developer';
import 'package:mohfw_npcbvi/src/model/cities_model.dart';
import 'package:mohfw_npcbvi/src/model/country_state_model.dart';
import 'package:http/http.dart' as http;

class ApiController {
  static final int timeout = 18;

  static const cityURL =
      'https://countriesnow.space/api/v0.1/countries/state/cities/q?country';

  static Future<LoginModel> loginAPiRequest(UserData user) async {
    LoginModel loginModel = LoginModel();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.UserLogin;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({
          "username": user.loginId,
          "password": user.password,
          "platformName": Platform.isIOS ? "IOS" : "Android"
        });
        print(
            "@@Response--ParamsCheck with plattfor---" + url + body.toString());
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        // print("@@Response--ParamsCheck with plattfor---" + url+body.toString());
        print("@@Response--Api" + response1.toString());
        loginModel = LoginModel.fromJson(json.decode(response1.data));
        print("@@token" + loginModel.token);
        Result result = loginModel.result;
        print("@@Result message----" + result.message);
        if (result.status) {
          SharedPrefs.saveUser(loginModel.result.data);
          Utils.showToast(result.message, true);
        }
        return loginModel;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    //Way to send url with methodname
  }
  static Future<ChangePassword> changePAssword(GetChangeAPsswordFields getChangeAPsswordFields) async {
    ChangePassword changePassword = ChangePassword();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.ChangePassword;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({
          "userid": getChangeAPsswordFields.userid,
          "oldPassword": getChangeAPsswordFields.oldPassword,
          "newPassword": getChangeAPsswordFields.newPassword,
          "confirmPassword": getChangeAPsswordFields.confirmPassword,
          //"platformName": Platform.isIOS ? "IOS" : "Android"
        });
        print(
            "@@changePAssword1234-----" + url + body.toString());
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        // print("@@Response--ParamsCheck with plattfor---" + url+body.toString());
        print( "@@changePAssword1234---re--" + response1.toString());
        changePassword = ChangePassword.fromJson(json.decode(response1.data));
        print("@@changePAssword1234---re--df" + changePassword.message);
        if (changePassword.status) {

          print("@@changePAssword1234---re--dfhh" + changePassword.message);
          Utils.showToast(changePassword.message, true);
        }else{
          print("@@changePAssword1234---re--dfhhhhjjj" + changePassword.message);
          Utils.showToast(changePassword.message, true);
        }
        return changePassword;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    //Way to send url with methodname
  }
  static Future<SPORegisterModel> spoRegistrationAPiRquest(
      SPODataFields spoDataFields) async {
    SPORegisterModel spoRegisterModel = SPORegisterModel();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.spoRegistration;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({
          "state_code": spoDataFields.state,
          "name": spoDataFields.Name,
          "mobile": spoDataFields.mobileNumber,
          "email_id": spoDataFields.emailId,
          "designation": spoDataFields.designation,
          "std": spoDataFields.stdSPO,
          "phone_no": spoDataFields.PhoneNumber,
          "office_address": spoDataFields.OfficeAddress,
          "pincode": spoDataFields.PinCode,
          "user_id": "NPCB" + spoDataFields.codeSPOs,
        });
        print("@@spoRegistrationAPiRquest" + url + body);
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@spoRegistrationAPiRquest" + url + body);
        print("@@spoRegistrationAPiRquest--Api" + response1.toString());
        spoRegisterModel =
            SPORegisterModel.fromJson(json.decode(response1.data));
        //  Result result = loginModel.result;
        //  print("@@Result message----" + result.message);
        if (spoRegisterModel.status) {
          Utils.showToast(spoRegisterModel.message, true);
        } else {
          Utils.showToast(spoRegisterModel.message, true);
        }
        return spoRegisterModel;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
    //Way to send url with methodname
  }

  static Future<DPMRegistartionModel> DPMRegistrationAPiRquest(
      DPMDataFields dpmDataFields) async {
    DPMRegistartionModel dpmRegistartionModel = DPMRegistartionModel();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.DpmRegistration;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({
          "state_code": dpmDataFields.stateDPM,
          "district_code": dpmDataFields.distCodeDPM,
          "name": dpmDataFields.NameDPM,
          "mobile": dpmDataFields.mobileNumberDPM,
          "email_id": dpmDataFields.emailIdDPM,
          "designation": dpmDataFields.designationDPM,
          "std": dpmDataFields.stdDPMs,
          "phone_no": dpmDataFields.PhoneNumberDPM,
          "office_address": dpmDataFields.OfficeAddressDPM,
          "pincode": dpmDataFields.PinCodeDPM,
          "std": dpmDataFields.stdDPMs,
          //"user_id": "NPCB" + dpmDataFields.codeSPOsDPM,
          "user_id":
              dpmDataFields.codeSPOsDPM + "DPM" + dpmDataFields.distNameDPMs,
          "stateName": dpmDataFields.distNameDPMs,
          "districtName": dpmDataFields.distNameDPMs_distictValue,
        });
        print("@@DPMRegistrationAPiRquest-------" + url + body);
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@DPMRegistrationAPiRquest" + url + body);
        print("@@DPMRegistrationAPiRquest--Api" + response1.toString());
        dpmRegistartionModel =
            DPMRegistartionModel.fromJson(json.decode(response1.data));
        print("@@token" + dpmRegistartionModel.message);

        if (dpmRegistartionModel.status) {
          Utils.showToast(dpmRegistartionModel.message, true);
        } else {
          Utils.showToast(dpmRegistartionModel.message, true);
        }
        return dpmRegistartionModel;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    //Way to send url with methodname
  }

  static Future<SPORegisterModel> ngoRegistrationAPiRquest(
      SPODataFields spoDataFields) async {
    SPORegisterModel spoRegisterModel = SPORegisterModel();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.spoRegistration;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({
          "state_code": spoDataFields.state,
          "name": spoDataFields.Name,
          "mobile": spoDataFields.mobileNumber,
          "email_id": spoDataFields.emailId,
          "designation": spoDataFields.designation,
          "std": spoDataFields.stdSPO,
          "phone_no": spoDataFields.PhoneNumber,
          "office_address": spoDataFields.OfficeAddress,
          "pincode": spoDataFields.PinCode,
          "user_id": "NPCB" + spoDataFields.codeSPOs,
        });
        print("@@SPOURL" + url + body);
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@SPOURL" + url + body);
        print("@@SPOURL--Api" + response1.toString());
        spoRegisterModel =
            SPORegisterModel.fromJson(json.decode(response1.data));
        print("@@token" + spoRegisterModel.message);
        //  Result result = loginModel.result;
        //  print("@@Result message----" + result.message);
        if (spoRegisterModel.status) {
          Utils.showToast(spoRegisterModel.message, true);
        }
        return spoRegisterModel;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    //Way to send url with methodname
  }

  static Future<ContactUS> getHtmlForOptions() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetContacts'));
      Map<String, dynamic> json = jsonDecode(response.body);
      ContactUS contactUS = ContactUS.fromJson(json);
      if (contactUS.status) {
        // Utils.showToast(contactUS.message, true);
      }
      print('@@contactUS--' + contactUS.message);

      return contactUS;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  static Future<GetDashboardModel> getDashbaord() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/GetDashboard'));
      Map<String, dynamic> json = jsonDecode(response.body);
      GetDashboardModel contactUS = GetDashboardModel.fromJson(json);
      if (contactUS.status) {
        // Utils.showToast(contactUS.message, true);
        print('@@contactUS--' + contactUS.message);
      }

      return contactUS;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  static Future<ForgotPasswordModel> forgotPasswordApiRequest(
      ForgotPasswordDatas forgotPasswordData) async {
    ForgotPasswordModel forgotPasswordDatas = ForgotPasswordModel();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.SendOTPForForgotPassword;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({
          "mobileorEmail": forgotPasswordData.RadioOptionSelectMobileEmail,
          "userId": forgotPasswordData.userID,
        });
        print("@@forgotPasswordApiRequest" + url + body);
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@forgotPasswordApiRequest___2" + url + body);
        print("@@forgotPasswordApiRequest--Api" + response1.toString());
        forgotPasswordDatas =
            ForgotPasswordModel.fromJson(json.decode(response1.data));
        // print("@@token" + spoRegisterModel.message);
        //  Result result = loginModel.result;
        //  print("@@Result message----" + result.message);
        if (forgotPasswordDatas.status) {
          //Utils.showToast(forgotPasswordDatas.message, true);
          SharedPrefs.saveForgotPasswordData(forgotPasswordDatas);
        }
        return forgotPasswordDatas;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    //Way to send url with methodname
  }

  static Future<GovtPRivateModel> getEquipmentGovtPRivateModel() async {
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      final response = await http.get(Uri.parse(
          'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/Registration/api/GetEquipment'));
      Map<String, dynamic> json = jsonDecode(response.body);
      print('@@getGovtPRivateModel--' + json.toString());
      GovtPRivateModel govtPRivateModel = GovtPRivateModel.fromJson(json);
      if (govtPRivateModel.status) {
        //   Utils.showToast(govtPRivateModel.message, true);
        return govtPRivateModel;
      } else {
        Utils.showToast(govtPRivateModel.message, true);
        print('@@esleConfiti--' + govtPRivateModel.status.toString());
      }

      return govtPRivateModel;
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  static Future<ForgotPasswordModel> forgotPasswordOTPApiRequest(
      ForgotPasswordDatasOTPData forgotPasswordDatasOTPData) async {
    ForgotPasswordModel forgotPasswordDatas = ForgotPasswordModel(); // add here
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.UserForgotPassword;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({
          "userId": forgotPasswordDatasOTPData.user_id,
          "role_id": forgotPasswordDatasOTPData.role_id,
          "status": forgotPasswordDatasOTPData.status,
          "mobile": forgotPasswordDatasOTPData.mobile,
          "sr_no": forgotPasswordDatasOTPData.sr_no,
          "user_id": forgotPasswordDatasOTPData.user_id,
          "email_id": forgotPasswordDatasOTPData.email_id,
          "name": forgotPasswordDatasOTPData.name,
          "mobileorEmail": "",
          "otp": forgotPasswordDatasOTPData.opts,
        });
        print("@@forgotPasswordOTPApiRequest" + url + body);
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@forgotPasswordOTPApiRequest" + url + body);
        print("@@forgotPasswordOTPApiRequest--Api" + response1.toString());
        forgotPasswordDatas =
            ForgotPasswordModel.fromJson(json.decode(response1.data));
        // print("@@token" + spoRegisterModel.message);
        //  Result result = loginModel.result;
        //  print("@@Result message----" + result.message);
        if (forgotPasswordDatas.status) {
          //Utils.showToast(forgotPasswordDatas.message, true);
          // SharedPrefs.saveForgotPasswordData(forgotPasswordDatas);

        }
        return forgotPasswordDatas;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  static Future<Registration_of_Govt_Private_Other_Hospital_model>
      registration_of_Govt_Private_Other_Hospital(
          GovtPrivateRegistatrionDataFields
              govtPrivateRegistatrionDataFields) async {
    Registration_of_Govt_Private_Other_Hospital_model registrationModel =
        Registration_of_Govt_Private_Other_Hospital_model();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();

    if (isNetworkAvailable) {
      try {
        // Directly use the existing equipmentList from govtPrivateRegistatrionDataFields
        List<EquipmentName> equipmentList =
            govtPrivateRegistatrionDataFields.equipmentList ?? [];

        // Logging the equipmentList for debugging
        print("@@equipmentData---apicontroller" + equipmentList.toString());

        var url = ApiConstants.baseUrl +
            ApiConstants.registration_of_Govt_Private_Other_Hospital;

        Map<String, dynamic> payload = {
          "h_roleid":
              govtPrivateRegistatrionDataFields.dropDownvalueOrgnbaistaionTypes,
          "h_Name": govtPrivateRegistatrionDataFields.organisationNameGovt,
          "h_MobileNo": govtPrivateRegistatrionDataFields.MobileNoGovt,
          "h_EmailID": govtPrivateRegistatrionDataFields.EmailIDGovt,
          "h_Address": govtPrivateRegistatrionDataFields.AddressGovt,
          "h_PinCode": govtPrivateRegistatrionDataFields.pinCodeGovt,
          "h_Officer_Name": govtPrivateRegistatrionDataFields.OfficernameGovt,
          "mode": "",
          "h_stateid": govtPrivateRegistatrionDataFields.hStateid,
          "h_districtid": govtPrivateRegistatrionDataFields.hDistrictid,
          "inserttype": 0, // for insert data and 1 for update data
          "h_NIN_no": govtPrivateRegistatrionDataFields.HospitalNinNumber,
          "npcbnumber": "",
          "equipmentName": equipmentList,
        };

        print("@@registration_of_Govt_Private_Other_Hospital---" +
            url +
            payload.toString());

        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: payload,
            options: new Options(
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@registration_of_Govt_Private_Other_Hospital--Api" +
            response1.toString());
        // Assuming the API returns a status and message in response
        // Parse the response1 to update registrationModel accordingly
        registrationModel =
            Registration_of_Govt_Private_Other_Hospital_model.fromJson(
                jsonDecode(response1.data));
        if (registrationModel.status) {
          Utils.showToast(registrationModel.message, true);
        } else {
          Utils.showToast(registrationModel.message, true);
        }
        return registrationModel;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }

  static Future<GetDPMDashboardData> getDPM_Dashboard(
      int districtidDPM,  int stateidDPM,  int old_districtidDPM, String useridDPM,String roleidDPM, int statusDPM,String financialYearDPM) async {
    GetDPMDashboardData getDPMDashboardData = GetDPMDashboardData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch = prefs.getString(AppConstant.distritcCode) ?? "";
    String stateCode_loginFetch = prefs.getString(AppConstant.state_code) ?? "";
    print("@@districtCode_loginFetch__from login: $districtCode_loginFetch");
    print("@@stateCode_loginFetch__from login: $stateCode_loginFetch");
   /* if (districtCode_loginFetch.isEmpty || stateCode_loginFetch.isEmpty) {
      Utils.showToast("District or State code is missing.", true);
      return [];
    }*/

    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Dashboard;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
        };
        //Way to send params
        //Way to send params
        var body = json.encode({
          "districtid": districtidDPM,
          "stateid": stateidDPM,
          "old_districtid": 569,
          "userid": useridDPM,
          "roleid":roleidDPM,
          "status": statusDPM,
          "financialYear": financialYearDPM,
        });
        print("@@getDPM_Dashboard---api check parmeters--" + url + body.toString());
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        // print("@@Response--ParamsCheck with plattfor---" + url+body.toString());
        print("@@Response--Api" + response1.toString());
        getDPMDashboardData =
            GetDPMDashboardData.fromJson(json.decode(response1.data));
        print("@@getDPM_Dashboard====+ " + getDPMDashboardData.data.toString());

        print("@@Result_getDPM_Dashboard----" + getDPMDashboardData.message);
        if (getDPMDashboardData.status) {
          Utils.showToast(getDPMDashboardData.message, true);
        } else {
          Utils.showToast(getDPMDashboardData.message, true);
        }
        return getDPMDashboardData;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }


  static Future<List<DataNGOAPPlicationDropDownDPm>> getDPM_NGOApplicationDropDown(int district_code,int state_code ) async {
    print("@@getDPM_NGOApplicationDropDown"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_NGOApplication;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": 536,
        "state_code": 29,

      });
      print("@@getDPM_NGOApplicationDropDown--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getDPM_NGOApplicationDropDown--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      NGOAPPlicationDropDownDPm data = NGOAPPlicationDropDownDPm.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataGetNewHospitalData>> getDPM_HospitalApproval(int district_code,int state_code ) async {
    print("@@getDPM_HospitalApproval"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_HospitalApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,

      });
      print("@@getDPM_HospitalApproval--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getDPM_HospitalApproval--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetNewHospitalData data = GetNewHospitalData.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataDPMGovtPrivateOrganisationTypeData>> getDPM_GovtPvtOther(int district_code,int state_code,int organisationroleId ) async {
    print("@@getDPM_GovtPvtOther"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_GovtPvtOther;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "roleId":organisationroleId

      });
      print("@@getDPM_GovtPvtOther--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getDPM_HospitalApproval--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMGovtPrivateOrganisationTypeData data = DPMGovtPrivateOrganisationTypeData.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataGetDPM_NGOAPProved_pending>> getDPM_NGOAPProved_pendings(int district_code,int state_code,int status ) async {
    print("@@getDPM_NGOAPProved_pending"+"1");
    Response response1;


    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_NGOApprovedPending;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "status": status, // for approved
      });
      print("@@getDPM_NGOAPProved_pendings--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getDPM_NGOAPProved_pendings--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_NGOAPProved_pending data = GetDPM_NGOAPProved_pending.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DatagetDPMGH_clickAPProved>> getDPM_GetDPM_GHAPProved_pendings(int district_code,int state_code,int status ) async {
    print("@@DatagetDPMGH_clickAPProved--APProvedWala--"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_GH;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "status": status, // for approved
      });
      print("@@getDPM_NGOAPProved_pendings--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@DataGetDPM_NGOAPProved_pending--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      getDPMGH_clickAPProved data = getDPMGH_clickAPProved.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataGetDPM_PrivatePartition>> getDPM_PrivatePartition(int district_code,int state_code,int status ) async {
    print("@@getDPM_PrivatePartition"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_PrivatePartition;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "status": status, // for approved
      });
      print("@@DataGetDPM_PrivatePartition--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@DataGetDPM_PrivatePartition--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_PrivatePartition data = GetDPM_PrivatePartition.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataDPMRivateMEdicalColleges>> GetDPM_PrivateMedicalColleges(int district_code,int state_code,int status ) async {
    print("@@DataDPMRivateMEdicalColleges"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_PrivateMedicalCollege;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "status": status, // for approved
      });
      print("@@DataDPMRivateMEdicalColleges--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@DataDPMRivateMEdicalColleges--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMRivateMEdicalColleges data = DPMRivateMEdicalColleges.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataDPMsatteliteCenter>> GetDPM_SatelliteCentre(int district_code,int state_code ) async {
    print("@@DPMsatteliteCenter"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_SatelliteCentre;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
      });
      print("@@DPMsatteliteCenter--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetDPM_SatelliteCentre--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMsatteliteCenter data = DPMsatteliteCenter.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataGetDPM_MOUApprove>> getDPM_MOUApprove(int district_code,int organisationTypes,int organisationrSelectedoleId ) async {
    print("@@getDPM_MOUApprove"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_MOUApprove;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "organisationType": organisationTypes,
        "roleId":organisationrSelectedoleId

      });
      print("@@getDPM_MOUApprove--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetDPM_MOUApprove--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_MOUApprove data = GetDPM_MOUApprove.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }



  static Future<List<DataDPMScreeningCamp>> GetDPM_ScreeningCamp(int district_code,int state_code,String financialYear,String mode,String campType ) async {
    print("@@GetDPM_ScreeningCamp"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_ScreeningCamp;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "financialYear": financialYear,
        "mode": mode,
        "campType": campType
      });
      print("@@DPMScreeningCamp--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetDPM_SatelliteCentre--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMScreeningCamp data = DPMScreeningCamp.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.dataw;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }


  ///Pending work here
  static Future<List<DataGetDPM_PrivatePartition>> getPatiientApprovedPendingclick(int district_code,int state_code,int status ) async {
    print("@@getDPM_PrivatePartition"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_GH;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "status": status, // for approved
      });
      print("@@DataGetDPM_PrivatePartition--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@DataGetDPM_PrivatePartition--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_PrivatePartition data = GetDPM_PrivatePartition.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DataGetPatientAPprovedwithFinanceYear>> GetDPM_Patients_Approved_finacne(int district_code,int state_code,String financialYear ) async {
    print("@@GetDPM_Patients_Approved_finacne"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Patients_Approved;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "financialYear": financialYear, // for approved
      });
      print("@@DataGetDPM_PrivatePartition--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetDPM_Patients_Approved_finacne--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetPatientAPprovedwithFinanceYear data = GetPatientAPprovedwithFinanceYear.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataGetPatientPendingwithFinance>> GetDPM_Patients_Pending_finacne(int district_code,int state_code,String financialYear ) async {
    print("@@GetDPM_Patients_Pending_finacne"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Patients_Pending;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "financialYear": financialYear, // for approved
      });
      print("@@GetDPM_Patients_Pending_finacne--bodyprint--: ${body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetDPM_Patients_Approved_finacne--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetPatientPendingwithFinance data = GetPatientPendingwithFinance.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DataGetEyeScreening>> GetDPM_EyeScreening(int district_code,int state_code,String userid ) async {
    print("@@GetDPM_EyeScreening"+"1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_EyeScreening;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "userid": userid, // for approved
      });
      print("@@GetDPM_EyeScreening--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@DataGetDPM_PrivatePartition--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetEyeScreening data = GetEyeScreening.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<DataGetDPM_EyeScreeningEdit>> getDPM_EyeScreeningEdit(int district_code,int state_code,String userid ) async {
    print("@@GetDPM_EyeScreeningEdit"+"1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@schoolidSavedAfterclickEdit--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_EyeScreeningEdit;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "schoolid":schoolidSaved,
        "district_code": district_code,
        "state_code": state_code,
        "userid": userid, // for approved
      });
      print("@@GetDPM_EyeScreeningEdit--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@GetDPM_EyeScreeningEdit--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_EyeScreeningEdit data = GetDPM_EyeScreeningEdit.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<SchoolEyeScreening_Registration> getSchoolEyeScreening_Registration(GetSchoolEyeScreening_Registrations _getSchoolEyeScreening_Registrations ) async {
    print("@@getSchoolEyeScreening_Registration"+"1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getSchoolEyeScreening_Registration--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        // Define the URL and headers
        var url = ApiConstants.baseUrl +
            ApiConstants.GetSchoolEyeScreening_Registration;
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };

        // Define the request body
        var body = json.encode({
          "schoolid": _getSchoolEyeScreening_Registrations.schoolid,
          "district_code": _getSchoolEyeScreening_Registrations.district_code,
          "state_code": _getSchoolEyeScreening_Registrations.state_code,
          "status": _getSchoolEyeScreening_Registrations.status,
          "principal": _getSchoolEyeScreening_Registrations.principal,
          "monthid": _getSchoolEyeScreening_Registrations.monthid,
          "yearid": _getSchoolEyeScreening_Registrations.yearid,
          "entry_by": _getSchoolEyeScreening_Registrations.entry_by,
          "trained_teacher": _getSchoolEyeScreening_Registrations
              .trained_teacher,
          "child_screen": _getSchoolEyeScreening_Registrations.child_screen,
          "child_detect": _getSchoolEyeScreening_Registrations.child_detect,
          "freeglass": _getSchoolEyeScreening_Registrations.freeglass,
          "school_name": _getSchoolEyeScreening_Registrations.school_name,
          "school_address": _getSchoolEyeScreening_Registrations.school_address,

          // for approved
        });
        print("@@getSchoolEyeScreening_Registration--bodyprint--: ${url +
            body.toString()}");
        // Create Dio instance and make the request
        Dio dio = Dio();
        Response response = await dio.post(
          url,
          data: body,
          options: Options(
            headers: headers,
            contentType: "application/json",
            responseType: ResponseType.plain,
          ),
        );

        print(
            "@@GetDPM_EyeScreeningEdit--Api Response: ${response.toString()}");

        // Parse the response
        var responseData = json.decode(response.data);
        SchoolEyeScreening_Registration data = SchoolEyeScreening_Registration
            .fromJson(responseData);

        if (data.status) {
          Utils.showToast(data.message, true);
        } else {
          Utils.showToast(data.message, true);
        }
        return data;
      } catch (e) {
        Utils.showToast(e.toString(), true);
      }
    }
  }
  static Future<List<Datalowvisionregister_Glaucoma>> getDPM_Glaucoma(int district_code,int state_code,String npcbno,String financialYear,int organisationtypeValue ) async {
    print("@@getDPM_Glaucoma"+"1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_Glaucoma--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Glaucoma;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "npcbno": npcbno,
        "financialYear": financialYear,
        "organisationType": organisationtypeValue
      });
      print("@@getDPM_Glaucoma--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getDPM_Glaucoma--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      lowvisionregister_Glaucoma data = lowvisionregister_Glaucoma.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<Datalowvisionregister_cataract>> getDPM_Cataract(int district_code,int state_code,String npcbno,String financialYear,int organisationtypeValue  ) async {
    print("@@getDPM_Cataract"+"1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_Cataract--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Cataract;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "npcbno": npcbno,
        "financialYear": financialYear,
        "organisationType": organisationtypeValue
      });
      print("@@getDPM_Cataract--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getDPM_Cataract--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      lowvisionregister_cataract data = lowvisionregister_cataract.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<Datalowvisonregister_diabitic>> getDPM_Daiabetic(int district_code,int state_code,String npcbno,String financialYear,int organisationtypeValue  ) async {
    print("@@getDPM_Daiabetic"+"1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_Daiabetic--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Daiabetic;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "npcbno": npcbno,
        "financialYear": financialYear,
        "organisationType": organisationtypeValue
      });
      print("@@getDPM_Daiabetic--bodyprint--: ${url+body.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print("@@getDPM_Daiabetic--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      lowvisonregister_diabitic data = lowvisonregister_diabitic.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return [];
    }
  }

}
//https://www.geeksforgeeks.org/flutter-fetching-list-of-data-from-api-through-dio/
