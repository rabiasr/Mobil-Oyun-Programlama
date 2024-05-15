import 'package:flutter/material.dart';

class ChannelCard extends StatelessWidget {
  const ChannelCard({
    Key? key,
    required this.ad,
    required this.durum,
    
    required this.onPressed,
  }) : super(key: key);

  final String ad;
  final String durum;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: double.infinity, // Kartın genişliğini belirle
          height: 100, // Kartın yüksekliğini belirle
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ad,
                          maxLines: 2, // Başlık maksimum 2 satırda gösterilecek
                          overflow: TextOverflow
                              .ellipsis, // Başlık taşma durumunda ...
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                       Text(
                          'Durumu: $durum',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
