
class ApiConstants {
// unused url
  static String baseUrl = 'https://npcbvi.mohfw.gov.in/NPCBMobAppTest/api/';
  static String UserLogin = 'UserLogin';
  static String State = 'State';

  static String spoRegistration = 'Registration/api/SpoRegistration';
  static String DpmRegistration = 'Registration/api/DpmRegistration';
  static String SendOTPForForgotPassword = 'SendOTPForForgotPassword';
  static String UserForgotPassword = 'UserForgotPassword';

  static String GetDashboard = 'GetDashboard';
  static String GetContacts = 'GetContacts';
  static final String noInternet = "No intenet connection";

  static final String GetRegisteredUser = "Registration/api/GetRegisteredUser";

  static final String registration_of_Govt_Private_Other_Hospital = "Registration/api/Registration_of_Govt_Private_Other_Hospital";
  static String GetDPM_Dashboard = 'DpmDashboard/api/GetDPM_Dashboard';

  static String GetDPM_NGOApplication = 'DpmDashboard/api/GetDPM_NGOApplication';

  static String GetDPM_NGOApprovedPending = 'DpmDashboard/api/GetDPM_NGOApprovedPending';

  static String GetDPM_GH = 'DpmDashboard/api/GetDPM_GH';
  static String GetDPM_PrivatePartition = 'DpmDashboard/api/GetDPM_PrivatePartition';

  static String GetDPM_PrivateMedicalCollege = 'DpmDashboard/api/GetDPM_PrivateMedicalCollege';
  static String GetDPM_SatelliteCentre = 'DpmDashboard/api/GetDPM_SatelliteCentre';
  static String GetDPM_ScreeningCamp = 'DpmDashboard/api/GetDPM_ScreeningCamp';
  static String ChangePassword = 'ChangePassword';

  static String GetDPM_HospitalApproval = 'DpmDashboard/api/GetDPM_HospitalApproval';

  static String GetDPM_GovtPvtOther = 'DpmDashboard/api/GetDPM_GovtPvtOther';
  static String GetDPM_EyeScreening = 'DpmDashboard/api/GetDPM_EyeScreening';
  static String GetDPM_Patients_Approved = 'DpmDashboard/api/GetDPM_Patients_Approved';
  static String GetDPM_Patients_Pending = 'DpmDashboard/api/GetDPM_Patients_Pending';
  static String GetDPM_MOUApprove = 'DpmDashboard/api/GetDPM_MOUApprove';
  static String GetDPM_EyeScreeningEdit = 'DpmDashboard/api/GetDPM_EyeScreeningEdit';
  static String GetDPM_ScreeningYear = 'DpmDashboard/api/GetDPM_ScreeningYear';
  static String GetSchoolEyeScreening_Registration = 'DpmDashboard/api/SchoolEyeScreening_Registration';
  static String GetDPM_Glaucoma = 'DpmDashboard/api/GetDPM_Glaucoma';
  static String GetDPM_Cataract = 'DpmDashboard/api/GetDPM_Cataract';
  static String GetDPM_Daiabetic = 'DpmDashboard/api/GetDPM_Daiabetic';
  static String GetDPM_CornealBlindness = 'DpmDashboard/api/GetDPM_CornealBlindness';

  static String GetDPM_VRSurgery = 'DpmDashboard/api/GetDPM_VRSurgery';

  static String GetDPM_CongenitalPtosis = 'DpmDashboard/api/GetDPM_CongenitalPtosis';
  static String GetDPM_TraumaChildren = 'DpmDashboard/api/GetDPM_TraumaChildren';
  static String GetDPM_Squintapproval = 'DpmDashboard/api/GetDPM_Squintapproval';
  //Childhood blindness pending work now

  static String GetDPM_Patients_Approved_View = 'DpmDashboard/api/GetDPM_Patients_Approved_View';

  static String GetData_by_allngo_amount_totalCount = 'DpmDashboard/api/GetData_by_allngo_amount_totalCount';

  static String GetDPM_CataractPatientView = 'DpmDashboard/api/GetDPM_CataractPatientView';


  //District NGO APi

  static String GetHospitalNgoForDDL = 'GetHospitalNgoForDDL';
  static String NGODashboard = 'GetNGODashboardData';
  static String GetHospitalList = 'GetHospitalList';

  static String VeiwHospitalDetails = 'VeiwHospitalDetails';

  static String GetHospitalData = 'GetHospitalData';

  static String GetDoctorlinkedwithHospital = 'GetDoctorlinkedwithHospital';

  static String GetDoctorDetailsById = 'GetDoctorDetailsById';

  static String GetAllNgoService = 'GetAllNgoService';

  static String GetUploadedMouList = 'GetUploadedMouList';
  /*static String GetEyeBankDonationList = 'GetEyeBankDonationList';*/
  static String GetEyeBankDonationList = 'GetEyeBankListByNGO';

  static String GetEyeDonationCenterListByNGO = 'GetEyeDonationCenterListByNGO';
  static String RegistrationEyeDonationCenterByNGO = 'RegistrationEyeDonationCenterByNGO';

  static String GetCampManagerList = 'GetCampManagerList';
  static String GetDoctorListByHId = 'GetDoctorListByHId';
  static String CampManagerRegistration = 'CampManagerRegistration';

  static String GetCampManagerDetailsById = 'GetCampManagerDetailsById';

  static String UpdateCampManager = 'UpdateCampManager';

  static String GetCampList = 'GetCampList';
  static String GetCampManager = 'GetCampManager';
  static String CampRegistration = 'CampRegistration';

  static String GetHospitalForDDL = 'GetHospitalForDDL';
  static String GetSatelliteManagerList = 'GetSatelliteManagerList';

  static String SatelliteManagerRegistration = 'SatelliteManagerRegistration';

  static String GetSatelliteManagerById = 'GetSatelliteManagerById';
  static String UpdateSatelliteManager = 'UpdateSatelliteManager';

  static String GetSatelliteCenterList = 'GetSatelliteCenterList';

  static String GetSatelliteManager = 'GetSatelliteManager';

  static String SetallightCenterRegistration = 'SetallightCenterRegistration';

  static String HospitalDashboard = 'HospitalDashboard';

  static String GetSPO_Dashboard = 'SpmDashboard/api/GetSPO_Dashboard';

  static String GetSPO_DPM_View = 'SpmDashboard/api/GetSPO_DPM_View';

  static String GetSPO_RegisteredEyesurgeonList = 'SpmDashboard/api/GetSPO_RegisteredEyesurgeonList';


  static String GetSPO_EyeBankApplicationApproval = 'SpmDashboard/api/GetSPO_EyeBankApplicationApproval';

  static String GetSPO_EyeDonationApplicationApproval = 'SpmDashboard/api/GetSPO_EyeDonationApplicationApproval';

  static String PatientRegistration = 'PatientRegistration';

  static String GetSPO_PatientApproval = 'SpmDashboard/api/GetSPO_PatientApproval';

  static String GetSPO_DiseasewiseRecordsApproval = 'SpmDashboard/api/GetSPO_DiseasewiseRecordsApproval';

  static String GetSPO_Patients_Approved_View = 'SpmDashboard/api/GetSPO_Patients_Approved_View';
  static String GetSPO_DistrictNgoApproval = 'SpmDashboard/api/GetSPO_DistrictNgoApproval';

  static String getSPO_DistrictNgoApproval_list = 'SpmDashboard/api/GetSPO_DistrictNgoApproval_list';
  static String GetSPO_GHCHCOtherApprovals = 'SpmDashboard/api/GetSPO_GHCHCOtherApproval';

  static String GetSPO_GHCHCOtherApproval_list = 'SpmDashboard/api/GetSPO_GHCHCOtherApproval_list';


  static String GetSPO_PrivatePractitionerApproval = 'SpmDashboard/api/GetSPO_PrivatePractitionerApproval';

  static String GetSPO_PrivatePractitionerApproval_list = 'SpmDashboard/api/GetSPO_PrivatePractitionerApproval_list';

  static String GetSPO_PrivateMedicalCollegeApproval = 'SpmDashboard/api/GetSPO_PrivateMedicalCollegeApproval';

  static String GetSPO_PrivateMedicalCollegeApproval_list = 'SpmDashboard/api/GetSPO_PrivateMedicalCollegeApproval_list';
  static String GetSPO_ScreeningCampApproval = 'SpmDashboard/api/GetSPO_ScreeningCampApproval';

  static String GetSPOScreeningCampApproval_list = 'SpmDashboard/api/GetSPOScreeningCampApproval_list';
  static String GetSPO_SatelliteCentreApproval = 'SpmDashboard/api/GetSPO_SatelliteCentreApproval';

  static String GetSPO_SatelliteCentreApproval_list = 'SpmDashboard/api/GetSPO_SatelliteCentreApproval_list';

  static String GetGovtPvtOther_Cataract = 'SentToDpmGovtPvt/api/GetGovtPvtOther_Cataract';

  static String GetGovtPvtOther_Diabetic = 'SentToDpmGovtPvt/api/GetGovtPvtOther_Diabetic';
  static String GetGovtPvtOther_Glaucoma = 'SentToDpmGovtPvt/api/GetGovtPvtOther_Glaucoma';
  static String GetGovtPvtOther_CornealBlindness = 'SentToDpmGovtPvt/api/GetGovtPvtOther_CornealBlindness';
  static String GetGovtPvtOther_VRSurgery = 'SentToDpmGovtPvt/api/GetGovtPvtOther_VRSurgery';

  static String GetStateWiseNGOForDashboard = 'GetStateWiseNGOForDashboard';
  static String GetDistrictWiseNGOForDashboard = 'GetDistrictWiseNGOForDashboard';
  static String GetStateDistrictWiseNGOForDashboard = 'GetStateDistrictWiseNGOForDashboard';


  static String GetStateWiseHospitalsForDashboard = 'GetStateWiseHospitalsForDashboard';
  static String GetDistrictWiseHospitalForDashboard = 'GetDistrictWiseHospitalForDashboard';
  static String GetStateDistrictWiseHospitalForDashboard = 'GetStateDistrictWiseHospitalForDashboard';


  static String GetStateWiseMedicalForDashboard = 'GetStateWiseMedicalForDashboard';
  static String GetDistrictWiseMedicalForDashboard = 'GetDistrictWiseMedicalForDashboard';
  static String GetStateDistrictWiseMedicalForDashboard = 'GetStateDistrictWiseMedicalForDashboard';



  static String GetStateWisePractitionerForDashboard = 'GetStateWisePractitionerForDashboard';

  static String GetDistrictWisePractitionerForDashboard = 'GetDistrictWisePractitionerForDashboard';

  static String GetStateDistrictWisePractitionerForDashboard = 'GetStateDistrictWisePractitionerForDashboard';


  static String GetStateWiseSatteliteForDashboard = 'GetStateWiseSatteliteForDashboard';
  static String GetDistrictWiseSatteliteForDashboard = 'GetDistrictWiseSatteliteForDashboard';
  static String GetStateDistrictWiseSatteliteForDashboard = 'GetStateDistrictWiseSatteliteForDashboard';


  static String GetStateWiseCampForDashboard = 'GetStateWiseCampForDashboard';
  static String GetDistrictWiseCampForDashboard = 'GetDistrictWiseCampForDashboard';
  static String GetStateDistrictWiseCampForDashboard = 'GetStateDistrictWiseCampForDashboard';


  static String GetStateWiseDPMForDashboard = 'GetStateWiseDPMForDashboard';

  static String GetDPMListForDashboard = 'GetDPMListForDashboard';

  static String GetSPOListForDashboard = 'GetSPOListForDashboard';


  static String Get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List = 'DpmDashboard/api/Get_DPM_Applications_NGO_GOV_CHC_HOSPITALS_List';
  static String Get_DPM_NGOApplicationDetails = 'DpmDashboard/api/Get_DPM_NGOApplicationDetails';
  static String Get_DPM_HospitalLinkedWithNGO = 'DpmDashboard/api/Get_DPM_HospitalLinkedWithNGO';
  static String Get_DPM_ViewHospitalDetails = 'DpmDashboard/api/Get_DPM_ViewHospitalDetails';
  static String Get_DPM_ViewHospitalequipmentDetails = 'DpmDashboard/api/Get_DPM_ViewHospitalequipmentDetails';
  static String Get_DPM_ViewMOU = 'DpmDashboard/api/Get_DPM_ViewMOU';
  static String Get_DPM_DoctorLinkedWithHospital = 'DpmDashboard/api/Get_DPM_DoctorLinkedWithHospital';
  static String Get_DPM_Ngo_Application_Approve_Reject_Hold = 'DpmDashboard/api/Get_DPM_Ngo_Application_Approve_Reject_Hold';


  static String Get_NewHospitalNgoDetails = 'DpmDashboard/api/Get_NewHospitalNgoDetails';

  static String get_DPM_ViewNewHospitalDetails = 'DpmDashboard/api/get_DPM_ViewNewHospitalDetails';

  static String Get_DPM_Hospital_Application_Approve_Reject_Hold = 'DpmDashboard/api/Get_DPM_Hospital_Application_Approve_Reject_Hold';

  static String Get_DPM_Government_District_Hospital_list_Approval = 'DpmDashboard/api/Get_DPM_Government_District_Hospital_list_Approval';

  static String GetDPM_DoctorList = 'DpmDashboard/api/GetDPM_DoctorList';

}
