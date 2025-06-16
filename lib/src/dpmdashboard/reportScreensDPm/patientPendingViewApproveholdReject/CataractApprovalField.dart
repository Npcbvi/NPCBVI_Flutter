class CataractApprovalField {
  final String catid;
  final String p_userid;
  final int district_code;
  final int statusid;
  final String statusname;
  CataractApprovalField({
    this.catid,
    this.p_userid,
    this.district_code,
    this.statusid,
    this.statusname,
  });

  Map<String, dynamic> toJson() {
    return {
      "catid": catid,
      "p_userid": p_userid,
      "district_code": district_code,
      "statusid":statusid,
      "statusname": statusname,

    };
  }
}