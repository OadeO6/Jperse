part of jsonp;


bool isDigit(String chr) {
  final chrCode = chr.codeUnitAt(0);
  final startCode = '0'.codeUnitAt(0);
  final endCode = '9'.codeUnitAt(0);

  if (chrCode >= startCode && chrCode <= endCode) {
    return true;
  }
  return false;
}


bool isNumeric(String? str) {
  if (str == null || str.isEmpty) {
    return false;
  }

  return double.tryParse(str) != null;
}
