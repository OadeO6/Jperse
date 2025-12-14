import 'package:dart/jsonp.dart' as dart;

// String testFile = '../tests/step1/valid.json';
String testFile = '../tests/step1/valid.json';

void main(List<String> arguments) {
  dart.parse(testFile);
}
