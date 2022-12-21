import 'package:shelf/shelf_io.dart' as shelf_io;

import 'serve_handler.dart';

void main(List<String> arguments) async {
  var serve = ServeHandler();
  final server = await shelf_io.serve(
      (request) => serve.handler.call(request), '127.0.0.1', 8080);

  print('Server aberto em: http://localhost:8080');
}
