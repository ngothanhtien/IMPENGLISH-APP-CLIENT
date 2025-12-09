import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learning_app_client/component/widgets/progress_indicator_widget.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class RecorderCustom extends StatefulWidget {
  final String word;
  final String pronouciation;
  final VoidCallback? onRecordingComplete;
  const RecorderCustom({
    super.key,
    required this.word,
    required this.pronouciation,
    this.onRecordingComplete
  });

  @override
  State<RecorderCustom> createState() => _RecorderCustom();
}

class _RecorderCustom extends State<RecorderCustom>
    with SingleTickerProviderStateMixin {
  late AudioRecorder _recorder;
  late AudioPlayer _player;

  bool _isRecording = false;
  bool _isPlaying = false;
  String? _audioPath;

  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  final List<int> _waveform = List.filled(30, 5);
  Timer? _waveTimer;
  StreamSubscription<RecordState>? _recordStateSubscription;

  @override
  void initState() {
    super.initState();
    _recorder = AudioRecorder();
    _player = AudioPlayer();

    _initRecorder();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    // Listen to player state
    _player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        setState(() => _isPlaying = false);
      }
    });
  }

  Future<void> _initRecorder() async {
    // Request microphone permission
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Microphone permission not granted');
    }
  }

  Future<void> _startRecording() async {
    try {
      // Check permission
      if (await _recorder.hasPermission()) {
        final dir = await getTemporaryDirectory();
        final path = '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

        // Start recording
        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: path,
        );

        setState(() {
          _isRecording = true;
          _audioPath = null;
        });

        // Animate waveform
        _waveTimer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
          if (mounted) {
            setState(() {
              _waveform.removeAt(0);
              _waveform.add(Random().nextInt(50) + 5);
            });
          }
        });
        // Auto stop after 10 seconds
        Future.delayed(const Duration(seconds: 10), () async {
          if (_isRecording) {
            await _stopRecording();
          }
        });
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _recorder.stop();
      _waveTimer?.cancel();
      setState(() {
        _isRecording = false;
        _audioPath = path;
        _waveform.fillRange(0, _waveform.length, 5);
      });
      widget.onRecordingComplete?.call();
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> _playAudio() async {
    if (_audioPath == null) return;

    try {
      setState(() => _isPlaying = true);
      await _player.play(DeviceFileSource(_audioPath!));
    } catch (e) {
      debugPrint('Error playing audio: $e');
      setState(() => _isPlaying = false);
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _player.stop();
      setState(() => _isPlaying = false);
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    _animController.dispose();
    _waveTimer?.cancel();
    _recordStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildWaveform(),
            const SizedBox(height: 24),
            // Record Button
            ScaleTransition(
              scale: _isRecording ? _scaleAnim : const AlwaysStoppedAnimation(1),
              child: ElevatedButton(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(24),
                  backgroundColor:
                  _isRecording ? Colors.redAccent : const Color(0xFF4F46E5),
                ),
                child: Icon(
                  _isRecording ? Icons.stop : Icons.mic_none,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
      
            const SizedBox(height: 12),
      
            Text(
              _isRecording
                  ? "Recording..."
                  : (_audioPath != null ? "Recording finished" : "Tap to practice"),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                letterSpacing: -0.3,
                height: 1.5
              ),
            ),
      
            const SizedBox(height: 24),
      
            if (_audioPath != null) cardScorePronunciation(widget.pronouciation,widget.word),
          ],
        ),
    );
  }

  Widget _buildWaveform() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _waveform.map((value) {
          return AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 4,
            transformAlignment: AlignmentGeometry.xy(2, 0),
            height: value.toDouble(),
            decoration: BoxDecoration(
              color: _isRecording ? Colors.redAccent : Colors.blueGrey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget cardScorePronunciation(String pro, String word) {

    List<String> chars = pro.runes.map((e) => String.fromCharCode(e)).toList();
    List<Map<String, dynamic>> phonemes = [];

    int i = 0;

    while (i < chars.length) {
      String c = chars[i];

      // Nếu là dấu nhấn ' hoặc ˈ → gom + 2 ký tự sau
      if (c == "'" || c == "ˈ") {
        // kiểm tra không bị vượt mảng
        String next1 = (i + 1 < chars.length) ? chars[i + 1] : "";
        String next2 = (i + 2 < chars.length) ? chars[i + 2] : "";

        phonemes.add({
          'value': c + next1 + next2,
          'isError': true,
        });

        i += 3; // nhảy qua 3 ký tự
        continue;
      }

      // bình thường → add 1 ký tự
      phonemes.add({
        'value': c,
        'isError': false,
      });

      i++;
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.graphic_eq_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Your Pronunciation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Score with progress bar
          _buildScoreItem(
            label: 'Overall Score',
            value: '72',
            maxValue: 100,
            icon: Icons.assessment_rounded,
          ),

          const SizedBox(height: 16),

          // Confidence with progress bar
          _buildScoreItem(
            label: 'Confidence',
            value: '82',
            maxValue: 100,
            icon: Icons.trending_up_rounded,
            suffix: '%',
          ),

          const SizedBox(height: 16),

          // Accent errors section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Color(0xFFEF4444),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Accent Issues',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (var p in phonemes)
                          _buildPhonemeChip(p['value'], p['isError']),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Tip section with improved design
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFDEF7EC),
                  const Color(0xFFD1FAE5),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.lightbulb_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pro Tip',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF065F46),
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Color(0xFF047857),
                            fontSize: 14,
                            height: 1.5,
                            letterSpacing: -0.2,
                          ),
                          children: [
                            TextSpan(
                              text: 'Practice the sound by opening your mouth wider. Try saying '
                            ),
                            TextSpan(
                              text: word,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15
                              )
                            ),
                            TextSpan(
                              text: " slowly and focus on the vowel sound."
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isPlaying ? _stopAudio : _playAudio,
                  icon: Icon(
                      _isPlaying ? Icons.stop : Icons.play_arrow
                      , size: 20),
                  label: Text(_isPlaying ? "Stop" : "Listen"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F46E5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _audioPath = null;
                      _isPlaying = false;
                    });
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 20),
                  label: const Text('Try Again'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4F46E5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(
                      color: Color(0xFF4F46E5),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem({
    required String label,
    required String value,
    required int maxValue,
    required IconData icon,
    String suffix = '',
  }) {
    final numValue = int.tryParse(value) ?? 0;
    final progress = numValue / maxValue;
    final Color color = numValue > 80 ?  Color(0xFF10B981):
    numValue > 50 ? Color(0xF4F66F00) :  Color(0xE0C80606);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: const Color(0xFF64748B),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              '$value$suffix',
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ProgressIndicatorWidget(
          progress: progress,
          color: color,
          height: 6,
        )
      ],
    );
  }

  Widget _buildPhonemeChip(
      String phoneme,
      bool isError
    ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isError ?const Color(0xFFFEF2F2) : const Color(0xFFDEF7EC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? const Color(0xFFFECACA)
          :const Color(0xFF10B981).withValues(alpha: 0.2),
          width: isError ? 1.5 : 1,
        ),
      ),
      child: Text(
        phoneme,
        style: TextStyle(
          fontSize: isError ? 15 : 13,
          color: isError ? Color(0xFFDC2626)
          :const Color(0xFF10B981),
          fontWeight: isError ? FontWeight.w700 : FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
