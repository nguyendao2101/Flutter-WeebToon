import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:untitled/models/manga_detail/manga_detail_response.dart';
import 'package:untitled/network/config/configs.dart';

part 'detail_manga_retrofit.g.dart';

@RestApi(baseUrl: Constants.BASE_URL)
abstract class DetailMangaApiRetrofit {
  factory DetailMangaApiRetrofit(Dio dio, {String baseUrl}) =
      _DetailMangaApiRetrofit;

  @GET('/mangas/{id}')
  Future<GetDetailManga> getDetailManga(@Path() String id);
}
