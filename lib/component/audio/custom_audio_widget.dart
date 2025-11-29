import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:learning_app_client/component/topsnackbar/showTopSnackBar.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  final Color? activeColor;   // màu khi đang phát
  final Color? inactiveColor; // màu khi không phát

  const AudioPlayerWidget({
    Key? key,
    required this.url,
    this.activeColor = const Color(0xFFEF4444),
    this.inactiveColor = const Color(0xFF4F46E5)
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Future<void> _togglePlay() async {
    if(widget.url.isEmpty){
      AppSnackBar.showInfo(context, "We're really sorry. There are currently no audio tracks with this word.");
      return;
    }
    if (_isPlaying) {
      await _player.stop();
    } else {
      await _player.play(UrlSource(widget.url));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _player.dispose(); // tránh rò rỉ bộ nhớ
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
        backgroundColor: _isPlaying ? widget.activeColor : widget.inactiveColor,
      ),
    );
  }
}
