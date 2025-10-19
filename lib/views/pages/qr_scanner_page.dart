import 'package:flutter/material.dart';
import 'package:lodz_trash_bin/views/pages/dispose_session_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isScanning = true;
  String? scannedData;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isScanning = true;
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isScanning && capture.barcodes.isNotEmpty) {
      final String? code = capture.barcodes.first.rawValue;
      if (code == "F6D4dUaiQ8Ree8f1yQuaVxgk2t23") {
        setState(() {
          scannedData = code;
          _isScanning = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisposeSessionPage(binId: scannedData!),
            ),
          ).then((_) {
            setState(() {
              _isScanning = true;
            });
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final overlaySize = screenWidth * 0.7;

    final double squareTopOffset = 150.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(controller: cameraController, onDetect: _onDetect),
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: ScannerOverlayPainter(
              overlaySize: overlaySize,
              squareTopOffset: squareTopOffset,
            ),
          ),
          Positioned(
            top: squareTopOffset + overlaySize + 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  'Odskanuj QR śmietnika',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Umieść kod QR wewnątrz ramki',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final double overlaySize;
  final double borderRadius;
  final double squareTopOffset;

  ScannerOverlayPainter({
    required this.overlaySize,
    this.borderRadius = 20,
    this.squareTopOffset = 150.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        (size.width - overlaySize) / 2,
        squareTopOffset,
        overlaySize,
        overlaySize,
      ),
      Radius.circular(borderRadius),
    );

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(rRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = const Color.fromARGB(255, 213, 213, 213)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final double borderOffset = 8.0;
    final RRect borderRRect = rRect.inflate(borderOffset);
    drawDashedRRect(canvas, borderRRect, borderPaint, 25, 5);
  }

  void drawDashedRRect(
    Canvas canvas,
    RRect rRect,
    Paint paint,
    double dashWidth,
    double dashSpace,
  ) {
    final path = Path()..addRRect(rRect);
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        final extractPath = metric.extractPath(
          distance,
          next.clamp(0.0, metric.length),
        );
        canvas.drawPath(extractPath, paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
