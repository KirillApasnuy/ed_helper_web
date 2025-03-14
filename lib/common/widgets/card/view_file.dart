import 'package:ed_helper_web/data/models/chat_message/chat_message.dart';
import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gif_view/gif_view.dart';
import 'package:iconsax/iconsax.dart';

class ViewFile extends StatefulWidget {
  final ChatMessage? message;
  final String? token;
  final String? media;

  const ViewFile({super.key, this.message, this.media, this.token});

  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile>
    with SingleTickerProviderStateMixin {
  bool isFullScreen = false;
  double _scale = 1.0;
  Offset _position = Offset.zero;
  bool _isPlaying = false;
  late GifController gifController;
  final String API_URL = dotenv.env['api_url']!;

  void toggleAnimation() {
    if (gifController.isPlaying) {
      gifController.pause();
    } else {
      gifController.play();
    }
    setState(() {
      _isPlaying = gifController.isPlaying;
    });
  }

  @override
  void initState() {
    super.initState();
    gifController = GifController();
  }

  Widget _buildImage() {
    if (widget.message != null && widget.message!.imageUrl != null) {
      return Image.network(
        "${API_URL}/v1/media/user/${widget.message!.imageUrl}",
        headers: {"Authorization": "Bearer ${widget.token}"},
      );
    } else if (widget.message != null && widget.message!.attachFile != null) {
      return Image.memory(
        widget.message!.attachFile!.bytes,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (!_isPlaying) {
            return child;
          }
          return child;
        },
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildGif() {
    return GestureDetector(
      onTap: toggleAnimation,
      child: Center(
        child: GifView.network(
          widget.media!,
          controller: gifController,
          autoPlay: false,
        ),
      ),
    );
  }

  // Сброс масштаба и позиции
  void _handleMouseWheel(PointerEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        // Изменяем масштаб в зависимости от направления прокрутки
        if (event.scrollDelta.dy > 0) {
          _scale = (_scale * 0.9).clamp(1.0, 4.0); // Уменьшение масштаба
        } else {
          _scale = (_scale * 1.1).clamp(1.0, 4.0); // Увеличение масштаба
        }
      });
    }
  }

  // Обработка перемещения изображения
  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _position += details.delta;
    });
  }

  // Сброс масштаба и позиции
  void _resetScaleAndPosition() {
    setState(() {
      _scale = 1.0;
      _position = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Listener(
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  _handleMouseWheel(event);
                }
              },
              child: GestureDetector(
                onDoubleTap: _resetScaleAndPosition, // Сброс масштаба и позиции по двойному нажатию
                onPanUpdate: _handlePanUpdate,
                child: Transform.scale(
                  scale: _scale,
                  child: Transform.translate(
                    offset: _position,
                    child: Center(
                      child: widget.media != null && widget.media!.endsWith('.gif')
                          ? _buildGif()
                          : Center(child: _buildImage()),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.cardBorder,
                  size: 40,
                ),
                color: Colors.black,
                focusColor: Colors.black,
                hoverColor: AppColors.cardBackground,
                splashColor: Colors.black,
              ),
            ),
            if (widget.media != null && widget.media!.endsWith('.gif'))
              Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: !_isPlaying,
                  child: IconButton(
                    color: const Color(0xff77ADED),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff77ADED),
                    ),
                    icon: SizedBox(
                      width: 100,
                      height: 100,
                      child: Icon(
                        _isPlaying
                            ? Iconsax.pause_circle5
                            : Iconsax.play_cricle5,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: toggleAnimation,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
