import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:untitled/models/home_models/get_list_top_manga_home_response.dart';
import 'package:untitled/network/config/configs.dart';

part 'get_list_top_seris.g.dart';

@RestApi(baseUrl: Constants.BASE_URL)
abstract class HomeApiListTopSeriRetrofit {
  factory HomeApiListTopSeriRetrofit(Dio dio, {String baseUrl}) =
      _HomeApiListTopSeriRetrofit;
  @GET("/mangas/top")
  Future<GetListTopMangaHomeResponse> getListTopSeriManga({
    @Query('duration') String type = "week",
    @Query('page') String page = "10",
    @Query('per_page') String perPage = "20",
  });
}
