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
import 'package:mohfw_npcbvi/src/model/contactus/ContactUS.dart';
import 'package:mohfw_npcbvi/src/model/dahbaord/GetDashboardModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRegistartionModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPMDashboardData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_PrivatePartition.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/NGOAPPlicationDropDownDPm.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPMGH_clickAPProved.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPM_NGOApprovedPending/GetDPM_NGOAPProved_pending.dart';
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
      DPMDashboardParamsData dpmDashboardParamsData) async {
    GetDPMDashboardData getDPMDashboardData = GetDPMDashboardData();
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
          "districtid": 547,
          "stateid": 29,
          "old_districtid": 569,
          "userid": "",
          "roleid": "",
          "status": 5,
          "financialYear": "2024-2025",
        });
        print("@@getDPM_Dashboard---" + url + body.toString());
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

  static Future<NGOAPPlicationDropDownDPm> getDPM_NGOApplication(
      GetDPM_NGOApplication getDPM_NGOApplications) async {
    NGOAPPlicationDropDownDPm ngoapPlicationDropDownDPm =
        NGOAPPlicationDropDownDPm();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.GetDPM_NGOApplication;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({"district_code": 536, "state_code": 29});
        print("getDPM_NGOApplication---URL with params--" +
            url +
            body.toString());
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                contentType: "application/json",
                responseType: ResponseType.plain));
        // print("@@Response--ParamsCheck with plattfor---" + url+body.toString());
        print("@@getDPM_NGOApplication--Api--respnse--" + response1.toString());
        ngoapPlicationDropDownDPm =
            NGOAPPlicationDropDownDPm.fromJson(json.decode(response1.data));
        if (ngoapPlicationDropDownDPm.status) {
          print("@@getDPM_NGOApplication++++" +
              ngoapPlicationDropDownDPm.message);
        } else {
          Utils.showToast(ngoapPlicationDropDownDPm.message, true);
        }
        return ngoapPlicationDropDownDPm;
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
  /*static Future<GetDPM_NGOAPProved_pending> getDPM_NGOAPProved_pendings(
      ) async {
    print("@@getDPM_NGOAPProved_pending"+"1");
    GetDPM_NGOAPProved_pending getDPM_NGOAPProved_pendings = GetDPM_NGOAPProved_pending(); // add here
    Response response1;
   *//* SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch = prefs.getString(AppConstant.distritcCode);
    String stateCode_loginFetch = prefs.getString(AppConstant.state_code);
    int dpmAPPRoved_valueSendinAPi=2; // for approved
    int dpmPending_valueSendinAPi=1;
    print("@@districtCode_loginFetch"+"1--"+districtCode_loginFetch);
    print("@@stateCode_loginFetch"+"1"+stateCode_loginFetch);*//*
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.GetDPM_NGOApprovedPending;
        //Way to send headers
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "apikey": "Key123",
          "apipassword": "PWD123",
        };
        //Way to send params
        var body = json.encode({

          "district_code":1001 ,
          "state_code":  100,
          "status":  2, //for approved

        });
        print("@@getDPM_NGOAPProved_pending"+"1");
        print("@@getDPM_NGOAPProved_pending" + url + body);
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@getDPM_NGOAPProved_pending" + url + body);
        print("@@getDPM_NGOAPProved_pending--Api" + response1.toString());
        getDPM_NGOAPProved_pendings =
            GetDPM_NGOAPProved_pending.fromJson(json.decode(response1.data));

        if (getDPM_NGOAPProved_pendings.status) {
          Utils.showToast(getDPM_NGOAPProved_pendings.message, true);
          // SharedPrefs.saveForgotPasswordData(forgotPasswordDatas);

        }else{
          Utils.showToast(getDPM_NGOAPProved_pendings.message, true);
        }
        return getDPM_NGOAPProved_pendings;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }*/
  static Future<List<DataGetDPM_NGOAPProved_pending>> getDPM_NGOAPProved_pendings(int district_code,int state_code,int status ) async {
    print("@@getDPM_NGOAPProved_pending"+"1");
    Response response1;
   /* SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch = prefs.get(AppConstant.distritcCode);
    String stateCode_loginFetch = prefs.get(AppConstant.state_code);
    int dpmAPPRoved_valueSendinAPi=2; // for approved
    int dpmPending_valueSendinAPi=1;
    print("@@districtCode_loginFetch"+"1--"+districtCode_loginFetch);
    print("@@stateCode_loginFetch"+"1"+stateCode_loginFetch);
*/
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
    print("@@DataGetDPM_NGOAPProved_pending"+"1");
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

}
//https://www.geeksforgeeks.org/flutter-fetching-list-of-data-from-api-through-dio/
