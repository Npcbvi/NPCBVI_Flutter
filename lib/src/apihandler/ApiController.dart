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
import 'package:mohfw_npcbvi/src/model/districtngowork/AddEyeBankNGO/AddEyeBank.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/DoctorlinkedwithHospital.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/GetAllNgoService.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/GetDoctorDetailsById.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ManageDoctor.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/UploadedMOU/UploadMOUNGO.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/distictNgODashboard/NGODashboards.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/dropwdonHospitalBased/DropDownHospitalSelected.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/gethospitalList/GetHospitalList.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/gethospitalList/ViewClickHospitalDetails.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ngoCampWork/AddCampMagerRegister.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ngoCampWork/GetCampManagerDetailsByIdEditData.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ngoCampWork/NgoCampMangerList.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/ngoCampWork/updateCampManagerDetails.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/screeningcamp/ScreeningCampList.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMGovtPrivateOrganisationTypeData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRegistartionModel.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMRivateMEdicalColleges.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMScreeningCamp.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/DPMsatteliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPMCataractPatientView.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPMDashboardData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_MOUApprove.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetDPM_PrivatePartition.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetNewHospitalData.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientAPprovedwithFinanceYear.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/GetPatientPendingwithFinance.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/NGOAPPlicationDropDownDPm.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/ScreeningCampManager.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/childrenblindess/GetDPMCongenitalPtosis.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/childrenblindess/GetDPMSquint.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/childrenblindess/GetDPMTraumaChildren.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/dpmDashboardPatinetApproveDisesesViewClick/PatientapprovedSisesesViewclick.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/dpmReportScreen/ReportScreen.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_EyeScreeningEdit.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetDPM_EyeScreeningEdit.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/GetEyeScreening.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/eyescreening/SchoolEyeScreening_Registration.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPMGH_clickAPProved.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/getDPM_NGOApprovedPending/GetDPM_NGOAPProved_pending.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionCornealBlindness.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionVRSurgery.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_cataract.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisionregister_Glaucoma.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/lowvision/lowvisonregister_diabitic.dart';
import 'package:mohfw_npcbvi/src/model/forgot/ForgotPasswordModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/GovtPRivateModel.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/Registration_of_Govt_Private_Other_Hospital_model.dart';
import 'package:mohfw_npcbvi/src/model/govtprivate/govtPrivateRegisterUSerId.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/HospitalDashboard.dart';
import 'package:mohfw_npcbvi/src/model/ngoSatelliteMangerRegister/GetSatelliteManagerById.dart';
import 'package:mohfw_npcbvi/src/model/ngoSatelliteMangerRegister/SatelitteMangerDetails.dart';
import 'package:mohfw_npcbvi/src/model/ngoSatelliteMangerRegister/ngoSatelliteManagerRegistration.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/CenterOfficeNameSatelliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/GetSatelliteCenterList.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/SatelliteCenterRegistation.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeBankApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeBankDonationApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeSurgeons.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/PatientRegistrations.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/SPODashboardDPMClickView.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/SpoDashobardData.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/ApprovedclickPatients.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_DiseasewiseRecordsApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_Patients_Approved_View.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOAPPRovedClickListDetail.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOApprovalClick.dart';
import 'package:mohfw_npcbvi/src/model/spoRegistartion/SPORegisterModel.dart';
import 'package:mohfw_npcbvi/src/ngo/NgoDashboard.dart';
import 'package:mohfw_npcbvi/src/spo/SpoDashboard.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/screeningCamp/ScreenCampRegister.dart';
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

         // Utils.showToast(result.message, true);
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

  static Future<ChangePassword> changePAssword(
      GetChangeAPsswordFields getChangeAPsswordFields) async {
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
        print("@@changePAssword1234-----" + url + body.toString());
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        // print("@@Response--ParamsCheck with plattfor---" + url+body.toString());
        print("@@changePAssword1234---re--" + response1.toString());
        changePassword = ChangePassword.fromJson(json.decode(response1.data));
        print("@@changePAssword1234---re--df" + changePassword.message);
        if (changePassword.status) {
          print("@@changePAssword1234---re--dfhh" + changePassword.message);
          Utils.showToast(changePassword.message, true);
        } else {
          print(
              "@@changePAssword1234---re--dfhhhhjjj" + changePassword.message);
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

  static Future<ChangePassword> ngochangePAssword(
      GetChangeAPsswordFieldss getChangeAPsswordFields) async {
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
        print("@@changePAssword1234-----" + url + body.toString());
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        // print("@@Response--ParamsCheck with plattfor---" + url+body.toString());
        print("@@changePAssword1234---re--" + response1.toString());
        changePassword = ChangePassword.fromJson(json.decode(response1.data));
        print("@@changePAssword1234---re--df" + changePassword.message);
        if (changePassword.status) {
          print("@@changePAssword1234---re--dfhh" + changePassword.message);
          Utils.showToast(changePassword.message, true);
        } else {
          print(
              "@@changePAssword1234---re--dfhhhhjjj" + changePassword.message);
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

  static Future<ChangePassword> sPOchangePAssword(
      GetChangeAPsswordFieldsss getChangeAPsswordFields) async {
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
        print("@@changePAssword1234-----" + url + body.toString());
        //Way to send network calls
        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: body,
            options: new Options(
                headers: headers,
                contentType: "application/json",
                responseType: ResponseType.plain));
        // print("@@Response--ParamsCheck with plattfor---" + url+body.toString());
        print("@@changePAssword1234---re--" + response1.toString());
        changePassword = ChangePassword.fromJson(json.decode(response1.data));
        print("@@changePAssword1234---re--df" + changePassword.message);
        if (changePassword.status) {
          print("@@changePAssword1234---re--dfhh" + changePassword.message);
          Utils.showToast(changePassword.message, true);
        } else {
          print(
              "@@changePAssword1234---re--dfhhhhjjj" + changePassword.message);
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
  registration_of_Govt_Private_Other_Hospital(GovtPrivateRegistatrionDataFields
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

  static Future<govtPrivateRegisterUSerId> GetRegisteredUserGvtprivates(
      String registeredUserId /*,int stateid,int districtId*/) async {
    govtPrivateRegisterUSerId registrationModel = govtPrivateRegisterUSerId();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();

    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.GetRegisteredUser;

        Map<String, dynamic> payload = {
          "registeredUserId": registeredUserId,
          /*   "stateid": stateid,
          "districtId": districtId,*/
        };

        print("@@GetRegisteredUserGvtprivate---" + url + payload.toString());

        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: payload,
            options: new Options(
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@GetRegisteredUserGvtprivate--Api" + response1.toString());
        // Assuming the API returns a status and message in response
        // Parse the response1 to update registrationModel accordingly
        registrationModel =
            govtPrivateRegisterUSerId.fromJson(jsonDecode(response1.data));
        if (registrationModel.status) {
          Utils.showToast(registrationModel.message, true);
        } else {
          Utils.showToast("Wrong registered use id !", true);
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

  /*static Future<List<DatagovtPrivateRegisterUSerId>> GetRegisteredUserGvtprivate (String registeredUserId*/ /*,int stateid,int districtId*/ /*) async {
    print("@@GetRegisteredUserGvtprivate"+"1");
    govtPrivateRegisterUSerId registrationModel =
    govtPrivateRegisterUSerId();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@GetRegisteredUserGvtprivate--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl +  ApiConstants.GetRegisteredUser;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "registeredUserId": registeredUserId,

      });
      print("@@GetRegisteredUserGvtprivate--bodyprint--: ${url+body.toString()}");
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

      print("@@GetRegisteredUserGvtprivate--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      govtPrivateRegisterUSerId data = govtPrivateRegisterUSerId.fromJson(responseData);

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
  }*/

  static Future<GetDPMDashboardData> getDPM_Dashboard(int districtidDPM,
      int stateidDPM,
      int old_districtidDPM,
      String useridDPM,
      String roleidDPM,
      int statusDPM,
      String financialYearDPM) async {
    GetDPMDashboardData getDPMDashboardData = GetDPMDashboardData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
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
          "roleid": roleidDPM,
          "status": statusDPM,
          "financialYear": financialYearDPM,
        });
        print("@@getDPM_Dashboard---api check parmeters--" +
            url +
            body.toString());
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

  static Future<List<DataNGOAPPlicationDropDownDPm>>
  getDPM_NGOApplicationDropDown(int district_code, int state_code) async {
    print("@@getDPM_NGOApplicationDropDown" + "1");
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
        "district_code": district_code,
        "state_code": state_code,
      });
      print(
          "@@getDPM_NGOApplicationDropDown--bodyprint--: ${url +
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
          "@@getDPM_NGOApplicationDropDown--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      NGOAPPlicationDropDownDPm data =
      NGOAPPlicationDropDownDPm.fromJson(responseData);

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

  static Future<List<DataGetNewHospitalData>> getDPM_HospitalApproval(
      int district_code, int state_code) async {
    print("@@getDPM_HospitalApproval" + "1");
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
      print("@@getDPM_HospitalApproval--bodyprint--: ${url + body.toString()}");
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

  static Future<List<DataDPMGovtPrivateOrganisationTypeData>>
  getDPM_GovtPvtOther(int district_code, int state_code,
      int organisationroleId) async {
    print("@@getDPM_GovtPvtOther" + "1");
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
        "roleId": organisationroleId
      });
      print("@@getDPM_GovtPvtOther--bodyprint--: ${url + body.toString()}");
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
      DPMGovtPrivateOrganisationTypeData data =
      DPMGovtPrivateOrganisationTypeData.fromJson(responseData);

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

  static Future<List<DataGetDPM_NGOAPProved_pending>>
  getDPM_NGOAPProved_pendings(int district_code, int state_code,
      int status) async {
    print("@@getDPM_NGOAPProved_pending" + "1");
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

      print(
          "@@getDPM_NGOAPProved_pendings--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_NGOAPProved_pending data =
      GetDPM_NGOAPProved_pending.fromJson(responseData);

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

  static Future<List<DatagetDPMGH_clickAPProved>>
  getDPM_GetDPM_GHAPProved_pendings(int district_code, int state_code,
      int status) async {
    print("@@DatagetDPMGH_clickAPProved--APProvedWala--" + "1");
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

      print(
          "@@DataGetDPM_NGOAPProved_pending--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      getDPMGH_clickAPProved data =
      getDPMGH_clickAPProved.fromJson(responseData);

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

  static Future<List<DataGetDPM_PrivatePartition>> getDPM_PrivatePartition(
      int district_code, int state_code, int status) async {
    print("@@getDPM_PrivatePartition" + "1");
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

      print(
          "@@DataGetDPM_PrivatePartition--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_PrivatePartition data =
      GetDPM_PrivatePartition.fromJson(responseData);

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

  static Future<List<DataDPMRivateMEdicalColleges>>
  GetDPM_PrivateMedicalColleges(int district_code, int state_code,
      int status) async {
    print("@@DataDPMRivateMEdicalColleges" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetDPM_PrivateMedicalCollege;
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

      print(
          "@@DataDPMRivateMEdicalColleges--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMRivateMEdicalColleges data =
      DPMRivateMEdicalColleges.fromJson(responseData);

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

  static Future<List<DataDPMsatteliteCenter>> GetDPM_SatelliteCentre(
      int district_code, int state_code) async {
    print("@@DPMsatteliteCenter" + "1");
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
      print("@@DPMsatteliteCenter--bodyprint--:${url}+ ${body.toString()}");
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

      print("@@GetDPM_SatelliteCentre--Api Response: ${url}+ ${body.toString()}+${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMsatteliteCenter data = DPMsatteliteCenter.fromJson(responseData);

      if (data.status) {
       // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
     //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
     // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DataGetDPM_MOUApprove>> getDPM_MOUApprove(
      int district_code,
      int organisationTypes,
      int organisationrSelectedoleId) async {
    print("@@getDPM_MOUApprove" + "1");
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
        "roleId": organisationrSelectedoleId
      });
      print("@@getDPM_MOUApprove--bodyprint--: ${url + body.toString()}");
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

  static Future<List<DataDPMScreeningCamp>> GetDPM_ScreeningCamp(
      int district_code,
      int state_code,
      String financialYear,
      String mode,
      String campType) async {
    print("@@GetDPM_ScreeningCamp" + "1");
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

      print("@@GetDPM_SatelliteCentre--Api Response yaha se--: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMScreeningCamp data = DPMScreeningCamp.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.dataw;
      } else {
      //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
    //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  ///Pending work here
  static Future<List<DataGetDPM_PrivatePartition>>
  getPatiientApprovedPendingclick(int district_code, int state_code,
      int status) async {
    print("@@getDPM_PrivatePartition" + "1");
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

      print(
          "@@DataGetDPM_PrivatePartition--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_PrivatePartition data =
      GetDPM_PrivatePartition.fromJson(responseData);

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

  static Future<List<DataGetPatientAPprovedwithFinanceYear>>
  GetDPM_Patients_Approved_finacne(int district_code, int state_code,
      String financialYear) async {
    print("@@GetDPM_Patients_Approved_finacne" + "1");
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

      print(
          "@@GetDPM_Patients_Approved_finacne--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetPatientAPprovedwithFinanceYear data =
      GetPatientAPprovedwithFinanceYear.fromJson(responseData);

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

  static Future<List<DataGetPatientPendingwithFinance>>
  GetDPM_Patients_Pending_finacne(int district_code, int state_code,
      String financialYear) async {
    print("@@GetDPM_Patients_Pending_finacne" + "1");
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
      print(
          "@@GetDPM_Patients_Pending_finacne--bodyprint--: ${body.toString()}");
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
          "@@GetDPM_Patients_Approved_finacne--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetPatientPendingwithFinance data =
      GetPatientPendingwithFinance.fromJson(responseData);

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

  static Future<List<DataGetEyeScreening>> GetDPM_EyeScreening(
      int district_code, int state_code, String userid) async {
    print("@@GetDPM_EyeScreening" + "1");
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
      print("@@GetDPM_EyeScreening--bodyprint--: ${url + body.toString()}");
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
          "@@DataGetDPM_PrivatePartition--Api Response: ${response
              .toString()}");

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

  static Future<List<DataGetDPM_EyeScreeningEdit>> getDPM_EyeScreeningEdit(
      int district_code, int state_code, String userid) async {
    print("@@GetDPM_EyeScreeningEdit" + "1");
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
        "schoolid": schoolidSaved,
        "district_code": district_code,
        "state_code": state_code,
        "userid": userid, // for approved
      });
      print("@@GetDPM_EyeScreeningEdit--bodyprint--: ${url + body.toString()}");
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
      GetDPM_EyeScreeningEdit data =
      GetDPM_EyeScreeningEdit.fromJson(responseData);

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

  static Future<SchoolEyeScreening_Registration>
  getSchoolEyeScreening_Registration(GetSchoolEyeScreening_Registrations
  _getSchoolEyeScreening_Registrations) async {
    print("@@getSchoolEyeScreening_Registration" + "1");
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
          "trained_teacher":
          _getSchoolEyeScreening_Registrations.trained_teacher,
          "child_screen": _getSchoolEyeScreening_Registrations.child_screen,
          "child_detect": _getSchoolEyeScreening_Registrations.child_detect,
          "freeglass": _getSchoolEyeScreening_Registrations.freeglass,
          "school_name": _getSchoolEyeScreening_Registrations.school_name,
          "school_address": _getSchoolEyeScreening_Registrations.school_address,

          // for approved
        });
        print(
            "@@getSchoolEyeScreening_Registration--bodyprint--: ${url +
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
        SchoolEyeScreening_Registration data =
        SchoolEyeScreening_Registration.fromJson(responseData);

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

  static Future<List<Datalowvisionregister_Glaucoma>> getDPM_Glaucoma(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_Glaucoma" + "1");
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
      print("@@getDPM_Glaucoma--bodyprint--: ${url + body.toString()}");
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
      lowvisionregister_Glaucoma data =
      lowvisionregister_Glaucoma.fromJson(responseData);

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

  static Future<List<Datalowvisionregister_cataract>> getDPM_Cataract(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_Cataract" + "1");
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
      print("@@getDPM_Cataract--bodyprint--: ${url + body.toString()}");
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
      lowvisionregister_cataract data =
      lowvisionregister_cataract.fromJson(responseData);

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

  static Future<List<Datalowvisonregister_diabitic>> getDPM_Daiabetic(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_Daiabetic" + "1");
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
      print("@@getDPM_Daiabetic--bodyprint--: ${url + body.toString()}");
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
      lowvisonregister_diabitic data =
      lowvisonregister_diabitic.fromJson(responseData);

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

  static Future<List<DatalowvisionCornealBlindness>> getDPM_CornealBlindness(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_CornealBlindness" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_CornealBlindness--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_CornealBlindness;
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
      print("@@GetDPM_CornealBlindness--bodyprint--: ${url + body.toString()}");
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
      lowvisionCornealBlindness data =
      lowvisionCornealBlindness.fromJson(responseData);

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

  static Future<List<DatalowvisionVRSurgery>> getDPM_VRSurgery(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@GetDPM_VRSurgery" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@GetDPM_VRSurgery--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_VRSurgery;
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
      print("@@GetDPM_VRSurgery--bodyprint--: ${url + body.toString()}");
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

      print("@@GetDPM_VRSurgery--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      lowvisionVRSurgery data = lowvisionVRSurgery.fromJson(responseData);

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

  static Future<List<DataGetDPMCongenitalPtosis>> getDPM_CongenitalPtosis(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_CongenitalPtosis" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_CongenitalPtosis--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_CongenitalPtosis;
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
      print("@@getDPM_CongenitalPtosis--bodyprint--: ${url + body.toString()}");
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

      print("@@getDPM_CongenitalPtosis--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPMCongenitalPtosis data = GetDPMCongenitalPtosis.fromJson(
          responseData);

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

  static Future<List<DataGetDPMTraumaChildren>> getDPM_Trauma(int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_Trauma" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    //  print("@@getDPM_Trauma--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_TraumaChildren;
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
      print("@@getDPM_Trauma--bodyprint--: ${url + body.toString()}");
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

      print("@@getDPM_CongenitalPtosis--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPMTraumaChildren data = GetDPMTraumaChildren.fromJson(responseData);

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

  static Future<List<DataGetDPMSquint>> getDPM_Squintapproval(int district_code,
      int state_code,
      String npcbno,
      String organisationtypeValue) async {
    print("@@getDPM_Squintapproval" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    //  print("@@getDPM_Trauma--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Squintapproval;
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
        "status": "4"
      });
      print("@@getDPM_Squintapproval--bodyprint--: ${url + body.toString()}");
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

      print("@@getDPM_Squintapproval--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPMSquint data = GetDPMSquint.fromJson(responseData);

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

  static Future<List<DataPatientapprovedSisesesViewclick>>
  GetDPM_Patients_Approved_View(int district_code, int state_code,
      String financialYear, String mode, int diseaseid) async {
    print("@@GetDPM_Patients_Approved_View" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetDPM_Patients_Approved_View;
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
        "diseaseid": diseaseid // for approved
      });
      print("@@GetDPM_Patients_Approved_View--bodyprint--: ${body.toString()}");
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
          "@@GetDPM_Patients_Approved_View--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      PatientapprovedSisesesViewclick data =
      PatientapprovedSisesesViewclick.fromJson(responseData);

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

  static Future<List<DataReportScreen>> GetData_by_allngo_amount_totalCount(
      int year, String _selectedDateText, String _selectedDateTextToDate,
      int stateId, int districtId, String orgtype, String bindOrganisationNAme,
      String status, String financialYear, String npcbno) async {
    print("@@GetData_by_allngo_amount_totalCount" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl +
          ApiConstants.GetData_by_allngo_amount_totalCount;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "mode": "string",
        "year": year,
        "fromdate": _selectedDateText,
        "todate": _selectedDateTextToDate,
        "stateid": stateId,
        "districtid": districtId,
        "olddistrictid": 0,
        "orgtype": orgtype,
        "ngo": bindOrganisationNAme,
        "status": status,
        "financialYear": financialYear,
        "npcbno": npcbno
      });
      print(
          "@@GetData_by_allngo_amount_totalCount--bodyprint--: ${body
              .toString()}");
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
          "@@GetData_by_allngo_amount_totalCount--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ReportScreen data = ReportScreen.fromJson(responseData);

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

  static Future<List<DataGetDPMCataractPatientView>>
  getDPM_CataractPatientView(String mode, String p_DeseaseId, String npcbNo,
      String p_vStatus, int orgType) async {
    print("@@getDPM_CataractPatientView" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetDPM_CataractPatientView;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "mode": mode,
        "p_DeseaseId": p_DeseaseId,
        "p_UserID": npcbNo,
        "p_vStatus": p_vStatus,

        "orgType": orgType // for approved
      });
      print("@@getDPM_CataractPatientView--bodyprint--: ${body.toString()}");
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
          "@@getDPM_CataractPatientView--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPMCataractPatientView data =
      GetDPMCataractPatientView.fromJson(responseData);

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

  static Future<List<DataNGODashboards>>
  getNGODashboard(int userRoleType, int districtid, int stateid, String userId,
      String financialYear, int organizationType, String ngoId) async {
    print("@@getNGODashboard_modified" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.NGODashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "userRoleType": userRoleType,
        "districtId": districtid,
        "stateId": stateid,
        "userId": userId,
        "financialYear": financialYear,
        "organizationType": organizationType,
        "ngoId": ngoId
      });
      print("@@getNGODashboard--bodyprint--: ${body.toString()}");
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
          "@@getNGODashboard--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      NGODashboards data = NGODashboards.fromJson(responseData);

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

  static Future<List<DataGetHospitalList>>
  getHospitalList(String darpanNo, int districtid, String userId) async {
    print("@@GetHospitalList" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetHospitalList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "darpanNo": darpanNo,
        "districtId": districtid,

        "userId": userId,


      });
      print("@@GetHospitalList--bodyprint--: ${body.toString()}");
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
          "@@GetHospitalList--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetHospitalList data = GetHospitalList.fromJson(responseData);

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

  static Future<
      List<HospitalDetailsDataViewClickHospitalDetails>> viewHospitalDetails(
      String darpanNo, String hospitalId, int districtId, String userId) async {
    print("@@GetHospitalList - Initiating request");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      final url = "${ApiConstants.baseUrl}${ApiConstants.GetHospitalList}";
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "darpanNo": darpanNo,
        "hospitalId": hospitalId,
        "districtId": districtId,
        "userId": userId,
      });
      print("@@GetHospitalList - Request Body: $body");

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

      print("@@GetHospitalList - API Response: ${response.data}");

      // Parse the response
      var responseData = json.decode(response.data);
      ViewClickHospitalDetails data = ViewClickHospitalDetails.fromJson(
          responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of hospital details
        return data.data.hospitalDetails ?? []; // Handle null case
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast("Error: ${e.toString()}", true);
      return [];
    }
  }

  static Future<List<DataDoctorlinkedwithHospital>>
  getDoctorlinkedwithHospital(String hospitalId) async {
    print("@@getDoctorlinkedwithHospital" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetDoctorlinkedwithHospital;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "hospitalId": hospitalId
      });
      print("@@getDoctorlinkedwithHospital--bodyprint--: ${body.toString()}");
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
          "@@getDoctorlinkedwithHospital--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DoctorlinkedwithHospital data =
      DoctorlinkedwithHospital.fromJson(responseData);

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

  static Future<List<DataGetDoctorDetailsById>>
  getDoctorDetailsById(String hospitalId, String doctorlId) async {
    print("@@getDoctorDetailsById" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetDoctorDetailsById;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "hospitalId": hospitalId,
        "doctorlId": doctorlId
      });
      print("@@getDoctorDetailsById--bodyprint--: ${body.toString()}");
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
          "@@getDoctorDetailsById--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDoctorDetailsById data =
      GetDoctorDetailsById.fromJson(responseData);

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

  //need to work here more
  static Future<List<DataGetAllNgoService>>
  getAllNgoService(String userId) async {
    print("@@getAllNgoService" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetAllNgoService;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "userId": userId,

      });
      print("@@getAllNgoService--bodyprint--: ${body.toString()}");
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
          "@@getAllNgoService--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetAllNgoService data =
      GetAllNgoService.fromJson(responseData);

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

  static Future<List<DataUploadMOUNGO>>
  getUploadedMouList(String hospitalId, int districtId, int userRoleId) async {
    print("@@getUploadedMouList" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetUploadedMouList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "hospitalId": hospitalId,
        "districtId": districtId,
        "userRoleId": userRoleId
      });
      print("@@getUploadedMouList--bodyprint--: ${body.toString()}");
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
          "@@getUploadedMouList--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      UploadMOUNGO data =
      UploadMOUNGO.fromJson(responseData);

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


  static Future<List<DataAddEyeBank>>
  getEyeBankDonationList(int stateId, int districtid, String userId) async {
    print("@@getEyeBankDonationList" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetEyeBankDonationList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "stateId": stateId,
        "districtId": districtid,

        "userId": userId,


      });
      print("@@getEyeBankDonationList--bodyprint--: ${body.toString()}");
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
          "@@getEyeBankDonationList--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      AddEyeBank data = AddEyeBank.fromJson(responseData);

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


  static Future<List<DataNgoCampMangerList>>
  getCampManagerList(int stateId, int districtid, String entryBy) async {
    print("@@getCampManagerList" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetCampManagerList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "stateId": stateId,
        "districtId": districtid,

        "entryBy": entryBy,


      });
      print("@@getCampManagerList--bodyprint--: ${body.toString()}");
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
          "@@getCampManagerList--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      NgoCampMangerList data = NgoCampMangerList.fromJson(responseData);

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


  static Future<List<DataManageDoctor>>
  getDoctorListByHId(String hospitalId, int districtid) async {
    print("@@getDoctorListByHId" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetDoctorListByHId;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "hospitalId": hospitalId,
        "districtId": districtid,


      });
      print("@@getDoctorListByHId--bodyprint--: ${body.toString()}");
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
          "@@getDoctorListByHId--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ManageDoctor data = ManageDoctor.fromJson(responseData);

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


  static Future<AddCampMagerRegister> campManagerRegistration(
      String userName,
      String gender,
      String mobileNo,
      String emailId,
      String officeAddress,
      String designation,
      int districtId,
      int stateId,
      String userId,
      int entryBy,
      String darpanNumber,
      String hospitalId,
      String loggedInNgoName,
      String loggedInStateName,
      String loggedInDistrictName,
      String srNo) async {
    AddCampMagerRegister addCampMagerRegister;
    // Check for network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.CampManagerRegistration;
      // Headers for the request
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Prepare the body for the request
      var body = json.encode({
        "userName": userName,
        "gender": gender,
        "mobileNo": mobileNo,
        "emailId": emailId,
        "officeAddress": officeAddress,
        "designation": designation,
        "districtid": districtId,
        "stateId": stateId,
        "userId": userId,
        "entryBy": entryBy,
        "darpanNumber": darpanNumber,
        "hospitalid": hospitalId,
        "loggedInNgoName": loggedInNgoName,
        "loggedInStateName": loggedInStateName,
        "loggedInDistrictName": loggedInDistrictName,
        "sr_no": srNo,
      });

      print("@@campManagerRegistration--ParamsCheck with platform---" + url + body.toString());

      // Making the network call
      Dio dio = Dio();
      Response response1 = await dio.post(url,
          data: body,
          options: Options(
              headers: headers,
              contentType: "application/json",
              responseType: ResponseType.json));

      print("@@campManagerRegistration--Api: " + response1.toString());

      // Check if the response data is valid before parsing
      if (response1.data != null) {
        addCampMagerRegister = AddCampMagerRegister.fromJson(response1.data);

        if (addCampMagerRegister.message=="Camp Manager Registered Successfully.") {
          print("@@Result message----1: " + addCampMagerRegister.message);
          Utils.showToast(addCampMagerRegister.message, true);

        } else {
          Utils.showToast(addCampMagerRegister.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return addCampMagerRegister;

    } catch (e) {
      print("@@Error during registration: " + e.toString());
      Utils.showToast(e.toString(), true);
      return null;
    }
  }
  static Future<GetCampManagerDetailsByIdEditData> getCampManagerDetailsById(int sR_No, String entryBy) async {
    print("@@getCampManagerDetailsById" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;  // Return null for network issues
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetCampManagerDetailsById;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "sR_No": sR_No,
        "entryBy": entryBy
      });
      print("@@getCampManagerDetailsById--bodyprint--: ${url+body.toString()}");

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

      print("@@getCampManagerDetailsById--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetCampManagerDetailsByIdEditData data = GetCampManagerDetailsByIdEditData.fromJson(responseData);

      // Check the status of the response
      if (data.status) {
        Utils.showToast(data.message, true);
        return data; // Return the entire data object
      } else {
        Utils.showToast(data.message, true);
        return null; // Return null if the status is false
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return null; // Return null on exceptions
    }
  }
  static Future<updateCampManagerDetails> updateCampManager(
      String userName,
      String gender,
      String mobileNo,
      String emailId,
      String officeAddress,
      String designation,
      int districtId,
      int stateId,
      String userId,
      int entryBy,
      String darpanNumber,
      String hospitalId,
      String loggedInNgoName,
      String loggedInStateName,
      String loggedInDistrictName,
      String srNo) async {
    updateCampManagerDetails updateCampManagerDetailss;
    // Check for network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.UpdateCampManager;
      // Headers for the request
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Prepare the body for the request
      var body = json.encode({
        "userName": userName,
        "gender": gender,
        "mobileNo": mobileNo,
        "emailId": emailId,
        "officeAddress": officeAddress,
        "designation": designation,
        "districtid": districtId,
        "stateId": stateId,
        "userId": userId,
        "entryBy": entryBy,
        "darpanNumber": darpanNumber,
        "hospitalid": hospitalId,
        "loggedInNgoName": loggedInNgoName,
        "loggedInStateName": loggedInStateName,
        "loggedInDistrictName": loggedInDistrictName,
        "sr_no": srNo,
      });

      print("@@Response--ParamsCheck with platform---" + url + body.toString());

      // Making the network call
      Dio dio = Dio();
      Response response1 = await dio.post(url,
          data: body,
          options: Options(
              headers: headers,
              contentType: "application/json",
              responseType: ResponseType.json));

      print("@@Response--Api: " + response1.toString());

      // Check if the response data is valid before parsing
      if (response1.data != null) {
        updateCampManagerDetailss = updateCampManagerDetails.fromJson(response1.data);

        if (updateCampManagerDetailss.message=="Camp Manager Details Updated Successfully.") {
          print("@@Result message----1: " + updateCampManagerDetailss.message);
          Utils.showToast(updateCampManagerDetailss.message, true);

        } else {
          Utils.showToast(updateCampManagerDetailss.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return updateCampManagerDetailss;

    } catch (e) {
      print("@@Error during registration: " + e.toString());
      Utils.showToast(e.toString(), true);
      return null;
    }
  }


  static Future<List<DataScreeningCampList>>
  getCampList(int stateId, int districtid, String entryBy) async {
    print("@@getCampList" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetCampList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "stateId": stateId,
        "districtId": districtid,

        "entryBy": entryBy,


      });
      print("@@getCampList--bodyprint--: ${body.toString()}");
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
          "@@getCampList--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ScreeningCampList data = ScreeningCampList.fromJson(responseData);

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
  static Future<List<DataScreeningCampManager>>
  getCampManager(int district_code, String entryBy) async {
    print("@@getCampManager--APProvedWala--" + "1");
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
        "entryBy": entryBy,

      });
      print("@@getCampManager--bodyprint--: ${body.toString()}");
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
          "@@getCampManager--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
     ScreeningCampManager data =
     ScreeningCampManager.fromJson(responseData);

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

  static Future<ScreenCampRegister> campRegistration(
      String ngoName,String campName,String startDate,String endDate,int campManagerName,
      String mobileNo,String address,int locationType,int campStateId,int campDistrictid,
      String emailId,int cityId,int villageId, int town,int blockId,String pinCode,int districtid,
      int stateId,String userId,String entryBy,String darpanNumber ) async {
    ScreenCampRegister registrationModel = ScreenCampRegister();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();

    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.CampRegistration;

        Map<String, dynamic> payload = {
          "ngoName": ngoName,
          "campName": campName,
          "startDate": startDate,
          "endDate": endDate,
          "campManagerName": campManagerName,
          "mobileNo": mobileNo,
          "address": address,
          "locationType": locationType,
          "campStateId": campStateId,
          "campDistrictid": campDistrictid,
          "emailId": emailId,
          "cityId": cityId,
          "villageId": villageId,
          "town":town,
          "blockId":blockId,
          "pinCode": pinCode,
          "districtid":districtid,
          "stateId": stateId,
          "userId": userId,
          "entryBy": entryBy,
          "darpanNumber":darpanNumber,
        };

        print("@@campRegistration---" + url + payload.toString());

        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: payload,
            options: new Options(
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@campRegistration--Api" + response1.toString());
        // Assuming the API returns a status and message in response
        // Parse the response1 to update registrationModel accordingly
        registrationModel =
            ScreenCampRegister.fromJson(jsonDecode(response1.data));
        if (registrationModel.message == "Camp Registered Successfully.") {
          Utils.showToast(registrationModel.message, true);
        } else {
          Utils.showToast("Wrong registered use id!", true);
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





  static Future<List<DataGetSatelliteCenterList>>
  GetSatelliteManagerList(int stateId, int districtid, String entryBy) async {
    print("@@GetSatelliteManagerList" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetSatelliteManagerList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "stateId": stateId,
        "districtId": districtid,

        "entryBy": entryBy,


      });
      print("@@GetSatelliteManagerList--bodyprint--: ${body.toString()}");
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
          "@@GetSatelliteManagerList--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSatelliteCenterList data = GetSatelliteCenterList.fromJson(responseData);

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


  static Future<ngoSatelliteManagerRegistration> satelliteManagerRegistration(
      String userName,
      int gender,
      String mobileNo,
      String emailId,
      String hospitalId,
      String officeAddress,
      String designation,
      int districtId,
      int stateId,
      String userId,
      int entryBy,
      String darpanNumber,
      String loggedInNgoName,
      String loggedInStateName,
      String loggedInDistrictName
     ) async {
    ngoSatelliteManagerRegistration ngoSatelliteManagerRegistrations;
    // Check for network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.SatelliteManagerRegistration;
      // Headers for the request
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Prepare the body for the request
      var body = json.encode({


        "userName": userName,
        "gender": gender,
        "mobileNo":mobileNo,
        "emailId": emailId,
        "hospitalId": hospitalId,
        "designation": designation,
        "officeAddress":officeAddress,
        "districtid": districtId,
        "stateId": stateId,
        "userId": userId,
        "entryBy": entryBy,
        "darpanNumber":darpanNumber,
        "loggedInNgoName":loggedInNgoName,
        "loggedInStateName": loggedInStateName,
        "loggedInDistrictName": loggedInDistrictName,


      });

      print("@@Response--ParamsCheck with platform---" + url + body.toString());

      // Making the network call
      Dio dio = Dio();
      Response response1 = await dio.post(url,
          data: body,
          options: Options(
              headers: headers,
              contentType: "application/json",
              responseType: ResponseType.json));

      print("@@Response--Api: " + response1.toString());

      // Check if the response data is valid before parsing
      if (response1.data != null) {
        ngoSatelliteManagerRegistrations = ngoSatelliteManagerRegistration.fromJson(response1.data);

        if (ngoSatelliteManagerRegistrations.status) {
          print("@@Result message----1: " + ngoSatelliteManagerRegistrations.message);
          Utils.showToast(ngoSatelliteManagerRegistrations.message, true);

        } else {
          Utils.showToast(ngoSatelliteManagerRegistrations.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return ngoSatelliteManagerRegistrations;

    } catch (e) {
      print("@@Error during registration: " + e.toString());
      Utils.showToast(e.toString(), true);
      return null;
    }
  }
  static Future<GetSatelliteManagerById> getSatelliteManagerById(int sR_No, String entryBy) async {
    print("@@GetSatelliteManagerById" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;  // Return null for network issues
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSatelliteManagerById;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "sR_No": sR_No,
        "entryBy": entryBy
      });
      print("@@GetSatelliteManagerById--bodyprint--: ${body.toString()}");

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

      print("@@GetSatelliteManagerById--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSatelliteManagerById data = GetSatelliteManagerById.fromJson(responseData);

      // Check the status of the response
      if (data.status) {
        Utils.showToast(data.message, true);
        return data; // Return the entire data object
      } else {
        Utils.showToast(data.message, true);
        return null; // Return null if the status is false
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return null; // Return null on exceptions
    }
  }
  static Future<SatelitteMangerDetails> UpdateSatelliteManager(
      String userName,
      String gender,
      String mobileNo,
      String emailId,
      String officeAddress,
      String designation,
      int districtId,
      int stateId,
      String userId,
      int entryBy,
      String darpanNumber,
      String hospitalId,
      String loggedInNgoName,
      String loggedInStateName,
      String loggedInDistrictName,
      String srNo) async {
    SatelitteMangerDetails updateCampManagerDetailss;
    // Check for network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.UpdateSatelliteManager;
      // Headers for the request
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Prepare the body for the request
      var body = json.encode({
        "userName": userName,
        "gender": gender,
        "mobileNo": mobileNo,
        "emailId": emailId,
        "officeAddress": officeAddress,
        "designation": designation,
        "districtid": districtId,
        "stateId": stateId,
        "userId": userId,
        "entryBy": entryBy,
        "darpanNumber": darpanNumber,
        "hospitalid": hospitalId,
        "loggedInNgoName": loggedInNgoName,
        "loggedInStateName": loggedInStateName,
        "loggedInDistrictName": loggedInDistrictName,
        "sr_no": srNo,
      });

      print("@@Response--ParamsCheck with platform---" + url + body.toString());

      // Making the network call
      Dio dio = Dio();
      Response response1 = await dio.post(url,
          data: body,
          options: Options(
              headers: headers,
              contentType: "application/json",
              responseType: ResponseType.json));

      print("@@Response--Api: " + response1.toString());

      // Check if the response data is valid before parsing
      if (response1.data != null) {
        updateCampManagerDetailss = SatelitteMangerDetails.fromJson(response1.data);

        if (updateCampManagerDetailss.status) {
          print("@@Result message----1: " + updateCampManagerDetailss.message);
          Utils.showToast(updateCampManagerDetailss.message, true);

        } else {
          Utils.showToast(updateCampManagerDetailss.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return updateCampManagerDetailss;

    } catch (e) {
      print("@@Error during registration: " + e.toString());
      Utils.showToast(e.toString(), true);
      return null;
    }
  }

  static Future<List<DataGetSatelliteCenterList>> getSatelliteCenterLists(int stateId, int districtid, String entryBy) async {
    print("@@getSatelliteCenterLists" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.GetSatelliteCenterList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "stateId": stateId,
        "districtId": districtid,

        "entryBy": entryBy,


      });
      print("@@getSatelliteCenterLists--bodyprint--: ${body.toString()}");
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
          "@@getSatelliteCenterLists--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSatelliteCenterList data = GetSatelliteCenterList.fromJson(responseData);

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


  static Future<SatelliteCenterRegistation> satelliteCenterRegistation(
      String satelliteCenterName,
   //   int gender,
      String hospitalId,
      int centerOfficerName,
      String mobileNo,
      String officeAddress,
      String emailId,


      int districtId,
      int stateId,
      String userId,
      int entryBy,
      String darpanNumber,
      ) async {
    SatelliteCenterRegistation satelliteCenterRegistation;
    // Check for network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.SetallightCenterRegistration;
      // Headers for the request
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Prepare the body for the request
      var body = json.encode({


        "satelliteCenterName": satelliteCenterName,
        "hospitalId": hospitalId,
        "centerOfficerName":centerOfficerName,
        "mobileNo":mobileNo,
        "emailId": emailId,

        "officeAddress":officeAddress,
        "districtid": districtId,
        "stateId": stateId,
        "userId": userId,
        "entryBy": entryBy,
        "darpanNumber":darpanNumber,


      });

      print("@@satelliteCenterRegistationRed--ParamsCheck with platform---" + url + body.toString());

      // Making the network call
      Dio dio = Dio();
      Response response1 = await dio.post(url,
          data: body,
          options: Options(
              headers: headers,
              contentType: "application/json",
              responseType: ResponseType.json));

      print("@@@@satelliteCenterRegistationRed--Api: " + response1.toString());

      // Check if the response data is valid before parsing
      if (response1.data != null) {
        satelliteCenterRegistation = SatelliteCenterRegistation.fromJson(response1.data);

        if (satelliteCenterRegistation.status) {
          print("@@@@satelliteCenterRegistationRed message----1: " + satelliteCenterRegistation.message);
          Utils.showToast(satelliteCenterRegistation.message, true);

        } else {
          Utils.showToast(satelliteCenterRegistation.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return satelliteCenterRegistation;

    } catch (e) {
      print("@@Error during registration: " + e.toString());
      Utils.showToast(e.toString(), true);
      return null;
    }
  }

  static Future<List<DataHospitalDashboard>>
  hospitalDashboard(int userRoleType, int districtid, int stateid, String userId,
      String financialYear, int organizationType, String ngoId) async {
    print("@@hospitalDashboard" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl + ApiConstants.HospitalDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "userRoleType": userRoleType,
        "districtId": districtid,
        "stateId": stateid,
        "userId": userId,
        "financialYear": financialYear,
        "organizationType": organizationType,
        "ngoId": ngoId
      });
      print("@@hospitalDashboard--bodyprint--: ${body.toString()}");
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
          "@@hospitalDashboard--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      HospitalDashboard data = HospitalDashboard.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
       // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);

      return [];
    }
  }


  static Future<SpoDashobardData> getSPO_dashboard(int districtidDPM,
      int stateidDPM,
      int old_districtidDPM,
      String useridDPM,
      String roleidDPM,
      int statusDPM,
      String financialYearDPM) async {
    SpoDashobardData getSpoDashobardData = SpoDashobardData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
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
        var url = ApiConstants.baseUrl + ApiConstants.GetSPO_Dashboard;
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
          "roleid": roleidDPM,
          "status": statusDPM,
          "financialYear": financialYearDPM,
        });
        print("@@getSPO_dashboard---api check parmeters--" +
            url +
            body.toString());
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
        getSpoDashobardData =
            SpoDashobardData.fromJson(json.decode(response1.data));
        print("@@getSpoDashobardData====+ " + getSpoDashobardData.data.toString());

        print("@@getSpoDashobardData----" + getSpoDashobardData.message);
        if (getSpoDashobardData.status) {
          Utils.showToast(getSpoDashobardData.message, true);
        } else {
          Utils.showToast(getSpoDashobardData.message, true);
        }
        return getSpoDashobardData;
      } catch (e) {
        Utils.showToast(e.toString(), true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }
  static Future<List<SPODashboardDPMClickViewData>> getSPO_DPM_View(
      int stateid) async {
    print("@@SPODashboardDPMClickViewData" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_DPM_View;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateid": stateid,

      });
      print("@@SPODashboardDPMClickViewData--bodyprint--: ${url + body.toString()}");
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
          "@@SPODashboardDPMClickViewData--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SPODashboardDPMClickView data = SPODashboardDPMClickView.fromJson(responseData);

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
  static Future<List<EyeSurgeonsData>> getSPO_RegisteredEyesurgeonList(int stateid, String userid) async {
    print("@@getSPO_RegisteredEyesurgeonList: 1");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_RegisteredEyesurgeonList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateid": stateid,
        "userid": userid,
      });
      print("@@getSPO_RegisteredEyesurgeonList--URL: $url");
      print("@@getSPO_RegisteredEyesurgeonList--body: ${body.toString()}");

      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,  // Use ResponseType.json to get the data already parsed
        ),
      );

      print("@@getSPO_RegisteredEyesurgeonList--Api Response: ${response.toString()}");

      // Access response data directly
      var responseData = response.data; // response.data is already a Map<String, dynamic>

      // Check the response
      EyeSurgeons data = EyeSurgeons.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        print("@@11: ${response.toString()}");

        // Return the list of data
        return data.data;
      } else {
        print("@@22: ${response.toString()}");
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@33--Error: $e");
      Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<EyeBankApprovalDataData>> getSPO_EyeBankApplicationApproval(int eyeBankUniqueID, int eyeBankingRole_id,int stateId, int districtId) async {
    print("@@getSPO_EyeBankApplicationApproval: 1");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_EyeBankApplicationApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "eyeBankUniqueID": eyeBankUniqueID,
        "eyeBankingRole_id": eyeBankingRole_id,
        "stateId": stateId,
        "districtId": districtId
      });
      print("@@getSPO_EyeBankApplicationApproval--URL: $url");
      print("@@getSPO_EyeBankApplicationApproval--body: ${body.toString()}");

      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,  // Use ResponseType.json to get the data already parsed
        ),
      );

      print("@@getSPO_EyeBankApplicationApproval--Api Response: ${response.toString()}");

      // Access response data directly
      var responseData = response.data; // response.data is already a Map<String, dynamic>

      // Check the response
      EyeBankApproval data = EyeBankApproval.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        print("@@11: ${response.toString()}");

        // Return the list of data
        return data.data;
      } else {
        print("@@22: ${response.toString()}");
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@33--Error: $e");
      Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<EyeBankDonationApprovalData>> getSPO_EyeDonationApplicationApproval(int eyeBankUniqueID, int eyeBankingRole_id,int stateId, int districtId) async {
    print("@@getSPO_EyeDonationApplicationApproval: 1");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_EyeDonationApplicationApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "eyeBankUniqueID": eyeBankUniqueID,
        "eyeBankingRole_id": eyeBankingRole_id,
        "stateId": stateId,
        "districtId": districtId
      });
      print("@@getSPO_EyeDonationApplicationApproval--URL: $url");
      print("@@getSPO_EyeDonationApplicationApproval--body: ${body.toString()}");

      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,  // Use ResponseType.json to get the data already parsed
        ),
      );

      print("@@getSPO_EyeDonationApplicationApproval--Api Response: ${response.toString()}");

      // Access response data directly
      var responseData = response.data; // response.data is already a Map<String, dynamic>

      // Check the response
      EyeBankDonationApproval data = EyeBankDonationApproval.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        print("@@11: ${response.toString()}");

        // Return the list of data
        return data.data;
      } else {
        print("@@22: ${response.toString()}");
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@33--Error: $e");
      Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<PatientRegistrations> hopitalPatientRegistration(
      int registrationType,   String patientImage,String idType,String idName,String dependencyType,
      String relationType,String relationName,String firstName,String lastName,String dob,
      String age,String gender,String mobileRelationType, String mobileNo,String screeningDate,String tentativeSurgeryDate,String disease,
      String reportingPlace,int state,int district,int city,
      int village,String address,String apartment,String nearLandMark,
      String pincode,int communicationLanguage,int loggedInUserStateId,int loggedInUserDistrictId,
      String entryBy,String loggedInNgoId,String programeId,int loggedInUserRole,
      String userId,) async {
    PatientRegistrations registrationModel = PatientRegistrations();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();

    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.PatientRegistration;

        Map<String, dynamic> payload = {
          "registrationType": registrationType,
          "patientImage": patientImage,
          "idType": idType,
          "idName": idName,
          "dependencyType": dependencyType,
          "relationType": relationType,
          "relationName": relationName,
          "firstName": firstName,
          "lastName": lastName,
          "dob": dob,
          "age": age,
          "gender": gender,
          "mobileRelationType": mobileRelationType,
          "mobileNo":mobileNo,
          "screeningDate":screeningDate,
          "tentativeSurgeryDate": tentativeSurgeryDate,
          "disease":disease,
          "reportingPlace":reportingPlace,
          "state": state,
          "district": district,
          "city": city,
          "village":village,
          "address":address,
          "apartment":apartment,
          "nearLandMark":nearLandMark,
          "pincode":pincode,
          "communicationLanguage":communicationLanguage,
          "loggedInUserStateId":loggedInUserStateId,
          "entryBy":entryBy,
          "pincode":pincode,
          "loggedInNgoId":loggedInNgoId,
          "programeId":programeId,
          "loggedInUserRole":loggedInUserRole,
          "userId":userId,
        };

        print("@@hopitalPatientRegistration---" + url + payload.toString());

        Dio dio = new Dio();
        response1 = await dio.post(url,
            data: payload,
            options: new Options(
                contentType: "application/json",
                responseType: ResponseType.plain));
        print("@@hopitalPatientRegistration--Api" + response1.toString());
        // Assuming the API returns a status and message in response
        // Parse the response1 to update registrationModel accordingly
        registrationModel =
            PatientRegistrations.fromJson(jsonDecode(response1.data));
        if (registrationModel.status ) {
          Utils.showToast(registrationModel.message, true);
        } else {
          Utils.showToast("Wrong registered use id!", true);
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


/*
  static Future<PatientRegistrations> hopitalPatientRegistration(
      int registrationType,
      File patientImage,  // Use File instead of String
      String idType,
      String idName,
      String dependencyType,
      String relationType,
      String relationName,
      String firstName,
      String lastName,
      String dob,
      String age,
      String gender,
      String mobileRelationType,
      String mobileNo,
      String screeningDate,
      String tentativeSurgeryDate,
      String disease,
      String reportingPlace,
      int state,
      int district,
      int city,
      int village,
      String address,
      String apartment,
      String nearLandMark,
      String pincode,
      int communicationLanguage,
      int loggedInUserStateId,
      int loggedInUserDistrictId,
      String entryBy,
      String loggedInNgoId,
      String programeId,
      int loggedInUserRole,
      String userId) async {

    PatientRegistrations registrationModel = PatientRegistrations();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();

    if (isNetworkAvailable) {
      try {
        var url = ApiConstants.baseUrl + ApiConstants.PatientRegistration;

        // Build the multipart form data
        FormData formData = FormData.fromMap({
          "registrationType": registrationType,
          "patientImage": await MultipartFile.fromFile(
            patientImage.path,
            filename: patientImage.path.split('/').last,
          ),
          "idType": idType,
          "idName": idName,
          "dependencyType": dependencyType,
          "relationType": relationType,
          "relationName": relationName,
          "firstName": firstName,
          "lastName": lastName,
          "dob": dob,
          "age": age,
          "gender": gender,
          "mobileRelationType": mobileRelationType,
          "mobileNo": mobileNo,
          "screeningDate": screeningDate,
          "tentativeSurgeryDate": tentativeSurgeryDate,
          "disease": disease,
          "reportingPlace": reportingPlace,
          "state": state,
          "district": district,
          "city": city,
          "village": village,
          "address": address,
          "apartment": apartment,
          "nearLandMark": nearLandMark,
          "pincode": pincode,
          "communicationLanguage": communicationLanguage,
          "loggedInUserStateId": loggedInUserStateId,
          "entryBy": entryBy,
          "loggedInNgoId": loggedInNgoId,
          "programeId": programeId,
          "loggedInUserRole": loggedInUserRole,
          "userId": userId,
        });

        Dio dio = Dio();
        response1 = await dio.post(
          url,
          data: formData,
          options: Options(
            contentType: "multipart/form-data",
            responseType: ResponseType.plain,
          ),
        );

        print("@@hopitalPatientRegistration--Api: ${response1.data}");

        registrationModel = PatientRegistrations.fromJson(jsonDecode(response1.data));

        if (registrationModel.status) {
          Utils.showToast(registrationModel.message, true);
        } else {
          Utils.showToast("Registration failed!", true);
        }
        return registrationModel;
      } catch (e) {
        Utils.showToast("Error: $e", true);
        return null;
      }
    } else {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }
  }*/
  static Future<List<ApprovedclickPatientsData>>
  getSPO_PatientApproval(int district_code, int state_code,
      String financialYear,int status) async {
    print("@@getSPO_PatientApproval" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_PatientApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "financialYear": financialYear,
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

      print(
          "@@getSPO_PatientApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ApprovedclickPatients data =
      ApprovedclickPatients.fromJson(responseData);

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
  static Future<List<GetSPO_DiseasewiseRecordsApprovalData>>
  getSPO_DiseasewiseRecordsApproval(int district_code, int state_code,
      String financialYear,int status) async {
    print("@@getSPO_DiseasewiseRecordsApproval" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_DiseasewiseRecordsApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "financialYear": financialYear,
        "status": status, // for approved
      });
      print("@@getSPO_DiseasewiseRecordsApproval--bodyprint--: ${body.toString()}");
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
          "@@getSPO_DiseasewiseRecordsApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSPO_DiseasewiseRecordsApproval data =
      GetSPO_DiseasewiseRecordsApproval.fromJson(responseData);

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

  static Future<List<GetSPO_Patients_Approved_ViewData>>
  getSPO_Patients_Approved_View(int district_code, int state_code,
      String financialYear,int status,int diseaseid) async {
    print("@@getSPO_Patients_Approved_View" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_Patients_Approved_View;
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
        "mode": "",
        "diseaseid":diseaseid// for approved
      });
      print("@@getSPO_Patients_Approved_View--bodyprint--: ${body.toString()}");
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
          "@@getSPO_Patients_Approved_View--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSPO_Patients_Approved_View data =
      GetSPO_Patients_Approved_View.fromJson(responseData);

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


  static Future<List<NGOApprovalClickData>>
  getSPO_DistrictNgoApproval(int district_code, int state_code,
      String financialYear,int status) async {
    print("@@getSPO_DistrictNgoApproval" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_DistrictNgoApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "financialYear": financialYear,
        "status": status,

      });
      print("@@getSPO_DistrictNgoApproval--bodyprint--: ${body.toString()}");
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
          "@@getSPO_DistrictNgoApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      NGOApprovalClick data =
      NGOApprovalClick.fromJson(responseData);

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

  static Future<List<NGOAPPRovedClickListDetailData>>
  getSPO_DistrictNgoApproval_lists(int district_code, int state_code,
      String financialYear,int status) async {
    print("@@getSPO_DistrictNgoApproval_lists" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.getSPO_DistrictNgoApproval_list;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "financialYear": financialYear,
        "status": status,

      });
      print("@@getSPO_DistrictNgoApproval_lists--bodyprint--: ${body.toString()}");
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
          "@@getSPO_DistrictNgoApproval_lists--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      NGOAPPRovedClickListDetail data =
      NGOAPPRovedClickListDetail.fromJson(responseData);

      if (data.status) {
        Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
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
