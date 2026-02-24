class CardReq {
  CardReq({
    this.realName = '',
    this.cardNo = '',
    this.bankId = '',
    this.amount = '',
    this.purpose = '',
    this.bankName = '',
    this.bankLogo = '',
  });

  CardReq.fromJson(dynamic json) {
    realName = json['realName'];
    cardNo = json['cardNo'];
    bankId = json['bankId'];
    amount = json['amount'];
    purpose = json['purpose'];
    bankName = json['bankName'];
    bankLogo = json['bankLogo'];
  }
  String realName = '';
  String cardNo ='';
  String bankId = '';
  String amount = '';
  String purpose = '';
  String bankName = '';
  /// 银行/收款人图标 URL，传入时在收款人区域显示
  String bankLogo = '';


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['realName'] = realName;
    map['cardNo'] = cardNo;
    map['bankId'] = bankId;
    map['amount'] = amount;
    map['purpose'] = purpose;
    map['bankName'] = bankName;
    map['bankLogo'] = bankLogo;
    return map;
  }

}