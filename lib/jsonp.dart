library jsonp;
import 'dart:io' as io;
// import 'dart:developer' show log;

part 'lexer.dart';
part 'parser.dart';
part 'type.dart';
part 'stack.dart';


void parse(String file) async {
  String? data = await loadFile(file);
  print(lexer(data));
  print(parser(lexer(data)));
  print("hello");
  return;
}

Future<String> loadFile(String file) async {
  final io.File f = io.File(file);
  try {
    return await f.readAsString();
  } on io.FileSystemException catch (_) {
    io.stderr.writeln('File ${f.absolute.path} does not exist.');
    return "";
  }
}
