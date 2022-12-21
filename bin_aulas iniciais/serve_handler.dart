import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request req) {
      return Response(
        200,
        body: '<h1> Rota Inicial </h1>',
        headers: {
          'content-type': 'text/html',
        },
      );
    });

    // http://localhost:8080/query?nome=Bruno&idade=20
    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['idade'];
      return Response.ok('Query: [Nome: $nome, Idade: $idade]');
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];

      if (usuario == 'admin' && senha == '123') {
        Map result = {'token': 'token123', 'user_id': 1};
        String jsonResponse = jsonEncode(result);
        // usuario == admin && senha == 123
        return Response.ok(jsonResponse,
            headers: {'contet-type': 'application/json'});
      } else {
        // se não
        return Response.forbidden("Acesso negado");
      }

      /*
        {
      	"usuario":"admin",
      	"senha":"123"
        }
       */
    });

    return router;
  }
}
