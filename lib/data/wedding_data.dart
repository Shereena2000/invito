class WeddingData {
  WeddingData._();

  static const brideName = 'Sreelakshmi';
  static const groomName = 'Harikrishnan';

  static final weddingDate = DateTime(2026, 11, 1, 10, 30);

  static const venueName = 'Kavitha Event Hub, Kedamangalam, North Paravur';
  static const venueAddress = 'Kavitha Event Hub, Kedamangalam, North Paravur, Ernakulam, Kerala, India';

  static const instagramReelUrl = 'https://www.instagram.com/reel/DYoa9yZNyT7/?stkn=bjlyaHVqanVrd2Vl';

  static const heroImage = 'assets/images/hero.jpeg';

  static const storyImage = 'assets/images/story.jpeg';

  static const ceremonyImage = 'assets/images/ceremony.jpg';

  static const galleryImages = [
    'assets/images/gallery_1.jpeg',
    'assets/images/gallery_2.jpeg',
    'assets/images/gallery_3.jpeg',
    'assets/images/hero.jpeg',
    'assets/images/story.jpeg',
    'assets/images/ceremony.jpg',
  ];

  static const timelineEvents = [
    _Event(
      title: 'Sangeet Night',
      date: 'October 29, 2026',
      time: '6:00 PM – 9:00 PM',
      location: 'Blue Waters Event Hub, Mattupuram (Mannam)',
      description: 'An evening of music, dance and celebrations.',
      mapsUrl: 'https://share.google/ZnLuiXPzkQ7hZEJOO',
    ),
    _Event(
      title: 'Gulabi',
      date: 'October 30, 2026',
      time: '6:00 PM – 9:00 PM',
      location: 'At Home',
      description: 'Gulabi celebration at home.',
      mapsUrl: 'https://maps.app.goo.gl/kyUhb57N61oiy3V79?g_st=iw',
    ),
    _Event(
      title: 'Thalikettu',
      date: 'November 1, 2026',
      time: '9:00 AM – 9:30 AM',
      location: 'Peruvaram Mahadeva Temple, North Paravur',
      description: 'Thalikettu ceremony.',
      mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Peruvaram+Mahadeva+Temple+North+Paravur',
    ),
    _Event(
      title: 'Wedding Ceremony',
      date: 'November 1, 2026',
      time: '10:30 AM – 1:30 PM',
      location: 'Kavitha Event Hub, Kedamangalam, North Paravur',
      description: 'Wedding ceremony, with lunch to follow.',
      mapsUrl: 'https://maps.app.goo.gl/vf3Hf9FSe9ENsZRSA?g_st=iw',
    ),
    _Event(
      title: 'Reception',
      date: 'November 1, 2026',
      time: '6:30 PM – 9:00 PM',
      location: 'Ranganath Kalyanamandapam, North Paravur',
      description: 'Dinner and celebrations.',
      mapsUrl: 'https://maps.app.goo.gl/Fa4w1Lt3e9h9iKYT7',
    ),
  ];
}

class _Event {
  const _Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.mapsUrl,
  });

  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String mapsUrl;
}

typedef WeddingEvent = _Event;
