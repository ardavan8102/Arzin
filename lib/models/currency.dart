class Currency {
  final String symbol;
  final String nameEn;
  final String nameFa;
  final String date;
  final String time;
  final String price;
  final String priceUnit;
  final String changePercent;

  Currency({
    required this.symbol,
    required this.nameEn,
    required this.nameFa,
    required this.date,
    required this.time,
    required this.price,
    required this.priceUnit,
    required this.changePercent,
  });

  factory Currency.empty() => Currency(
    symbol: '',
    nameEn: '',
    nameFa: '',
    date: '',
    time: '',
    price: '',
    priceUnit: '',
    changePercent: '',
  );

  @override
  String toString() => 'Currency(symbol: $symbol, price: $price)';
}