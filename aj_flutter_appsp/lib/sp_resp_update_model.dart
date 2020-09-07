class SpRespUpdateModel {
  bool isExternalUrl;
  bool mustUpdate;
  bool showUpdate;
  String code;
  String errorMsg;
  String updateLog;
  String url;

  SpRespUpdateModel({this.isExternalUrl,
    this.mustUpdate,
    this.showUpdate,
    this.code,
    this.errorMsg,
    this.updateLog,
    this.url});


  SpRespUpdateModel.fromJson(Map<String, dynamic> json) {
    isExternalUrl = json['isExternalUrl'];
    mustUpdate = json['mustUpdate'];
    showUpdate = json['showUpdate'];
    code = json['code'];
    errorMsg = json['errorMsg'];
    updateLog = json['updateLog'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isExternalUrl'] = this.isExternalUrl;
    data['mustUpdate'] = this.mustUpdate;
    data['showUpdate'] = this.showUpdate;
    data['code'] = this.code;
    data['errorMsg'] = this.errorMsg;
    data['updateLog'] = this.updateLog;
    data['url'] = this.url;
    return data;
  }


  @override
  String toString() {
    return 'SpRespUpdateModel{isExternalUrl: $isExternalUrl, mustUpdate: $mustUpdate, showUpdate: $showUpdate, code: $code, errorMsg: $errorMsg, updateLog: $updateLog, url: $url}';
  }


}
