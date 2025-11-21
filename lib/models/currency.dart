class Currency {

  String? date;
  String? time;
  String? nameEn;
  String? nameFa;
  String? price;
  String? priceUnit;
  String? changePercent;

  Currency({
    required this.nameEn,
    required this.nameFa,
    required this.date,
    required this.time,
    required this.price,
    required this.priceUnit,
    required this.changePercent,
  });

}