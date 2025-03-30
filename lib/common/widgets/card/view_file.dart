import 'package:ed_helper_web/data/models/chat_message/chat_message.dart';
import 'package:ed_helper_web/util/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gif_view/gif_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:photo_view/photo_view.dart'; // Для изображений
import 'package:flutter/services.dart'; // Для обработки клавиш

class ViewFile extends StatefulWidget {
  final ChatMessage? message;
  final String? token;
  final String? media;

  const ViewFile({super.key, this.message, this.media, this.token});

  @override
  State<ViewFile> createState() => _ViewFileState();
}

class _ViewFileState extends State<ViewFile> with SingleTickerProviderStateMixin {
  bool isFullScreen = false;
  bool _isPlaying = false;
  late GifController gifController;
  final String API_URL = dotenv.env['api_url']!;

  // Масштабирование для GIF
  double _gifScale = 1.0;
  final TransformationController _transformationController = TransformationController();

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

  // Обработка масштабирования колесом мыши
  void _handleMouseWheel(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      setState(() {
        if (event.scrollDelta.dy > 0) {
          _gifScale = (_gifScale * 0.9).clamp(0.5, 4.0); // Уменьшение масштаба
        } else {
          _gifScale = (_gifScale * 1.1).clamp(0.5, 4.0); // Увеличение масштаба
        }
        _transformationController.value = Matrix4.identity()..scale(_gifScale);
      });
    }
  }

  // Сброс масштаба
  void _resetScale() {
    setState(() {
      _gifScale = 1.0;
      _transformationController.value = Matrix4.identity();
    });
  }

  Widget _buildImage() {
    if (widget.message != null && widget.message!.imageUrl != null) {
      return PhotoView(
        imageProvider: NetworkImage(
          "${API_URL}/v1/media/user/${widget.message!.imageUrl}",
          headers: {"Authorization": "Bearer ${widget.token}"},
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        backgroundDecoration: const BoxDecoration(color: Colors.transparent),
      );
    } else if (widget.message != null && widget.message!.attachFile != null) {
      return PhotoView(
        imageProvider: MemoryImage(widget.message!.attachFile!.bytes),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
        backgroundDecoration: const BoxDecoration(color: Colors.transparent),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildGif() {
    return Listener(
      onPointerSignal: _handleMouseWheel, // Обработка колеса мыши
      child: GestureDetector(
        onDoubleTap: _resetScale, // Сброс масштаба по двойному нажатию
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: 0.5,
          maxScale: 4.0,
          child: Center(
            child: GifView.network(
              widget.media!,
              controller: gifController,
              autoPlay: false,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            // Отображение GIF или изображения
            if (widget.media != null && widget.media!.endsWith('.gif'))
              _buildGif()
            else
              _buildImage(),

            // Кнопка закрытия
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
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

            // Кнопка воспроизведения/паузы для GIF
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
                      width: screenWidth < 600 ? 35 : 100,
                      height: screenWidth < 600 ? 35 : 100,
                      child: Icon(
                        _isPlaying ? Iconsax.pause_circle5 : Iconsax.play_cricle5,
                        size: screenWidth < 600 ? 30 : 80,
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