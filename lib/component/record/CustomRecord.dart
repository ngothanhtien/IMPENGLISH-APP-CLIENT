import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:record/record.dart' as rec;

class RecorderScreen extends StatefulWidget {
  const RecorderScreen({super.key});

  @override
  State<RecorderScreen> createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen>
    with SingleTickerProviderStateMixin {
  late final rec.AudioRecorder _recorder;
  bool _isRecording = false;
  String? _filePath;

  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  // Waveform mock
  final List<int> _waveform = List.filled(30, 5);
  Timer? _waveTimer;

  @override
  void initState() {
    super.initState();
    _recorder = rec.AudioRecorder();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  Future<void> _startRecording() async {
    if (await _recorder.hasPermission()) {
      // 🔥 chỉ định path lưu file
      final tempDir = "/sdcard/Download/record_${DateTime.now().millisecondsSinceEpoch}.m4a";

      await _recorder.start(
        rec.RecordConfig(
          encoder: rec.AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: tempDir,
      );

      setState(() {
        _isRecording = true;
        _filePath = null;
      });

      // Bắt đầu waveform mock
      _waveTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
        setState(() {
          _waveform.removeAt(0);
          _waveform.add(Random().nextInt(40) + 10);
        });
      });

      // Auto stop sau 5 giây
      Future.delayed(const Duration(seconds: 5), () async {
        if (_isRecording) {
          final path = await _recorder.stop();
          _waveTimer?.cancel();
          setState(() {
            _isRecording = false;
            _filePath = path; // ✅ giờ sẽ có path
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _animController.dispose();
    _waveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Mic button
            ScaleTransition(
              scale: _isRecording ? _scaleAnim : const AlwaysStoppedAnimation(1),
              child: ElevatedButton(
                onPressed: _isRecording ? null : _startRecording,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                  backgroundColor:
                  _isRecording ? Colors.redAccent : const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: Colors.black45,
                ),
                child: Icon(
                  _isRecording ? Icons.mic : Icons.mic_none,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Text trạng thái
            Text(
              _isRecording
                  ? "Recording... 🎙"
                  : _filePath != null
                  ? "Recording complete ✅"
                  : "Press to record",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5
              ),
            ),

            const SizedBox(height: 10),

            /// Card phân tích sau khi dừng
             _buildAnalysisCard(),
          ],
        ),
      );
  }

  /// Card phân tích (mock data)
  Widget _buildAnalysisCard() {
    return Container(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.black.withOpacity(0.15),
            width: 1.2
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("36%",
                  style: TextStyle(
                      color: const Color(0xFF4F46E5),
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      fontSize: 24
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Pronunciation Score",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                      fontSize: 16
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Clarity",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index){
                      final isActive = index < 3;
                      return Container(
                        height: 8,
                        width: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? Colors.lightGreenAccent : Colors.black.withOpacity(0.3)
                        ),
                      );
                    }),
                  )
                ],
              ),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Fluency",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index){
                      final isActive = index < 3;
                      return Container(
                        height: 8,
                        width: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive ? Colors.orange : Colors.black.withOpacity(0.3)
                        ),
                      );
                    }),
                  )
                ],
              ),
              SizedBox(height: 12,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Tip: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        )
                      ),
                      TextSpan(text: 'Try to emphasize the "dip" in "serendipity" for better pronunciation.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          letterSpacing: -0.5,
                          height: 1.4
                        )
                      )
                    ]
                  )
                )
              ),
              SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: (){},
                  icon: const Icon(Icons.restart_alt,size: 24,color: Colors.grey,),
                  label: const Text("Try again",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      letterSpacing: -0.2
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.black26,width: 1.2)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
