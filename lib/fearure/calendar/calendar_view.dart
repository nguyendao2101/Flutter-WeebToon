import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/fearure/calendar/calendar_controller.dart';
import 'package:untitled/fearure/manga_detail/manga_detai_agruments.dart';
import 'package:untitled/images/image_extension.dart';
import 'package:untitled/router/router.dart';
import 'package:untitled/themes/app_theme.dart';
import 'package:untitled/themes/theme_controller.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final _scrollController = ScrollController();
  final controller = Get.find<CalendarController>();

  @override
  void initState() {
    super.initState();
    controller.getListUpdateTodayManga();
    controller.getListUpdateNewManga();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final themeData = themeController.themeData;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          // elevation: 0.0,
          title: Column(
            children: [
              _textAndIconAppbar(),
              _appbarDay(),
            ],
          ),
        ),
        body: Obx(
          () => Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: SafeArea(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await Future.wait([
                            controller.getListUpdateTodayManga(),
                            controller.getListUpdateNewManga(),
                          ]);
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _changeTheme(themeController, themeData),
                                const SizedBox(height: 10),
                                _updateToday(),
                                const SizedBox(height: 10),
                                _pictureIntro(),
                                const SizedBox(height: 4),
                                _previouslyUpdated(),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx _previouslyUpdated() {
    return Obx(
      () => controller.getListUpdateNewMangaStatus.value ==
              GetListUpdateNewMangaStatus.isLoading
          ? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Số lượng mục trên mỗi hàng
                    crossAxisSpacing:
                        10.0, // Khoảng cách giữa các mục theo trục ngang
                    mainAxisSpacing:
                        10.0, // Khoảng cách giữa các mục theo trục dọc
                    childAspectRatio:
                        0.75, // Tỉ lệ khung hình của các mục (chiều rộng / chiều cao)
                  ),
                  itemCount: controller.listUpdateNewManga.length,
                  itemBuilder: (context, index) {
                    final item = controller.listUpdateNewManga[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRouterName.mangaDetail,
                            arguments: MangaDetailAgruments(id: item.id));
                      },
                      child: Column(children: [
                        Expanded(
                            child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                child: Image.network(
                                  controller
                                      .listUpdateNewManga[index].coverMobileUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(8.0))),
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ))
                      ]),
                    );
                  }),
            ),
    );
  }

  Container _pictureIntro() {
    return Container(
      height: 70,
      color: const Color(0xff000000),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: [
              Image.asset(
                ImageAssest.book1,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Obx _updateToday() {
    return Obx(
      () => controller.getListUpdateTodayMangaStatus.value ==
              GetListUpdateTodayMangaStatus.isLoading
          ? const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Số lượng mục trên mỗi hàng
                    crossAxisSpacing:
                        10.0, // Khoảng cách giữa các mục theo trục ngang
                    mainAxisSpacing:
                        10.0, // Khoảng cách giữa các mục theo trục dọc
                    childAspectRatio:
                        0.75, // Tỉ lệ khung hình của các mục (chiều rộng / chiều cao)
                  ),
                  itemCount: controller.listUpdateTodayManga.length,
                  itemBuilder: (context, index) {
                    final item = controller.listUpdateTodayManga[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRouterName.mangaDetail,
                            arguments: MangaDetailAgruments(id: item.id));
                      },
                      child: Column(children: [
                        Expanded(
                            child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                child: Image.network(
                                  controller.listUpdateTodayManga[index]
                                      .coverMobileUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(8.0))),
                                child: Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ))
                      ]),
                    );
                  }),
            ),
    );
  }

  Padding _changeTheme(
      ThemeController themeController, Rx<AppTheme> themeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              themeController.changeTheme();
            },
            child: Text(
              "Change Theme",
              style: themeData.value.text.h14,
            ),
          ),
        ],
      ),
    );
  }

  Container _appbarDay() {
    return Container(
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.4, color: Color(0xFFCFC6C6)),
          bottom: BorderSide(width: 0.2, color: Color(0xFF5F5B5B)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: buildDayText('Mon')),
          Expanded(child: buildDayText('Tue')),
          Expanded(child: buildDayText('Wed')),
          Expanded(child: buildDayText('Thu')),
          Expanded(child: buildDayText('Fri')),
          Expanded(child: buildDayText('Sat')),
          Expanded(child: buildDayText('Sun')),
        ],
      ),
    );
  }

  Row _textAndIconAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Text(
              'Daily',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              ' | Genres',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.emoji_events,
                size: 30,
              ),
              onPressed: () {},
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(AppRouterName.search);
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildDayText(String day) {
    final now = DateTime.now();
    final dayFormatter = DateFormat('E');
    final String today = dayFormatter.format(now);

    const TextStyle boldStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    );

    return Text(
      day,
      style: TextStyle(
        fontSize: 20,
        color: day == today
            ? boldStyle.color
            : Colors
                .grey, // Tô màu xanh cho ngày hiện tại và đen cho các ngày khác
        fontWeight: day == today
            ? boldStyle.fontWeight
            : FontWeight
                .normal, // Sử dụng font weight đậm cho ngày hiện tại và font weight bình thường cho các ngày khác
      ),
    );
  }
}
