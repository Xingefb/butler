class SelectPlugin extends Object {
  var stock_code; 
  var stock_code2; 
  var name;
  var today_open; 
  var yesterday_close; 
  var current_prices; 
  var today_highest_price;
  var today_lowest_price; 
  var toIn1_j; 
  var out1_j;
  var traded_num; 
  var traded_amount; 
  var toIn1_apply_num; 
  var toIn1; 
  var toIn2_apply_num; 
  var toIn2;
  var toIn3_apply_num; 
  var toIn3; 
  var toIn4_apply_num; 
  var toIn4;
  var toIn5_apply_num; 
  var toIn5; 
  var out1_apply_num; 
  var out1; 
  var out2_apply_num; 
  var out2; 
  var out3_apply_num; 
  var out3; 
  var out4_apply_num; 
  var out4; 
  var out5_apply_num; 
  var out5;
  var date; 
  var time; 
  double gains;

  @override
  String toString() {
    return 'Stock{stock_code: $stock_code, stock_code2: $stock_code2, name: $name, today_open: $today_open, yesterday_close: $yesterday_close, current_prices: $current_prices, today_highest_price: $today_highest_price, today_lowest_price: $today_lowest_price, toIn1_j: $toIn1_j, out1_j: $out1_j, traded_num: $traded_num, traded_amount: $traded_amount, toIn1_apply_num: $toIn1_apply_num, toIn1: $toIn1, toIn2_apply_num: $toIn2_apply_num, toIn2: $toIn2, toIn3_apply_num: $toIn3_apply_num, toIn3: $toIn3, toIn4_apply_num: $toIn4_apply_num, toIn4: $toIn4, toIn5_apply_num: $toIn5_apply_num, toIn5: $toIn5, out1_apply_num: $out1_apply_num, out1: $out1, out2_apply_num: $out2_apply_num, out2: $out2, out3_apply_num: $out3_apply_num, out3: $out3, out4_apply_num: $out4_apply_num, out4: $out4, out5_apply_num: $out5_apply_num, out5: $out5, date: $date, time: $time, gains: $gains}';
  } 
}


SelectPlugin ConfigPlugin(String str, SelectPlugin model) {
  int start = str.indexOf("\"") + 1;
  int end = str.indexOf("\"", start);
  model.stock_code2 = str.substring(str.indexOf("str_") + 4, start - 2);
  model.stock_code = str.substring(str.indexOf("str_") + 6, start - 2);
  String stock_str = str.substring(start, end);
  List stock_item = stock_str.split(",");
  model.name = stock_item[0];
  model.today_open = stock_item[1];
  model.yesterday_close = stock_item[2];
  model.current_prices = stock_item[3];
  model.today_highest_price = stock_item[4];
  model.today_lowest_price = stock_item[5];
  model.toIn1_j = stock_item[6];
  model.out1_j = stock_item[7];
  model.traded_num = stock_item[8];
  model.traded_amount = stock_item[9];
  model.toIn1_apply_num = stock_item[10];
  model.toIn1 = stock_item[11];
  model.toIn2_apply_num = stock_item[12];
  model.toIn2 = stock_item[13];
  model.toIn3_apply_num = stock_item[14];
  model.toIn3 = stock_item[15];
  model.toIn4_apply_num = stock_item[16];
  model.toIn4 = stock_item[17];
  model.toIn5_apply_num = stock_item[18];
  model.toIn5 = stock_item[19];
  model.out1_apply_num = stock_item[20];
  model.out1 = stock_item[21];
  model.out2_apply_num = stock_item[22];
  model.out2 = stock_item[23];
  model.out3_apply_num = stock_item[24];
  model.out3 = stock_item[25];
  model.out4_apply_num = stock_item[26];
  model.out4 = stock_item[27];
  model.out5_apply_num = stock_item[28];
  model.out5 = stock_item[29];
  model.date = stock_item[30];
  model.time = stock_item[31];
  return model;
}