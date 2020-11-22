import 'package:intl/intl.dart';

class DocumentIDs {
  String getNewDocumentID() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMddHHmmss');
    return formatter.format(now) + now.millisecond.toString().padLeft(5, '0');
  }
}
