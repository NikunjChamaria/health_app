class LabTestsModel {
  int? id;
  int? tests;
  int? discountedPrice;
  int? price;
  String? name;

  LabTestsModel({this.tests, this.discountedPrice, this.price, this.name});

  LabTestsModel.fromJson(Map<String, dynamic> json) {
    tests = json['tests'];
    discountedPrice = json['discountedPrice'];
    price = json['price'];
    name = json['name'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tests'] = tests;
    data['discountedPrice'] = discountedPrice;
    data['price'] = price;
    data['name'] = name;
    data['_id'] = id;
    return data;
  }
}
