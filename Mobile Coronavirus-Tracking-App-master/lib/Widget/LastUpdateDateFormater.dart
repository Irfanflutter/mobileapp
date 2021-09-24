
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class LastUpdateDateFormater {
  
   LastUpdateDateFormater({@required this.lastupdatedDate});
  final DateTime lastupdatedDate;

 String lastUpdatedStatusText() {
   if(lastupdatedDate!=null) {
     final formatter = DateFormat.yMd().add_Hms();
     final formated= formatter.format(lastupdatedDate);
     return "Last Updated:  $formated";
   } 
   return " ";
 }

}