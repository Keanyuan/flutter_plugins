import 'sp_notice_model_item.dart';

class SpRespNoticeModel {
  List<SpNoticeModelItem> modelItemList;
  String code;
  String errorMsg;
  SpRespNoticeModel(
      {this.modelItemList,
        this.code,
        this.errorMsg
        });


  SpRespNoticeModel.fromJson(Map<String, dynamic> json) {
    if (json['modelItemList'] != null) {
      modelItemList = new List<SpNoticeModelItem>();
      json['modelItemList'].forEach((v) {
        modelItemList.add(new SpNoticeModelItem.fromJson(v));
      });
    }
    code = json['code'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.modelItemList != null) {
      data['modelItemList'] =
          this.modelItemList.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['errorMsg'] = this.errorMsg;
    return data;
  }

  @override
  String toString() {
    return 'SpRespNoticeModel{modelItemList: $modelItemList, code: $code, errorMsg: $errorMsg}';
  }


}
