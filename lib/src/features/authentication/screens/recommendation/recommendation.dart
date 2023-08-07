import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
Future<void> _scanQRCode() async {
  try {
    String qrCodeResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", // Color for the scan button
      "Cancel", // Text for the cancel button
      true, // Enable flash
      ScanMode.QR, // Set the scan mode to QR code
    );

    if (qrCodeResult != '-1') {
      // Handle the scanned QR code result here
      print("Scanned QR code: $qrCodeResult");
      // You can use the scanned QR code result as needed, e.g., perform an action, navigate to a specific screen, etc.
    }
  } catch (e) {
    print("Error scanning QR code: $e");
  }
}
