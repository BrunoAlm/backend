// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';

class BlogApi {
  final GenericService<NoticiaModel> _service;
  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    // listagem
    router.get('/blog/noticias', (Request req) {
      List<NoticiaModel> noticias = _service.findAll();
      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();

      return Response.ok(jsonEncode(noticiasMap));
    });

    // nova noticia
    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(NoticiaModel.fromJson(jsonDecode(body)));
      return Response(201);
    });

    // /blog/noticias?id=1  // update
    router.put('/blog/noticias', (Request req) {
      // _service.save();
      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje, alegria');
    });

    // /blog/noticias?id=1  // delete
    router.delete('/blog/noticias', (Request req) {
      // _service.delete(1);
      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje, alegria');
    });

    return router;
  }
}
