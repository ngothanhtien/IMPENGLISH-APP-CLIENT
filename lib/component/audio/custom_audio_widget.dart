import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  final Color? activeColor;
  final Color? inactiveColor;
  final VoidCallback? onPlay;

  const AudioPlayerWidget({
    Key? key,
    required this.url,
    this.activeColor = const Color(0xFFEF4444),
    this.inactiveColor = const Color(0xFF4F46E5),
    this.onPlay
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;

  Future<String> _downloadAudio(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {"User-Agent": "Mozilla/5.0"}, // Server yêu cầu UA
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to download audio");
    }

    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/audio.mp3");

    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  Future<void> _togglePlay() async {
    if (widget.url.isEmpty) {
      AppSnackBar.showInfo(
          context, "We're sorry, there is no audio for this word.");
      return;
    }

    try {
      if (_isPlaying) {
        await _player.stop();
      } else {
        // 🔥 Tải file trước rồi phát
        final path = await _downloadAudio(widget.url);

        await _player.play(DeviceFileSource(path));
        //call de dem steps tai detail
        widget.onPlay?.call();
      }

      setState(() {
        _isPlaying = !_isPlaying;
      });
    } catch (e) {
      AppSnackBar.showError(context, "Audio failed: $e");
      print("AUDIO ERROR ===> $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _togglePlay,
      icon: Icon(
        _isPlaying ? Icons.stop : Icons.volume_up,
        size: 24,
        color: Colors.white,
      ),
      style: IconButton.styleFrom(
        backgroundColor:
        _isPlaying ? widget.activeColor : widget.inactiveColor,
      ),
    );
  }
}
