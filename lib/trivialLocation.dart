class TrivialLocation 
{
  String? status;
  String? message;
  String? text;
  int? number;
  bool? found;
  String? type;

 TrivialLocation({
    this.message,
    this.text ,
    this.number ,
    this.found ,
    this.type ,
  });
  TrivialLocation.fromJson(Map<String, dynamic> json) {
    message = json['message']==null ? '' : json['message'].toString();
    text = json['text']==null ? '' : json['text'].toString();
    number = json['number']==null ? 0 : int.tryParse(json['number'].toString()) ?? 0;
    found = json['found'] as bool?;
    type = json['type']==null ? '' : json['type'].toString();
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['text'] = this.text;
    data['number'] = this.number;
    data['found'] = this.found;
    data['type'] = this.type;
    return data;
  }
}