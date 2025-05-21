import 'dart:convert';
import 'dart:io';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickSatelliteCenters/BothWiseSatelliteWise.dart';
import 'package:mohfw_npcbvi/src/maindashboard/moreClickScreeningCamp/BothWiseCampWise.dart';
import 'package:mohfw_npcbvi/src/model/camp/ViewDashboardclick.dart';
import 'package:mohfw_npcbvi/src/model/camp/totalPatient/TotalPatientCamp.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/dpmApplicationPart/Dpm_application_ngoApplications.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/CataractDataReport.dart';
import 'package:mohfw_npcbvi/src/model/dpmRegistration/viewClickReportData/squint/SquintDataReport.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/ApproveMOURenewClickStatus/ApproveMOURenewClick.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/EquipemntDetails.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/Get_DPM_NGOApplicationDetails.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/HospitalDetailsView.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/HospitallinkedwithNGO.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/MouDetails.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/NgoAppliations/NGoAPPlicationApprovedFinalScreen.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/govtPrivatehospitalApproval/DoctorlinkwithGovtPrivate.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/govtPrivatehospitalApproval/GovtPrivateApprovedFinalScreen.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/govtPrivatehospitalApproval/GovtPrivateDetails.dart';
import 'package:mohfw_npcbvi/src/model/dpm_approval_status/newhospital/hospitaldetailsview.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickCamp/DistrictWiseCamps.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickCamp/StateWiseCamp.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickDpm/DistrictWiseDpm.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickDpm/StateWiseDpm.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreClickSpo/SpoListwise.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickMEdicalColleges/BothDataFoMEdicalCollegesl.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickMEdicalColleges/DistrictwiseMedicalColleges.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickMEdicalColleges/stateWiseMedicalCollegs.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickSatelliteCenters/BothSatelliteCenters.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickSatelliteCenters/DistrictwiseSatelliteCentyers.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickSatelliteCenters/stateWiseSatelliteCenterss.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickprivatepractiories/BothPrivatePractiores.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/moreclickprivatepractiories/stateWisePrivatePractiories.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/BothDataForHospital.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GeDistrictWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GetStateWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/morehospitalclick/GetStateWiseHospitalsForDashboard.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreDashboardClickStateWise.dart';
import 'package:mohfw_npcbvi/src/model/mainDashbaordMorClick/nGOmoreStateDistrictBoth.dart';
import 'package:mohfw_npcbvi/src/model/patientCount/PatientCountDetail.dart';
import 'package:mohfw_npcbvi/src/registerScreens/DPMRegistration.dart';
import 'package:mohfw_npcbvi/src/registerScreens/GovvtPrivateHospitalRegisterScreen.dart';
import 'package:mohfw_npcbvi/src/registerScreens/SPORegistration.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
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
import 'package:mohfw_npcbvi/src/model/districtngowork/AddEyeBankNGO/RegistryDonatiopnCenterClick.dart';
import 'package:mohfw_npcbvi/src/model/districtngowork/AddEyeBankNGO/etEyeDonationCenterListByNOG.dart';
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
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/sendTODPM/SendTODPMCataract.dart';
import 'package:mohfw_npcbvi/src/model/hopitaldashboardineerData/sendTODPM/sendTODPMVRSurgery.dart';
import 'package:mohfw_npcbvi/src/model/ngoSatelliteMangerRegister/GetSatelliteManagerById.dart';
import 'package:mohfw_npcbvi/src/model/ngoSatelliteMangerRegister/SatelitteMangerDetails.dart';
import 'package:mohfw_npcbvi/src/model/ngoSatelliteMangerRegister/ngoSatelliteManagerRegistration.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/CenterOfficeNameSatelliteCenter.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/GetSatelliteCenterList.dart';
import 'package:mohfw_npcbvi/src/model/sattelliteCenter/SatelliteCenterRegistation.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeBankApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeBankDonationApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/EyeSurgeons.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/SPODashboardDPMClickView.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/SpoDashobardData.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/ApprovedclickPatients.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GHC_approvalList.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_DiseasewiseRecordsApproval.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_GHCHCOtherApprovals.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/GetSPO_Patients_Approved_View.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOAPPRovedClickListDetail.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/NGOApprovalClick.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/PrivateMedicalCollgeAPProvalList.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/PrivatePractionries.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/SatelliteCenterListData.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/ScreeningCampCompletedList.dart';
import 'package:mohfw_npcbvi/src/model/spoModel/dahboardclickdetails/ScreeningCampComplted.dart';
import 'package:mohfw_npcbvi/src/model/spoRegistartion/SPORegisterModel.dart';
import 'package:mohfw_npcbvi/src/ngo/NgoDashboard.dart';
import 'package:mohfw_npcbvi/src/spo/SpoDashboard.dart';
import 'package:mohfw_npcbvi/src/utils/AppConstants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/camp/CampDashboard.dart';
import '../model/dpmRegistration/dpmApplicationPart/GovtPrivateHospital.dart';
import '../model/dpmRegistration/updateUsers/GetDPM_Edit_UpdateUserDetail.dart';
import '../model/dpmRegistration/updateUsers/UpdateUserApi.dart';
import '../model/dpmRegistration/viewClickReportData/ViewClickCatractPdfType.dart';
import '../model/dpmRegistration/viewClickReportData/galucoma/GlaucomPDfFile.dart';
import '../model/dpmRegistration/viewClickReportData/galucoma/galucomaDataReporty.dart';
import '../model/dpmRegistration/viewClickReportData/squint/SquintPdfFile.dart';
import '../model/dpm_approval_status/NgoAppliations/DoctorlinkHospitals.dart';
import '../model/guidlines/GuilinessPage.dart';
import '../model/mainDashbaordMorClick/moreClickCamp/BothWiseCamp.dart';
import '../model/mainDashbaordMorClick/moreclickprivatepractiories/DistrictwisePrivatePractionries.dart';
import '../model/mainDashbaordMorClick/morehospitalclick/GetStateWiseHospitalsForDashboard.dart';
import '../model/mainDashbaordMorClick/nGOmoreDashboardClickDistrictWise.dart';
import '../model/screeningCamp/ScreenCampRegister.dart';
import '../model/spoModel/dahboardclickdetails/GetSPO_SatelliteCentreApproval.dart';
import '../model/spoModel/dahboardclickdetails/PrivateMedicalCollegeApproved.dart';
import '../utils/Utils.dart';
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


  static Future<SPORegisterModel> spoRegistrationAPiRquestCopy(
      SPODataFieldss spoDataFields) async {
    // just chnage for senarion test
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

  static Future<DPMRegistartionModel> DPMRegistrationAPiRquestCopy(
      DPMDataFieldss dpmDataFields) async {
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

  /* static Future<SPORegisterModel> ngoRegistrationAPiRquest(
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
  }*/

// cahnges here when api created
  static Future<SPORegisterModel> ngoRegistrationAPiRquest(
      NGODDataFields ngodDataFields) async {
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
          "state_code": ngodDataFields.ngoDarpanNumber,
          "name": ngodDataFields.ngoPANNumber,

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

  static Future<Registration_of_Govt_Private_Other_Hospital_model>
  registration_of_Govt_Private_Other_HospitalCopy(
      GovtPrivateRegistatrionDataFieldss
      govtPrivateRegistatrionDataFields) async {
    Registration_of_Govt_Private_Other_Hospital_model registrationModel =
    Registration_of_Govt_Private_Other_Hospital_model();
    Response response1;
    bool isNetworkAvailable = await Utils.isNetworkAvailable();

    if (isNetworkAvailable) {
      try {
        // Directly use the existing equipmentList from govtPrivateRegistatrionDataFields
        List<DupRegisterEquipmentName> equipmentList =
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

        //  Utils.showToast(getDPMDashboardData.message, true);

        } else {
       //   Utils.showToast(getDPMDashboardData.message, true);
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //Utils.showToast(e.toString(), true);
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
      print("@@getDPM_NGOAPProved_pendings--bodyprint--: ${url +
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
          "@@getDPM_NGOAPProved_pendings--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_NGOAPProved_pending data =
      GetDPM_NGOAPProved_pending.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
      print("@@DataDPMRivateMEdicalColleges--bodyprint--: ${url +
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
          "@@DataDPMRivateMEdicalColleges--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DPMRivateMEdicalColleges data =
      DPMRivateMEdicalColleges.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
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

      print("@@GetDPM_SatelliteCentre--Api Response: ${url}+ ${body
          .toString()}+${response.toString()}");

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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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

      print("@@GetDPM_SatelliteCentre--Api Response yaha se kyuuu--: ${url +
          body + response.toString()}");

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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
          //Utils.showToast(data.message, true);
        } else {
          // Utils.showToast(data.message, true);
        }
        return data;
      } catch (e) {
        //  Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<Datalowvisionregister_cataract>> getDPM_Glaucomas(
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
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Glaucomas;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<Datalowvisionregister_cataract>> getDPM_Squint(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_Squint" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_Squint--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.getDPM_Squint;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<Datalowvisionregister_cataract>> getDPM_CongenitalPtosis_new(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@GetDPM_CongenitalPtosis_new" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@GetDPM_CongenitalPtosis_new--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_CongenitalPtosis_new;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<Datalowvisionregister_cataract>> getDPM_RetinoblasmaData(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_RetinoblasmaData" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_RetinoblasmaData--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_RetinoblasmaData;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<Datalowvisionregister_cataract>> getDPM_Daiabetic_new(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_RetinoblasmaData" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_RetinoblasmaData--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_RetinopathyofPrematurity;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<Datalowvisionregister_cataract>> getDPM_CornealBlindness_new(
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
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_CornealBlindness_new;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }
  static Future<List<Datalowvisionregister_cataract>> getDPM_RetinopathyofPrematurity(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@getDPM_RetinoblasmaData" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_RetinoblasmaData--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_RetinopathyofPrematurity;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<Datalowvisionregister_cataract>> getDPM_TraumainChildrenData(
      int district_code,
      int state_code,
      String npcbno,
      String financialYear,
      int organisationtypeValue) async {
    print("@@GetDPM_TraumainChildrenData" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@GetDPM_TraumainChildrenData--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_TraumainChildrenData;
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
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
      print("@@GetDPM_Patients_Approved_View--bodyprint--: ${url+body.toString()}");
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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);

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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
        //Utils.showToast(data.message, true);
        // Return the list of hospital details
        return data.data.hospitalDetails ?? []; // Handle null case
      } else {
        // Utils.showToast(data.message, true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);

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
      print("@@getAllNgoService--bodyprint--: ${url + body.toString()}");
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
      print("@@getEyeBankDonationList--bodyprint--: ${url + body.toString()}");
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

      return [];
    }
  }

  static Future<List<etEyeDonationCenterListByNOGData>>
  getEyeDonationCenterListByNGO(int stateId, int districtid, String userId,
      String eyeBankById) async {
    print("@@getEyeDonationCenterListByNGO" + "1");
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
          ApiConstants.baseUrl + ApiConstants.GetEyeDonationCenterListByNGO;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "eyeBankById": eyeBankById,
        "stateId": stateId,
        "districtId": districtid,

        "userId": userId,


      });
      print("@@getEyeDonationCenterListByNGO--bodyprint--: ${url +
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
          "@@getEyeDonationCenterListByNGO--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      etEyeDonationCenterListByNOG data = etEyeDonationCenterListByNOG.fromJson(
          responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        /// Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

      return [];
    }
  }

  static Future<RegistryDonatiopnCenterClick>
  getRegistrationEyeDonationCenterByNGO(String eyeDonationCenterName,
      String officerName,
      String mobileNo, String emailId,
      int state, int district, String address, String pincode,
      String eyeBankId, String entryBy, String eyeDonationCenter_ID) async {
    print("@@getRegistrationEyeDonationCenterByNGO" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
    }

    try {
      // Define the URL and headers
      var url =
          ApiConstants.baseUrl +
              ApiConstants.RegistrationEyeDonationCenterByNGO;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "eyeDonationCenterName": eyeDonationCenterName,
        "officerName": officerName,
        "mobileNo": mobileNo,
        "emailId": emailId,
        "state": state,
        "district": district,
        "address": address,
        "pincode": pincode,
        "eyeBankId": eyeBankId,
        "entryBy": entryBy,
        "eyeDonationCenter_ID": eyeDonationCenter_ID,
      });
      print("@@getRegistrationEyeDonationCenterByNGO--bodyprint--: ${url +
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
          "@@getRegistrationEyeDonationCenterByNGO--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      RegistryDonatiopnCenterClick data = RegistryDonatiopnCenterClick.fromJson(
          responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data;
      } else {
        //Utils.showToast(data.message, true);
      }
    } catch (e) {
      Utils.showToast("Eye Donation Center already exists Center", true);
      //   Utils.showToast(e.toString(), true);

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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);

      return [];
    }
  }


  static Future<AddCampMagerRegister> campManagerRegistration(String userName,
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

      print("@@campManagerRegistration--ParamsCheck with platform---" + url +
          body.toString());

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

        if (addCampMagerRegister.message ==
            "Camp Manager Registered Successfully.") {
          print("@@Result message----1: " + addCampMagerRegister.message);
          Utils.showToast(addCampMagerRegister.message, true);
        } else {
          Utils.showToast(
              addCampMagerRegister.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return addCampMagerRegister;
    } catch (e) {
      print("@@Error during registration: " + e.toString());
      // Utils.showToast(e.toString(), true);
      return null;
    }
  }

  static Future<GetCampManagerDetailsByIdEditData> getCampManagerDetailsById(
      int sR_No, String entryBy) async {
    print("@@getCampManagerDetailsById" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null; // Return null for network issues
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
      print(
          "@@getCampManagerDetailsById--bodyprint--: ${url + body.toString()}");

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
          "@@getCampManagerDetailsById--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetCampManagerDetailsByIdEditData data = GetCampManagerDetailsByIdEditData
          .fromJson(responseData);

      // Check the status of the response
      if (data.status) {
        // Utils.showToast(data.message, true);
        return data; // Return the entire data object
      } else {
        //Utils.showToast(data.message, true);
        return null; // Return null if the status is false
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return null; // Return null on exceptions
    }
  }

  static Future<updateCampManagerDetails> updateCampManager(String userName,
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
        updateCampManagerDetailss =
            updateCampManagerDetails.fromJson(response1.data);

        if (updateCampManagerDetailss.message ==
            "Camp Manager Details Updated Successfully.") {
          print("@@Result message----1: " + updateCampManagerDetailss.message);
          Utils.showToast(updateCampManagerDetailss.message, true);
        } else {
          Utils.showToast(
              updateCampManagerDetailss.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return updateCampManagerDetailss;
    } catch (e) {
      print("@@Error during registration: " + e.toString());
      //   Utils.showToast(e.toString(), true);
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);

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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<ScreenCampRegister> campRegistration(String ngoName,
      String campName, String startDate, String endDate, int campManagerName,
      String mobileNo, String address, int locationType, int campStateId,
      int campDistrictid,
      String emailId, int cityId, int villageId, int town, int blockId,
      String pinCode, int districtid,
      int stateId, String userId, String entryBy, String darpanNumber) async {
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
          "town": town,
          "blockId": blockId,
          "pinCode": pinCode,
          "districtid": districtid,
          "stateId": stateId,
          "userId": userId,
          "entryBy": entryBy,
          "darpanNumber": darpanNumber,
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
        //   Utils.showToast(e.toString(), true);
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
      print("@@GetSatelliteManagerList--bodyprint--: ${url+body.toString()}");
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
      GetSatelliteCenterList data = GetSatelliteCenterList.fromJson(
          responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);

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
      String loggedInDistrictName) async {
    ngoSatelliteManagerRegistration ngoSatelliteManagerRegistrations;
    // Check for network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.SatelliteManagerRegistration;
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
        "hospitalId": hospitalId,
        "designation": designation,
        "officeAddress": officeAddress,
        "districtid": districtId,
        "stateId": stateId,
        "userId": userId,
        "entryBy": entryBy,
        "darpanNumber": darpanNumber,
        "loggedInNgoName": loggedInNgoName,
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
        ngoSatelliteManagerRegistrations =
            ngoSatelliteManagerRegistration.fromJson(response1.data);

        if (ngoSatelliteManagerRegistrations.status) {
          print("@@Result message----1: " +
              ngoSatelliteManagerRegistrations.message);
          Utils.showToast(ngoSatelliteManagerRegistrations.message, true);
        } else {
          Utils.showToast(
              ngoSatelliteManagerRegistrations.message ?? "Registration failed",
              true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return ngoSatelliteManagerRegistrations;
    } catch (e) {
      print("@@Error during registration: " + e.toString());
      //  Utils.showToast(e.toString(), true);
      return null;
    }
  }

  static Future<GetSatelliteManagerById> getSatelliteManagerById(int sR_No,
      String entryBy) async {
    print("@@GetSatelliteManagerById" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null; // Return null for network issues
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
      GetSatelliteManagerById data = GetSatelliteManagerById.fromJson(
          responseData);

      // Check the status of the response
      if (data.status) {
        //  Utils.showToast(data.message, true);
        return data; // Return the entire data object
      } else {
        //Utils.showToast(data.message, true);
        return null; // Return null if the status is false
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return null; // Return null on exceptions
    }
  }

  static Future<SatelitteMangerDetails> UpdateSatelliteManager(String userName,
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
        "srNo": srNo,
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
        updateCampManagerDetailss =
            SatelitteMangerDetails.fromJson(response1.data);

        if (updateCampManagerDetailss.status) {
          print("@@Result message----1: " + updateCampManagerDetailss.message);
          Utils.showToast(updateCampManagerDetailss.message, true);
        } else {
          Utils.showToast(
              updateCampManagerDetailss.message ?? "Registration failed", true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return updateCampManagerDetailss;
    } catch (e) {
      print("@@Error during registration: " + e.toString());
      // Utils.showToast(e.toString(), true);
      return null;
    }
  }

  static Future<List<DataGetSatelliteCenterList>> getSatelliteCenterLists(
      int stateId, int districtid, String entryBy) async {
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
      GetSatelliteCenterList data = GetSatelliteCenterList.fromJson(
          responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

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
      String darpanNumber,) async {
    SatelliteCenterRegistation satelliteCenterRegistation;
    // Check for network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.SetallightCenterRegistration;
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
        "centerOfficerName": centerOfficerName,
        "mobileNo": mobileNo,
        "emailId": emailId,

        "officeAddress": officeAddress,
        "districtid": districtId,
        "stateId": stateId,
        "userId": userId,
        "entryBy": entryBy,
        "darpanNumber": darpanNumber,


      });

      print("@@satelliteCenterRegistationRed--ParamsCheck with platform---" +
          url + body.toString());

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
        satelliteCenterRegistation =
            SatelliteCenterRegistation.fromJson(response1.data);

        if (satelliteCenterRegistation.status) {
          print("@@@@satelliteCenterRegistationRed message----1: " +
              satelliteCenterRegistation.message);
          Utils.showToast(satelliteCenterRegistation.message, true);
        } else {
          Utils.showToast(
              satelliteCenterRegistation.message ?? "Registration failed",
              true);
        }
      } else {
        Utils.showToast("No data received from server", true);
      }

      return satelliteCenterRegistation;
    } catch (e) {
      print("@@Error during registration: " + e.toString());
      //  Utils.showToast(e.toString(), true);
      return null;
    }
  }

  static Future<List<DataHospitalDashboard>>
  hospitalDashboard(int userRoleType, int districtid, int stateid,
      String userId,
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
        //   Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);

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
        print("@@getSpoDashobardData====+ " +
            getSpoDashobardData.data.toString());

        print("@@getSpoDashobardData----" + getSpoDashobardData.message);
        if (getSpoDashobardData.status) {
        //  Utils.showToast(getSpoDashobardData.message, true);
        } else {
          Utils.showToast(getSpoDashobardData.message, true);
        }
        return getSpoDashobardData;
      } catch (e) {
        //  Utils.showToast(e.toString(), true);
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
      print("@@SPODashboardDPMClickViewData--bodyprint--: ${url +
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
          "@@SPODashboardDPMClickViewData--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SPODashboardDPMClickView data = SPODashboardDPMClickView.fromJson(
          responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<EyeSurgeonsData>> getSPO_RegisteredEyesurgeonList(
      int stateid, String userid) async {
    print("@@getSPO_RegisteredEyesurgeonList: 1");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl +
          ApiConstants.GetSPO_RegisteredEyesurgeonList;
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
      print("@@getSPO_RegisteredEyesurgeonList--body: ${url+body.toString()}");

      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType
              .json, // Use ResponseType.json to get the data already parsed
        ),
      );

      print("@@getSPO_RegisteredEyesurgeonList--Api Response: ${response
          .toString()}");

      // Access response data directly
      var responseData = response
          .data; // response.data is already a Map<String, dynamic>

      // Check the response
      EyeSurgeons data = EyeSurgeons.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print("@@11: ${response.toString()}");

        // Return the list of data
        return data.data;
      } else {
        print("@@22: ${response.toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@33--Error: $e");
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<
      List<EyeBankApprovalDataData>> getSPO_EyeBankApplicationApproval(
      int eyeBankUniqueID, int eyeBankingRole_id, int stateId,
      int districtId) async {
    print("@@getSPO_EyeBankApplicationApproval: 1");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl +
          ApiConstants.GetSPO_EyeBankApplicationApproval;
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
          responseType: ResponseType
              .json, // Use ResponseType.json to get the data already parsed
        ),
      );

      print("@@getSPO_EyeBankApplicationApproval--Api Response: ${response
          .toString()}");

      // Access response data directly
      var responseData = response
          .data; // response.data is already a Map<String, dynamic>

      // Check the response
      EyeBankApproval data = EyeBankApproval.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        print("@@11: ${response.toString()}");

        // Return the list of data
        return data.data;
      } else {
        print("@@22: ${response.toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@33--Error: $e");
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<
      List<EyeBankDonationApprovalData>> getSPO_EyeDonationApplicationApproval(
      int eyeBankUniqueID, int eyeBankingRole_id, int stateId,
      int districtId) async {
    print("@@getSPO_EyeDonationApplicationApproval: 1");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl +
          ApiConstants.GetSPO_EyeDonationApplicationApproval;
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
      print(
          "@@getSPO_EyeDonationApplicationApproval--body: ${body.toString()}");

      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType
              .json, // Use ResponseType.json to get the data already parsed
        ),
      );

      print("@@getSPO_EyeDonationApplicationApproval--Api Response: ${response
          .toString()}");

      // Access response data directly
      var responseData = response
          .data; // response.data is already a Map<String, dynamic>

      // Check the response
      EyeBankDonationApproval data = EyeBankDonationApproval.fromJson(
          responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print("@@11: ${response.toString()}");

        // Return the list of data
        return data.data;
      } else {
        print("@@22: ${response.toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@33--Error: $e");
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  /*static Future<PatientRegistrations> hopitalPatientRegistration(
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
  }*/


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
      String financialYear, int status) async {
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
      print("@@DataGetDPM_PrivatePartition--bodyprint--: ${url+body.toString()}");
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<GetSPO_DiseasewiseRecordsApprovalData>>
  getSPO_DiseasewiseRecordsApproval(int district_code, int state_code,
      String financialYear, int status) async {
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
      var url = ApiConstants.baseUrl +
          ApiConstants.GetSPO_DiseasewiseRecordsApproval;
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
      print("@@getSPO_DiseasewiseRecordsApproval--bodyprint--: ${url+body
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
          "@@getSPO_DiseasewiseRecordsApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSPO_DiseasewiseRecordsApproval data =
      GetSPO_DiseasewiseRecordsApproval.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<GetSPO_Patients_Approved_ViewData>>
  getSPO_Patients_Approved_View(int district_code, int state_code,
      String financialYear, int status, int diseaseid) async {
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
      var url = ApiConstants.baseUrl +
          ApiConstants.GetSPO_Patients_Approved_View;
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
        "diseaseid": diseaseid // for approved
      });
      print("@@getSPO_Patients_Approved_View--bodyprint--: ${url+body.toString()}");
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
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<NGOApprovalClickData>>
  getSPO_DistrictNgoApproval(int district_code, int state_code,
      String financialYear, int status) async {
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
      print("@@getSPO_DistrictNgoApproval--bodyprint--: ${url+body.toString()}");
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
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        /// Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<NGOAPPRovedClickListDetailData>>
  getSPO_DistrictNgoApproval_lists(int district_code, int state_code,
      String financialYear, int status) async {
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
      var url = ApiConstants.baseUrl +
          ApiConstants.getSPO_DistrictNgoApproval_list;
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
      print("@@getSPO_DistrictNgoApproval_lists--bodyprint--: ${url+body
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
          "@@getSPO_DistrictNgoApproval_lists--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      NGOAPPRovedClickListDetail data =
      NGOAPPRovedClickListDetail.fromJson(responseData);

      if (data.status) {
        //   Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<GetSPO_GHCHCOtherApprovalsData>>
  GetSPO_GHCHCOtherApprovalsDatas(int district_code, int state_code,
      int status, String financialYear) async {
    print("@@GetSPO_GHCHCOtherApprovalsDatas--APProvedWala--" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPO_GHCHCOtherApprovals;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "status": status, // for approved
        "financialYear": financialYear, // for approved
      });
      print(
          "@@GetSPO_GHCHCOtherApprovalsDatas--bodyprint--: ${url+body.toString()}");
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
          "@@GetSPO_GHCHCOtherApprovalsDatas--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSPO_GHCHCOtherApprovals data =
      GetSPO_GHCHCOtherApprovals.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<GHC_approvalListData>>
  getSPO_GHCHCOtherApproval_list(int district_code, int state_code,
      String financialYear, int status) async {
    print("@@getSPO_GHCHCOtherApproval_list" + "1");
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
          ApiConstants.GetSPO_GHCHCOtherApproval_list;
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
      print(
          "@@getSPO_GHCHCOtherApproval_list--bodyprint--: ${url+body.toString()}");
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
          "@@getSPO_GHCHCOtherApproval_list--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GHC_approvalList data =
      GHC_approvalList.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<PrivateMedicalCollegeApprovedData>>
  getSPO_PrivatePractitionerApproval(int district_code, int state_code,
      int status, String financialYear) async {
    print("@@getSPO_PrivatePractitionerApproval--APProvedWala--" + "1");
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
          ApiConstants.GetSPO_PrivatePractitionerApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "status": status, // for approved
        "financialYear": financialYear, // for approved
      });
      print("@@getSPO_PrivatePractitionerApproval--bodyprint--: ${url +
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
          "@@getSPO_PrivatePractitionerApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      PrivateMedicalCollegeApproved data =
      PrivateMedicalCollegeApproved.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
      //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<PrivatePractionriesData>>
  getSPO_PrivatePractitionerApproval_list(int district_code, int state_code,
      String financialYear, int status) async {
    print("@@getSPO_PrivatePractitionerApproval_list" + "1");
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
          ApiConstants.GetSPO_PrivatePractitionerApproval_list;
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
      print("@@getSPO_PrivatePractitionerApproval_list--bodyprint--: ${url+body
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
          "@@getSPO_PrivatePractitionerApproval_list--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      PrivatePractionries data =
      PrivatePractionries.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<PrivateMedicalCollegeApprovedData>>
  getSPO_PrivateMedicalCollegeApproval(int district_code, int state_code,
      int status, String financialYear) async {
    print("@@getSPO_PrivateMedicalCollegeApproval--APProvedWala--" + "1");
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
          ApiConstants.GetSPO_PrivateMedicalCollegeApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "status": status, // for approved
        "financialYear": financialYear, // for approved
      });
      print("@@getSPO_PrivateMedicalCollegeApproval--bodyprint--: ${url +
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
          "@@getSPO_PrivateMedicalCollegeApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      PrivateMedicalCollegeApproved data =
      PrivateMedicalCollegeApproved.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //    Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<PrivateMedicalCollgeAPProvalListData>>
  getSPO_PrivateMedicalCollegeApproval_list(int district_code, int state_code,
      String financialYear, int status) async {
    print("@@getSPO_PrivatePractitionerApproval_list" + "1");
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
          ApiConstants.GetSPO_PrivateMedicalCollegeApproval_list;
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
      print("@@getSPO_PrivatePractitionerApproval_list--bodyprint--: ${url+body
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
          "@@getSPO_PrivatePractitionerApproval_list--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      PrivateMedicalCollgeAPProvalList data =
      PrivateMedicalCollgeAPProvalList.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<ScreeningCampCompltedData>>
  getSPO_ScreeningCampApproval(int district_code, int state_code,
      String campType, String financialYear, String mode) async {
    print("@@getSPO_ScreeningCampApproval--APProvedWala--" + "1");
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
          ApiConstants.GetSPO_ScreeningCampApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "campType": campType, // for approved
        "financialYear": financialYear, // for approved
        "mode": "", // for approved
      });
      print("@@getSPO_ScreeningCampApproval--bodyprint--: ${url +
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
          "@@getSPO_ScreeningCampApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ScreeningCampComplted data =
      ScreeningCampComplted.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<ScreeningCampCompletedListData>>
  getSPOScreeningCampApproval_list(int district_code, int state_code,
      String campType, String financialYear, String mode) async {
    print("@@getSPOScreeningCampApproval_list" + "1");
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
          ApiConstants.GetSPOScreeningCampApproval_list;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "campType": campType, // for approved
        "financialYear": financialYear, // for approved
        "mode": "", // for approved

      });
      print("@@getSPOScreeningCampApproval_list--bodyprint--: ${body
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
          "@@getSPOScreeningCampApproval_list--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ScreeningCampCompletedList data =
      ScreeningCampCompletedList.fromJson(responseData);

      if (data.status) {
        //   Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<ScreeningCampCompltedData>>
  getSPO_ScreeningCampApprovalOnGoing(int district_code, int state_code,
      String campType, String financialYear, String mode) async {
    print("@@getSPO_ScreeningCampApproval--APProvedWala--" + "1");
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
          ApiConstants.GetSPO_ScreeningCampApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "campType": campType, // for approved
        "financialYear": financialYear, // for approved
        "mode": "", // for approved
      });
      print("@@getSPO_ScreeningCampApproval--bodyprint--: ${url +
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
          "@@getSPO_ScreeningCampApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ScreeningCampComplted data =
      ScreeningCampComplted.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<ScreeningCampCompletedListData>>
  getSPOScreeningCampApproval_listOnGoing(int district_code, int state_code,
      String campType, String financialYear, String mode) async {
    print("@@getSPOScreeningCampApproval_list" + "1");
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
          ApiConstants.GetSPOScreeningCampApproval_list;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "campType": campType, // for approved
        "financialYear": financialYear, // for approved
        "mode": "", // for approved

      });
      print("@@getSPOScreeningCampApproval_listOnGoing--bodyprint--: ${body
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
          "@@getSPOScreeningCampApproval_list--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ScreeningCampCompletedList data =
      ScreeningCampCompletedList.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<ScreeningCampCompltedData>>
  getSPO_ScreeningCampApprovalUpComing(int district_code, int state_code,
      String campType, String financialYear, String mode) async {
    print("@@getSPO_ScreeningCampApproval--APProvedWala--" + "1");
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
          ApiConstants.GetSPO_ScreeningCampApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "campType": campType, // for approved
        "financialYear": financialYear, // for approved
        "mode": "", // for approved
      });
      print("@@getSPO_ScreeningCampApproval--bodyprint--: ${url +
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
          "@@getSPO_ScreeningCampApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ScreeningCampComplted data =
      ScreeningCampComplted.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<ScreeningCampCompletedListData>>
  getSPOScreeningCampApproval_listUpComing(int district_code, int state_code,
      String campType, String financialYear, String mode) async {
    print("@@getSPOScreeningCampApproval_list" + "1");
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
          ApiConstants.GetSPOScreeningCampApproval_list;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "campType": campType, // for approved
        "financialYear": financialYear, // for approved
        "mode": "", // for approved

      });
      print("@@getSPOScreeningCampApproval_list--bodyprint--: ${body
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
          "@@getSPOScreeningCampApproval_list--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ScreeningCampCompletedList data =
      ScreeningCampCompletedList.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<GetSPO_SatelliteCentreApprovalData>>
  getSPO_SatelliteCentreApproval(int district_code, int state_code,
      int status, String financialYear) async {
    print("@@getSPO_SatelliteCentreApproval--APProvedWala--" + "1");
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
          ApiConstants.GetSPO_SatelliteCentreApproval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "status": status, // for approved
        "financialYear": financialYear, // for approved
      });
      print("@@getSPO_SatelliteCentreApproval--bodyprint--: ${url +
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
          "@@getSPO_SatelliteCentreApproval--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetSPO_SatelliteCentreApproval data =
      GetSPO_SatelliteCentreApproval.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<SatelliteCenterListDataData>>
  getSPO_SatelliteCentreApproval_list(int district_code, int state_code,
      int status, String financialYear) async {
    print("@@getSPO_SatelliteCentreApproval_list" + "1");
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
          ApiConstants.GetSPO_SatelliteCentreApproval_list;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "districtid": district_code,
        "stateId": state_code,
        "status": status, // for approved
        "financialYear": financialYear, // for approved

      });
      print("@@getSPO_SatelliteCentreApproval_list--bodyprint--: ${body
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
          "@@getSPO_SatelliteCentreApproval_list--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SatelliteCenterListData data =
      SatelliteCenterListData.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //    Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<SendTODPMCataractData>>
  getGovtPvtOther_Cataract(int district_code, int state_code,
      String userid) async {
    print("@@getGovtPvtOther_Cataract" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetGovtPvtOther_Cataract;
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
      print("@@getGovtPvtOther_Cataract--bodyprint--: ${body.toString()}");
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
          "@@getGovtPvtOther_Cataract--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SendTODPMCataract data =
      SendTODPMCataract.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<SendTODPMCataractData>>
  getGovtPvtOther_Diabetic(int district_code, int state_code,
      String userid) async {
    print("@@getGovtPvtOther_Diabetic" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetGovtPvtOther_Diabetic;
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
      print(
          "@@getGovtPvtOther_Diabetic--bodyprint--: ${url + body.toString()}");
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
          "@@getGovtPvtOther_Diabetic--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SendTODPMCataract data =
      SendTODPMCataract.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<SendTODPMCataractData>>
  getGovtPvtOther_Glaucoma(int district_code, int state_code,
      String userid) async {
    print("@@getGovtPvtOther_Glaucoma" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetGovtPvtOther_Glaucoma;
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
      print(
          "@@getGovtPvtOther_Glaucoma--bodyprint--: ${url + body.toString()}");
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
          "@@GetGovtPvtOther_Glaucoma--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SendTODPMCataract data =
      SendTODPMCataract.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<SendTODPMCataractData>>
  getGovtPvtOther_CornealBlindness(int district_code, int state_code,
      String userid) async {
    print("@@GetGovtPvtOther_CornealBlindness" + "1");
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
          ApiConstants.GetGovtPvtOther_CornealBlindness;
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
      print("@@GetGovtPvtOther_CornealBlindness--bodyprint--: ${url +
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
          "@@GetGovtPvtOther_Glaucoma--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SendTODPMCataract data =
      SendTODPMCataract.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<sendTODPMVRSurgeryData>>
  getGovtPvtOther_VRSurgery(int district_code, int state_code,
      String userid) async {
    print("@@GetGovtPvtOther_VRSurgery" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetGovtPvtOther_VRSurgery;
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
      print(
          "@@GetGovtPvtOther_VRSurgery--bodyprint--: ${url + body.toString()}");
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
          "@@GetGovtPvtOther_Glaucoma--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      sendTODPMVRSurgery data =
      sendTODPMVRSurgery.fromJson(responseData);

      if (data.status) {
        /// Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //    Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }

  static Future<List<nGOmoreDashboardClickStateWiseData>>
  GetStateWiseNGOForDashboard() async {
    print("@@GetStateWiseNGOForDashboard" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetStateWiseNGOForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@GetStateWiseNGOForDashboard--bodyprint--: ${url.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@GetStateWiseNGOForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      nGOmoreDashboardClickStateWise data =
      nGOmoreDashboardClickStateWise.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<nGOmoreDashboardClickDistrictWiseData>>
  GetDistrictWiseNGOForDashboard(int stateId) async {
    print("@@GetDistrictWiseNGOForDashboard" + "1");
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
          ApiConstants.GetDistrictWiseNGOForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,


      });
      print("@@GetStateWiseNGOForDashboard--bodyprint--: ${url +
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
          "@@GetStateWiseNGOForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      nGOmoreDashboardClickDistrictWise data =
      nGOmoreDashboardClickDistrictWise.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<nGOmoreStateDistrictBothData>>
  GetStateDistrictWiseNGOForDashboard(int stateId, int districtId) async {
    print("@@GetStateDistrictWiseNGOForDashboard" + "1");
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
          ApiConstants.GetStateDistrictWiseNGOForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,


      });
      print("@@GetStateDistrictWiseNGOForDashboard--bodyprint--: ${url +
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
          "@@GetStateWiseNGOForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      nGOmoreStateDistrictBoth data =
      nGOmoreStateDistrictBoth.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<GetStateWiseHospitalsForDashboardData>>
  getStateWiseHospitalsForDashboard() async {
    print("@@GetStateWiseHospitalsForDashboard" + "1");
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
          ApiConstants.GetStateWiseHospitalsForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@GetStateWiseHospitalsForDashboard--bodyprint--: ${url
          .toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@GetStateWiseHospitalsForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetStateWiseHospitalsForDashboard data =
      GetStateWiseHospitalsForDashboard.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<GeDistrictWiseHospitalsForDashboardData>>
  getDistrictWiseHospitalForDashboard(int stateId) async {
    print("@@getDistrictWiseHospitalForDashboard" + "1");
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
          ApiConstants.GetDistrictWiseHospitalForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,


      });
      print("@@getDistrictWiseHospitalForDashboard--bodyprint--: ${url +
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
          "@@getDistrictWiseHospitalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GeDistrictWiseHospitalsForDashboard data =
      GeDistrictWiseHospitalsForDashboard.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<BothDataForHospitalData>>
  getStateDistrictWiseHospitalForDashboard(int stateId, int districtId) async {
    print("@@getStateDistrictWiseHospitalForDashboard" + "1");
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
          ApiConstants.GetStateDistrictWiseHospitalForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,


      });
      print("@@getStateDistrictWiseHospitalForDashboard--bodyprint--: ${url +
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
          "@@getStateDistrictWiseHospitalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      BothDataForHospital data =
      BothDataForHospital.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<stateWiseMedicalCollegsData>>
  getStateWiseMedicalForDashboard() async {
    print("@@getStateWiseMedicalForDashboard" + "1");
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
          ApiConstants.GetStateWiseMedicalForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@GetStateWiseHospitalsForDashboard--bodyprint--: ${url
          .toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@GetStateWiseHospitalsForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      stateWiseMedicalCollegs data =
      stateWiseMedicalCollegs.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DistrictwiseMedicalCollegesData>>
  getDistrictWiseMedicalForDashboard(int stateId) async {
    print("@@GetDistrictWiseMedicalForDashboard" + "1");
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
          ApiConstants.GetDistrictWiseMedicalForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,


      });
      print("@@getDistrictWiseHospitalForDashboard--bodyprint--: ${url +
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
          "@@getDistrictWiseHospitalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DistrictwiseMedicalColleges data =
      DistrictwiseMedicalColleges.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<BothDataFoMEdicalCollegesllData>>
  getStateDistrictWiseMedicalForDashboard(int stateId, int districtId) async {
    print("@@getStateDistrictWiseMedicalForDashboard" + "1");
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
          ApiConstants.GetStateDistrictWiseMedicalForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,


      });
      print("@@getStateDistrictWiseMedicalForDashboard--bodyprint--: ${url +
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
          "@@getStateDistrictWiseMedicalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      BothDataFoMEdicalCollegesl data =
      BothDataFoMEdicalCollegesl.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<stateWisePrivatePractioriesData>>
  getStateWisePractitionerForDashboard() async {
    print("@@getStateWisePractitionerForDashboard" + "1");
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
          ApiConstants.GetStateWisePractitionerForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@getStateWisePractitionerForDashboard--bodyprint--: ${url
          .toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@getStateWisePractitionerForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      stateWisePrivatePractiories data =
      stateWisePrivatePractiories.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //    Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      ///    Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DistrictwisePrivatePractionriesData>>
  getDistrictWisePractitionerForDashboard(int stateId) async {
    print("@@getDistrictWisePractitionerForDashboard" + "1");
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
          ApiConstants.GetDistrictWisePractitionerForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,


      });
      print("@@getDistrictWisePractitionerForDashboard--bodyprint--: ${url +
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
          "@@getDistrictWisePractitionerForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DistrictwisePrivatePractionries data =
      DistrictwisePrivatePractionries.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<BothPrivatePractioresData>>
  getStateDistrictWisePractitionerForDashboard(int stateId,
      int districtId) async {
    print("@@GetStateDistrictWisePractitionerForDashboard" + "1");
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
          ApiConstants.GetStateDistrictWisePractitionerForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,


      });
      print("@@getStateDistrictWiseMedicalForDashboard--bodyprint--: ${url +
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
          "@@getStateDistrictWiseMedicalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      BothPrivatePractiores data =
      BothPrivatePractiores.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<stateWiseSatelliteCenterssData>>
  getStateWiseSatteliteForDashboard() async {
    print("@@getStateWiseSatteliteForDashboard" + "1");
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
          ApiConstants.GetStateWiseSatteliteForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@getStateWisePractitionerForDashboard--bodyprint--: ${url
          .toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@getStateWisePractitionerForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      stateWiseSatelliteCenterss data =
      stateWiseSatelliteCenterss.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DistrictwiseSatelliteCentyersData>>
  getDistrictWiseSatteliteForDashboard(int stateId) async {
    print("@@getDistrictWiseSatteliteForDashboard" + "1");
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
          ApiConstants.GetDistrictWiseSatteliteForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,


      });
      print("@@getDistrictWiseSatteliteForDashboard--bodyprint--: ${url +
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
          "@@getDistrictWiseSatteliteForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DistrictwiseSatelliteCentyers data =
      DistrictwiseSatelliteCentyers.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<BothSatelliteCentersData>>
  getStateDistrictWiseSatteliteForDashboard(int stateId, int districtId) async {
    print("@@GetStateDistrictWiseSatteliteForDashboard" + "1");
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
          ApiConstants.GetStateDistrictWiseSatteliteForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,


      });
      print("@@GetStateDistrictWiseSatteliteForDashboard--bodyprint--: ${url +
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
          "@@GetStateDistrictWiseSatteliteForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      BothSatelliteCenterss data =
      BothSatelliteCenterss.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DataBothWiseSatelliteWise>>
  getStateDistrictSatteliteWiseDataForDashboard(int stateId, int districtId,
      String srNo, String regHospitalId) async {
    print("@@getStateDistrictSatteliteWiseDataForDashboard" + "1");
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
          ApiConstants.GetStateDistrictSatteliteWiseDataForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,
        "srNo": srNo,
        "regHospitalId": regHospitalId
      });
      print(
          "@@getStateDistrictSatteliteWiseDataForDashboard--bodyprint--: ${url +
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
          "@@getStateDistrictWiseHospitalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      BothWiseSatelliteWise data =
      BothWiseSatelliteWise.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<
      Dpm_application_ngoApplicationsData>> get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List(
      String npcbNo, String userid,
      int status, int stateId, int districtId, int organisationType) async {
    print("@@get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List" + "1");
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
          ApiConstants.Get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "npcbNo": npcbNo,
        "userid": userid,
        "status": status,
        "stateId": stateId,
        "districtId": districtId,
        "organisationType": organisationType,


      });
      print(
          "@@get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List--bodyprint--: ${url +
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
          "@@get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      Dpm_application_ngoApplications data =
      Dpm_application_ngoApplications.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //   Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<
      GovtPrivateHospitalData>> get_DPM_Applications_GovtPrivate_applications(
      String npcbNo, String userid,
      int status, int stateId, int districtId, int organisationType) async {
    print("@@get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List_govt" + "1");
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
          ApiConstants.Get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "npcbNo": npcbNo,
        "userid": userid,
        "status": status,
        "stateId": stateId,
        "districtId": districtId,
        "organisationType": organisationType,


      });
      print(
          "@@get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List_govt--bodyprint--: ${url +
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
          "@@get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List_govt--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GovtPrivateHospital data =
      GovtPrivateHospital.fromJson(responseData);

      if (data.status) {
        // Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<StateWiseCampData>>
  getStateWiseCampForDashboard() async {
    print("@@getStateWiseCampForDashboard" + "1");
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
          ApiConstants.GetStateWiseCampForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@getStateWiseCampForDashboard--bodyprint--: ${url.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@getStateWiseCampForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      StateWiseCamps data =
      StateWiseCamps.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DistrictWiseCampsData>>
  getDistrictWiseCampForDashboard(int stateId) async {
    print("@@getDistrictWiseCampForDashboard" + "1");
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
          ApiConstants.GetDistrictWiseCampForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,


      });
      print("@@getDistrictWiseCampForDashboard--bodyprint--: ${url +
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
          "@@getDistrictWiseCampForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DistrictWiseCamps data =
      DistrictWiseCamps.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<BothWiseCampsData>>
  getStateDistrictWiseCampForDashboard(int stateId, int districtId) async {
    print("@@getStateDistrictWiseHospitalForDashboard" + "1");
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
          ApiConstants.GetStateDistrictWiseCampForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,


      });
      print("@@getStateDistrictWiseHospitalForDashboard--bodyprint--: ${url +
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
          "@@getStateDistrictWiseHospitalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      BothWiseCamps data =
      BothWiseCamps.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DataBothWiseCampWise>>
  getStateDistrictCampWiseDataForDashboard(int stateId, int districtId,
      String srNo, String regHospitalId) async {
    print("@@getStateDistrictCampWiseDataForDashboard" + "1");
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
          ApiConstants.GetStateDistrictCampWiseDataForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,
        "districtId": districtId,
        "srNo": srNo,
        "regHospitalId": regHospitalId
      });
      print("@@getStateDistrictCampWiseDataForDashboard--bodyprint--: ${url +
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
          "@@getStateDistrictWiseHospitalForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      BothWiseCampWise data =
      BothWiseCampWise.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<StateWiseDpmData>>
  getStateWiseDPMForDashboard() async {
    print("@@getStateWiseDPMForDashboard" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetStateWiseDPMForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@getStateWiseDPMForDashboard--bodyprint--: ${url.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@getStateWiseDPMForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      StateWiseDpm data =
      StateWiseDpm.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //   Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<List<DistrictWiseDpmData>>
  getDPMListForDashboard(int stateId) async {
    print("@@getDistrictWiseCampForDashboard" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPMListForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "stateId": stateId,


      });
      print("@@getDistrictWiseCampForDashboard--bodyprint--: ${url +
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
          "@@getDistrictWiseCampForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      DistrictWiseDpm data =
      DistrictWiseDpm.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<SpoListwiseData>>
  getSPOListForDashboard() async {
    print("@@getSPOListForDashboard" + "1");
    Response response1;

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetSPOListForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@getSPOListForDashboard--bodyprint--: ${url.toString()}");
      // Create Dio instance and make the request
      Dio dio = Dio();
      Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );

      print(
          "@@GetSPOListForDashboard--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SpoListwise data =
      SpoListwise.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        print(
            "@@showToast--Api Response: ${response
                .toString()}");
        // Return the list of data
        return data.data;
      } else {
        print(
            "@@showToast--2 Response: ${response
                .toString()}");
        //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }


  static Future<List<DataHospitallinkedwithNGO>> getHospitalsLinkedWithNGO(
      String npcbNo) async {
    print("@@getHospitalsLinkedWithNGO - Start");

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.Get_DPM_HospitalLinkedWithNGO;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "npcbNo": npcbNo,
      });

      print("@@getHospitalsLinkedWithNGO - Request: ${url + body}");

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
          "@@getHospitalsLinkedWithNGO - API Response: ${response.toString()}");

      var responseData = json.decode(response.data);
      HospitallinkedwithNGO data = HospitallinkedwithNGO.fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@getHospitalsLinkedWithNGO - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<List<DataHospitalDetailsView>> get_DPM_ViewHospitalDetails(
      String hospitalId) async {
    print("@@get_DPM_ViewHospitalDetails - Start");

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.Get_DPM_ViewHospitalDetails;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "npcbNo": hospitalId,
      });

      print("@@get_DPM_ViewHospitalDetails - Request: ${url + body}");

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

      print("@@get_DPM_ViewHospitalDetails - API Response: ${response
          .toString()}");

      var responseData = json.decode(response.data);
      HospitalDetailsView data = HospitalDetailsView.fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
      //  Utils.showToast(data.message, true);  ye tha record not found
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<
      List<DataEquipemntDetails>> get_DPM_ViewHospitalequipmentDetails(
      String hospitalId) async {
    print("@@get_DPM_ViewHospitalequipmentDetails - Start");

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.Get_DPM_ViewHospitalequipmentDetails;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "npcbNo": hospitalId,
      });

      print("@@get_DPM_ViewHospitalequipmentDetails - Request: ${url + body}");

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

      print("@@get_DPM_ViewHospitalequipmentDetails - API Response: ${response
          .toString()}");

      var responseData = json.decode(response.data);
      EquipemntDetails data = EquipemntDetails.fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<List<DataMouDetails>> get_DPM_ViewMOU(String darpan_No,
      String user_ID) async {
    print("@@get_DPM_ViewMOU - Start");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
    String stateCode_loginFetch = prefs.getString(AppConstant.state_code) ?? "";
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.Get_DPM_ViewMOU;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "darpan_No": darpan_No,
        "district_ID": districtCode_loginFetch,

        "user_ID": user_ID,

      });

      print("@@get_DPM_ViewMOU - Request: ${url + body}");

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

      print("@@get_DPM_ViewMOU - API Response13: ${response.toString()}");

      var responseData = json.decode(response.data);
      MouDetails data = MouDetails.fromJson(responseData);

      if (data.status) {
        return data.data;

      } else {
        print("@@get_DPM_ViewMOU - API Response11: ${response.toString()}");
      //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<List<DataDoctorlinkHospitals>> get_DPM_DoctorLinkedWithHospital(
      String npcbNo) async {
    print("@@get_DPM_DoctorLinkedWithHospital - Start");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
    String stateCode_loginFetch = prefs.getString(AppConstant.state_code) ?? "";
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.Get_DPM_DoctorLinkedWithHospital;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "npcbNo": npcbNo,


      });

      print("@@get_DPM_DoctorLinkedWithHospital - Request: ${url + body}");

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

      print("@@get_DPM_DoctorLinkedWithHospital - API Response: ${response
          .toString()}");

      var responseData = json.decode(response.data);
      DoctorlinkHospitals data = DoctorlinkHospitals.fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<List<
      DataNGoAPPlicationApprovedFinalScreen>> get_DPM_Ngo_Application_Approve_Reject_Hold(
      int application_Status,
      String reason_Hold_Reject, int stateid, int districtid, String userid,
      String darpan, String npcbnumber) async {
    print("@@get_DPM_Ngo_Application_Approve_Reject_Hold - Start");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.Get_DPM_Ngo_Application_Approve_Reject_Hold;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        /* "application_Status": 1,
        "reason_Hold_Reject": "",
        "stateid": 100,
        "districtid": 1001,
        "userid": "TTTest11001",
        "ngonumber": "up_20184013",
        "npcbnumber": "01840131001"*/
        "application_Status": application_Status,
        "reason_Hold_Reject": reason_Hold_Reject,
        "stateid": stateid,
        "districtid": districtid,
        "userid": userid,
        "ngonumber": darpan,
        "npcbnumber": npcbnumber,
      });

      print("@@get_DPM_Ngo_Application_Approve_Reject_Hold - Request: ${url +
          body}");

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
          "@@get_DPM_Ngo_Application_Approve_Reject_Hold - API Response: ${response
              .toString()}");

      var responseData = json.decode(response.data);
      NGoAPPlicationApprovedFinalScreen data = NGoAPPlicationApprovedFinalScreen
          .fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<
      List<NewDatahospitaldetailsview>> get_DPM_ViewNewHospitalDetailss(
      String hospitalId) async {
    print("@@get_DPM_ViewNewHospitalDetails - Start");

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.Get_DPM_ViewHospitalDetails;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "npcbNo": hospitalId,
      });

      print("@@get_DPM_ViewNewHospitalDetails - Request: ${url + body}");

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

      print("@@get_DPM_ViewHospitalDetails - API Response13: ${response
          .toString()}");

      var responseData = json.decode(response.data);
      hospitaldetailsview data = hospitaldetailsview.fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
      //  Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }


  static Future<List<
      DataNGoAPPlicationApprovedFinalScreen>> get_DPM_Hospital_Application_Approve_Reject_Hold(
      int application_Status,
      String reason_Hold_Reject, int stateid, int districtid, String userid,
      String darpan, String npcbnumber) async {
    print("@@get_DPM_Hospital_Application_Approve_Reject_Hold - Start");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.Get_DPM_Hospital_Application_Approve_Reject_Hold;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        /* "application_Status": 1,
        "reason_Hold_Reject": "",
        "stateid": 100,
        "districtid": 1001,
        "userid": "TTTest11001",
        "ngonumber": "up_20184013",
        "npcbnumber": "01840131001"*/
        "application_Status": application_Status,
        "reason_Hold_Reject": reason_Hold_Reject,
        "stateid": stateid,
        "districtid": districtid,
        "userid": userid,
        "ngonumber": darpan,
        "npcbnumber": npcbnumber,
      });

      print("@@get_DPM_Ngo_Application_Approve_Reject_Hold - Request: ${url +
          body}");

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
          "@@get_DPM_Ngo_Application_Approve_Reject_Hold - API Response: ${response
              .toString()}");

      var responseData = json.decode(response.data);
      NGoAPPlicationApprovedFinalScreen data = NGoAPPlicationApprovedFinalScreen
          .fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<List<
      DataGovtPrivateDetails>> get_DPM_Government_District_Hospital_list_Approval
      (int district_code, int state_code, String npcbno, String financialYear,
      int organisationType) async {
    print("@@get_DPM_Government_District_Hospital_list_Approval - Start");

    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.Get_DPM_Government_District_Hospital_list_Approval;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "district_code": district_code,
        "state_code": state_code,
        "npcbno": npcbno,
        "financialYear": financialYear,
        "organisationType": organisationType
      });

      print(
          "@@get_DPM_Government_District_Hospital_list_Approval - Request: ${url +
              body}");

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
          "@@get_DPM_Government_District_Hospital_list_Approval - API Response: ${response
              .toString()}");

      var responseData = json.decode(response.data);
      GovtPrivateDetails data = GovtPrivateDetails.fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@getHospitalsLinkedWithNGO - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<List<DataDoctorlinkwithGovtPrivate>> getDPM_DoctorList(
      int districtCode, int StateCode, int roleId, String npcbNo) async {
    print("@@getDPM_DoctorList - Start");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(AppConstant.distritcCode) ?? "";
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_DoctorList;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "district_code": 1001,
        "state_code": 100,
        "roleId": 10,
        "npcbNo": npcbNo,
      });

      print("@@getDPM_DoctorList - Request: ${url + body}");

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

      print("@@getDPM_DoctorList - API Response: ${response.toString()}");

      var responseData = json.decode(response.data);
      DoctorlinkwithGovtPrivate data = DoctorlinkwithGovtPrivate.fromJson(
          responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }

  static Future<List<
      DataGovtPrivateApprovedFinalScreen>> get_DPM_GOV_PVT_OTHER_Application_Approve_Reject_Hold(
      int application_Status,
      String reason_Hold_Reject, int stateid, int districtid, String userid,
      String ngonumber, String npcbnumber, String orgType) async {
    print("@@get_DPM_GOV_PVT_OTHER_Application_Approve_Reject_Hold - Start");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String districtCode_loginFetch =
        prefs.getString(AppConstant.distritcCode) ?? "";
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl +
          ApiConstants.Get_DPM_GOV_PVT_OTHER_Application_Approve_Reject_Hold;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        /* {
          "application_Status": 1,
          "reason_Hold_Reject": "string",
          "stateid": 100,
          "districtid": 1001,
          "userid": "TTTEST11001",
          "ngonumber": "string",
          "npcbnumber": "GH201910011154",
          "orgType": "10"
        }*/
        "application_Status": application_Status,
        "reason_Hold_Reject": reason_Hold_Reject,
        "stateid": stateid,
        "districtid": districtid,
        "userid": userid,
        "ngonumber": "",
        "npcbnumber": npcbnumber,
        "orgType": orgType,
      });

      print(
          "@@get_DPM_GOV_PVT_OTHER_Application_Approve_Reject_Hold - Request: ${url +
              body}");

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
          "@@get_DPM_GOV_PVT_OTHER_Application_Approve_Reject_Hold - API Response: ${response
              .toString()}");

      var responseData = json.decode(response.data);
      GovtPrivateApprovedFinalScreen data = GovtPrivateApprovedFinalScreen
          .fromJson(responseData);

      if (data.status) {
        return data.data;
      } else {
        Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      print("@@get_DPM_ViewHospitalDetails - Error: $e");
      Utils.showToast("Failed to fetch data", true);
      return [];
    }
  }


  static Future<ApproveMOURenewClick> get_DPM_MouRenew(int h_Reg_ID,
      String userid) async {
    print("@@get_DPM_MouRenew" + "1");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return null;
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.Get_DPM_MouRenew;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "h_Reg_ID": h_Reg_ID,
        "userid": userid
      });

      print("@@get_DPM_MouRenew--bodyprint--: ${url + body.toString()}");

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

      print("@@get_DPM_MouRenew--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);

      // Convert JSON response to ApproveMOURenewClick model
      ApproveMOURenewClick data = ApproveMOURenewClick.fromJson(responseData);

      if (data.status) {
        return data; // Return the parsed data object
      } else {
        Utils.showToast(data.message, true);
        return null;
      }
    } catch (e) {
      Utils.showToast(e.toString(), true);
      return null;
    }
  }


  static Future<List<LstGuidelineFileName>> guidelinesForHomePage() async {
    try {
      var url = ApiConstants.baseUrl + ApiConstants.GuidelinesForHomePage;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body

      print("@@guidelinesForHomePage--url Response: ${url.toString()}");
      Dio dio = Dio();
      Response response = await dio.post(
        url,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.plain,
        ),
      );
      print("@@guidelinesForHomePage--Api Response: ${response.toString()}");
      var responseData = json.decode(response.data);
      GuilinessPage data = GuilinessPage.fromJson(responseData);
      return data.data?.lstGuidelineFileName ?? [];
    } catch (e) {
      print("Error fetching guidelines: $e");
      return [];
    }
  }

  static Future<DataPatientCountDetail> fetchPatientCount() async {
    final String apiUrl =
        ApiConstants.baseUrl + ApiConstants.GetTodayAllPatientRegistred;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["status"] == true && data["data"] != null) {
          return DataPatientCountDetail.fromJson(data["data"][0]);
        }
      } else {
        print("Error: API request failed with status code ${response
            .statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return null; // Return null if API fails
  }

  static Future<TotalPatientCampData> fetchPatientCountCamp(int stateId,int districtId,
      int entryBy,int userRoleType,String userId) async {
    final String apiUrl =
        ApiConstants.baseUrl + ApiConstants.GetTodayPatientRegistredCamp;

    final Map<String, dynamic> requestBody = {
      "stateId": stateId,
      "districtId": districtId,
      "entryBy": entryBy,
      "userRoleType": userRoleType,
      "userId": userId
    };

    try {
      print("@@fetchPatientCountCamp: $apiUrl");
      print("@@fetchPatientCountCamp Body: ${jsonEncode(requestBody)}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      print("@@fetchPatientCountCamp Body: ${response.toString()}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == true && data["data"] != null) {
          return TotalPatientCampData.fromJson(data["data"][0]);
        }
      } else {
        print("Error: API request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }


  static Future<List<CampDashboardData>>
  getCampDashboardData(int userRoleType, int districtid, int stateid, String userId,
      String financialYear, int organizationType, String ngoId) async {
    print("@@getCampDashboardData" + "1");
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
          ApiConstants.baseUrl + ApiConstants.getCampDashboardData;
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
        "ngoId": "0"
      });
      print("@@getCampDashboardData--bodyprint--: ${url+body.toString()}");
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
          "@@getCampDashboardData--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      CampDashboard data = CampDashboard.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

      return [];
    }
  }


  static Future<List<ViewDashboardclickData>>
  viewCampForDashboard(int stateId, int districtId, String campManagerId, String ngoId,
      String campId, String campNPCBId, String financialYear) async {
    print("@@viewCampForDashboard" + "1");
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
          ApiConstants.baseUrl + ApiConstants.viewCampForDashboard;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({

        "stateId": stateId,
        "districtId": districtId,
        "campManagerId": campManagerId,
        "ngoId": ngoId,
        "campId": campId,
        "campNPCBId": campNPCBId,
        "financialYear": financialYear
      });
      print("@@viewCampForDashboard--bodyprint--: ${url+body.toString()}");
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
          "@@getCampDashboardData--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ViewDashboardclick data = ViewDashboardclick.fromJson(responseData);

      if (data.status) {
        //Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);

      return [];
    }
  }
  static Future<List<DataGetDPM_Edit_UpdateUserDetail>> getDPM_Edit_UpdateUserDetails(
      int h_Reg_ID,
      String userid,
      int statecode,
      int districtcode,
      String roleid) async {
    print("@@getDPM_Edit_UpdateUserDetails" + "1");
    Response response1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schoolidSaved = prefs.getString(AppConstant.schoolid) ?? "";
    print("@@getDPM_Edit_UpdateUserDetails--: $schoolidSaved");
    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      // Define the URL and headers
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_Edit_UpdateUserDetails;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      // Define the request body
      var body = json.encode({
        "h_Reg_ID": 0,
        "userid": userid,
        "statecode": 0,
        "districtcode": 0,
        "roleid": ""
      });
      print("@@getDPM_Edit_UpdateUserDetails--bodyprint--: ${url + body.toString()}");
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

      print("@@getDPM_Edit_UpdateUserDetails--Api Response: ${response.toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      GetDPM_Edit_UpdateUserDetail data =
      GetDPM_Edit_UpdateUserDetail.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      //  Utils.showToast(e.toString(), true);
      return [];
    }
  }

  static Future<UpdateUserApi> updateUserDetails({
     String userid,
    String roleid,
     String username,
     String orgname,
     String mobileno,
     String emailid,
     String address,
     int statecode,
    int districtcode,
     String isDpmDistrictUpdate,
  }) async {
    try {
      var url = ApiConstants.baseUrl +  ApiConstants.updateusers;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "userid": userid,
        "roleid": int.tryParse(roleid) ?? 0,
        "username": username,
        "orgname": orgname,
        "mobileno": int.tryParse(mobileno) ?? 0,
        "emailid": emailid,
        "address": address,
        "statecode": statecode,
        "districtcode": districtcode,
        "isDpmDistrictUpdate": isDpmDistrictUpdate,
      });
      print('@@updateUserDetails Response: ${url+body.toString()}');

      Dio dio = Dio();
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
      );
      print('@@updateUserDetails Response: ${response.data}');
      return UpdateUserApi.fromJson(response.data);
    } catch (e) {
      print('Error in updateUserDetails: $e');
      return UpdateUserApi(
        status: false,
        message: 'Something went wrong',
        data: null,
        list: null,
      );
    }
  }
  static Future<List<CataractDataReportData>> getDPM_CataractReport(
      int year, String _selectedDateText, String _selectedDateTextToDate,
      int stateId, int districtId, String orgtype, String bindOrganisationNAme,
      String status, String financialYear, String npcbno) async {
    print("@@getDPM_CataractReport" + "1");
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
          ApiConstants.GetDPM_CataractReport;
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
          "@@getDPM_CataractReport--bodyprint--: ${body
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
          "@@getDPM_CataractReport--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      CataractDataReport data = CataractDataReport.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);

      return [];
    }
  }
  static Future<List<ViewClickCatractPdfTypeData>> getCataractPdfType(
      String mode, String p_DeseaseId, String userID, String p_vStatus, int orgType) async {

    print("@@getCataractPdfType start");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_CataractPatientView;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "mode": mode,
        "p_DeseaseId": p_DeseaseId,
        "p_UserID": userID,
        "p_vStatus": p_vStatus,
        "orgType": orgType
      });

      print("@@getCataractPdfType--request body: $body");

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

      print("@@getCataractPdfType--response: ${response.data}");

      var responseData = json.decode(response.data);
      ViewClickCatractPdfType result = ViewClickCatractPdfType.fromJson(responseData);

      if (result.status == true) {
        return result.data ?? [];
      } else {
        Utils.showToast(result.message ?? "Failed to load data", true);
        return [];
      }
    } catch (e) {
      Utils.showToast("Error: ${e.toString()}", true);
      return [];
    }
  }
  static Future<List<DataReportScreen>> getData_amount_totalCountGlaucomaPatients(
      int year, String _selectedDateText, String _selectedDateTextToDate,
      int stateId, int districtId, String orgtype, String bindOrganisationNAme,
      String status, String financialYear, String npcbno) async {
    print("@@getData_amount_totalCountGlaucomaPatients" + "1");
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
          ApiConstants.GetData_amount_totalCountGlaucomaPatients;
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
          "@@getData_amount_totalCountGlaucomaPatients--bodyprint--: ${url+body
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
          "@@getData_amount_totalCountGlaucomaPatients--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ReportScreen data = ReportScreen.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);

      return [];
    }
  }
  static Future<List<galucomaDataReportyData>> getDPM_GlaucomaReport(
      int year, String _selectedDateText, String _selectedDateTextToDate,
      int stateId, int districtId, String orgtype, String bindOrganisationNAme,
      String status, String financialYear, String npcbno) async {
    print("@@getDPM_GlaucomaReport" + "1");
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
          ApiConstants.GetDPM_GlaucomaReport;
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
          "@@getDPM_GlaucomaReport--bodyprint--: ${url+body
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
          "@@getDPM_GlaucomaReport--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      galucomaDataReporty data = galucomaDataReporty.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);

      return [];
    }
  }

  static Future<List<GlaucomPDfFileData>> getDPM_GlaucomaReportView(
      String mode, String p_DeseaseId, String userID, String p_vStatus, int orgType) async {

    print("@@getDPM_GlaucomaReportView start");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_GlaucomaReportView;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "mode": mode,
        "p_DeseaseId": p_DeseaseId,
        "p_UserID": userID,
        "p_vStatus": p_vStatus,
        "orgType": orgType
      });

      print("@@getDPM_GlaucomaReportView--request body: $body");

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

      print("@@getDPM_GlaucomaReportView--response: ${response.data}");

      var responseData = json.decode(response.data);
      GlaucomPDfFile result = GlaucomPDfFile.fromJson(responseData);

      if (result.status == true) {
        return result.data ?? [];
      } else {
        Utils.showToast(result.message ?? "Failed to load data", true);
        return [];
      }
    } catch (e) {
      Utils.showToast("Error: ${e.toString()}", true);
      return [];
    }
  }


  static Future<List<DataReportScreen>> getData_amount_totalCountSquintPatients(
      int year, String _selectedDateText, String _selectedDateTextToDate,
      int stateId, int districtId, String orgtype, String bindOrganisationNAme,
      String status, String financialYear, String npcbno) async {
    print("@@getData_amount_totalCountSquintPatients" + "1");
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
          ApiConstants.GetData_amount_totalCountSquintPatients;
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
          "@@getData_amount_totalCountSquintPatients--bodyprint--: ${url+body
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
          "@@getData_amount_totalCountGlaucomaPatients--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      ReportScreen data = ReportScreen.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);

      return [];
    }
  }

  static Future<List<SquintDataReportData>> getDPM_SquintReport(
      int year, String _selectedDateText, String _selectedDateTextToDate,
      int stateId, int districtId, String orgtype, String bindOrganisationNAme,
      String status, String financialYear, String npcbno) async {
    print("@@getDPM_SquintReport" + "1");
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
          ApiConstants.GetDPM_SquintReport;
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
          "@@getDPM_SquintReport--bodyprint--: ${url+body
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
          "@@getDPM_SquintReport--Api Response: ${response
              .toString()}");

      // Parse the response
      var responseData = json.decode(response.data);
      SquintDataReport data = SquintDataReport.fromJson(responseData);

      if (data.status) {
        //  Utils.showToast(data.message, true);
        // Return the list of data
        return data.data;
      } else {
        // Utils.showToast(data.message, true);
        return [];
      }
    } catch (e) {
      // Utils.showToast(e.toString(), true);

      return [];
    }
  }

  static Future<List<SquintPdfFileData>> getDPM_SquintReportView(
      String mode, String p_DeseaseId, String userID, String p_vStatus, int orgType) async {

    print("@@getDPM_SquintReportView start");

    // Check network availability
    bool isNetworkAvailable = await Utils.isNetworkAvailable();
    if (!isNetworkAvailable) {
      Utils.showToast(AppConstant.noInternet, true);
      return [];
    }

    try {
      var url = ApiConstants.baseUrl + ApiConstants.GetDPM_SquintReportView;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "apikey": "Key123",
        "apipassword": "PWD123",
      };

      var body = json.encode({
        "mode": mode,
        "p_DeseaseId": p_DeseaseId,
        "p_UserID": userID,
        "p_vStatus": p_vStatus,
        "orgType": orgType
      });

      print("@@getDPM_SquintReportView--request body: $body");

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

      print("@@getDPM_GlaucomaReportView--response: ${response.data}");

      var responseData = json.decode(response.data);
      SquintPdfFile result = SquintPdfFile.fromJson(responseData);

      if (result.status == true) {
        return result.data ?? [];
      } else {
        Utils.showToast(result.message ?? "Failed to load data", true);
        return [];
      }
    } catch (e) {
      Utils.showToast("Error: ${e.toString()}", true);
      return [];
    }
  }
}
//https://www.geeksforgeeks.org/flutter-fetching-list-of-data-from-api-through-dio/
