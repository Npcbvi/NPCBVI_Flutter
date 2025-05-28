class CataractApprovalField {
  final int catid;
  final String p_userid;
  final int district_code;

  CataractApprovalField({
     this.catid,
     this.p_userid,
     this.district_code,
  });

  Map<String, dynamic> toJson() {
    return {
      "catid": catid,
      "p_userid": p_userid,
      "district_code": district_code,
    };
  }
}
