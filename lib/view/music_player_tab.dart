import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/consts/colors.dart';
import 'package:music_player/controller/consts/text_style.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/view/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayerTab extends StatelessWidget {
  final List <SongModel> data;
  const MusicPlayerTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgWhiteColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: yellowColor),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sort_rounded, color: yellowColor),
            ),
          ],
          //leading: const Icon(Icons.menu, color: yellowColor),
          title: Text(
            "Müzik Oynatıcı",
            style: myStyle(
              family: regular2,
              color: yellowColor,
              size: 24,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Obx(
                        () => ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: bgColor,
                      title: Text(
                        data[index].displayNameWOExt,
                        style: myStyle(family: bold, size: 15),
                      ),
                      subtitle: Text(
                        "${data[index].artist}",
                        style: myStyle(family: regular, size: 12),
                      ),
                      leading: QueryArtworkWidget(
                        id: data[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          color: whiteColor,
                          size: 32,
                        ),
                      ),
                      /*const Icon(
                              Icons.music_note,
                              color: whiteColor,
                              size: 32,
                            ),*/
                      trailing: controller.playIndex.value == index &&
                          controller.isPlaying.value
                          ? const Icon(Icons.play_arrow,
                          color: whiteColor, size: 26)
                          : null,
                      onTap: () {
                        //controller.playSong(snapshot.data![index].uri, index);
                        Get.to(
                              () => Player(
                            data: data,
                          ),
                          transition: Transition.downToUp,
                        );
                        controller.playSong(
                            data[index].uri, index);
                      },
                    ),
                  ),
                );
              }),
        )
              /*else if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                  "Hiç şarkı bulunamadı",

                  //"No song found",
                  style: myStyle(
                    color: yellowColor
                  ),
                ));
              } else {
                return
              }*/

    );
  }
}
