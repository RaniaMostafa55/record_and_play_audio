import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_and_play_audio_app/widgets/global_button.dart';
import 'package:record_and_play_audio_app/widgets/message.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isRecording = false;
  bool isPlaying = false;
  late PermissionStatus micPermission;
  String? recordPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recorder"),
        backgroundColor: const Color.fromARGB(255, 152, 67, 231),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //recording button
            GlobalButton(
              icon: Icons.mic,
              onPressed: () async {
                //if it's already recording, then stop it
                if (isRecording) {
                  await recorder.stopRecorder();
                  await recorder.closeRecorder();
                  isRecording = false;
                  setState(() {});
                } else {
                  micPermission = await Permission.microphone.request();
                  setState(() {});
                  //if it's not playing audio and mic permission is granted, then it will record
                  if (!isPlaying && micPermission.isGranted) {
                    await recorder.openRecorder();
                    recordPath = '${Directory.systemTemp.path}/my_record.aac';
                    await recorder.startRecorder(
                        toFile: recordPath, codec: Codec.aacADTS);
                    isRecording = true;
                    setState(() {});
                  }
                }
              },
            ),
            if (isRecording) ...{
              SizedBox(
                height: 10,
              ),
              Message(content: "Recording..")
            },
            SizedBox(height: 20),
            //playing button
            GlobalButton(
              icon: Icons.play_arrow,
              onPressed: () async {
                //if an audio is already playing, then stop it
                if (isPlaying) {
                  await player.stopPlayer();
                  await player.closePlayer();
                  isPlaying = false;
                  setState(() {});
                } else {
                  //if it's not recording, then play the saved audio
                  if (!isRecording) {
                    await player.openPlayer();
                    if (recordPath != null) {
                      await player.startPlayer(fromURI: recordPath);
                      isPlaying = true;
                      setState(() {});
                    }
                  }
                }
              },
            ),
            if (isPlaying) ...{
              SizedBox(
                height: 10,
              ),
              Message(
                content: "Playing..",
              )
            },
          ],
        ),
      ),
    );
  }
}
