class WeddingData {
  WeddingData._();

  static const brideName = 'Sreelakshmi';
  static const groomName = 'Harikrishnan';

  static final weddingDate = DateTime(2026, 11, 1, 10, 30);

  static const venueName = 'Kavitha Event Hub, Kedamangalam, North Paravur';
  static const venueAddress = 'Kavitha Event Hub, Kedamangalam, North Paravur, Ernakulam, Kerala, India';

  static const instagramReelUrl = 'https://www.instagram.com/reel/DYoa9yZNyT7/?stkn=bjlyaHVqanVrd2Vl';

  /// RSVP submissions are emailed here via FormSubmit (formsubmit.co).
  /// First submission requires clicking the activation link FormSubmit
  /// sends to this address.
  static const rsvpEmail = 'sreelakshmivm.snm18ce018@gmail.com';

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

  static const _sangeet = _Event(
    id: 'sangeet',
    title: 'Sangeet Night',
    date: 'October 29, 2026',
    time: '6:00 PM – 9:00 PM',
    location: 'Blue Waters Event Hub, Mattupuram (Mannam)',
    description: 'An evening of music, dance and celebrations.',
    mapsUrl: 'https://share.google/ZnLuiXPzkQ7hZEJOO',
  );

  static const _gulabi = _Event(
    id: 'gulabi',
    title: 'Gulabi',
    date: 'October 30, 2026',
    time: 'From 6:00 PM',
    location: 'At Home',
    description: 'Gulabi celebration at home.',
    mapsUrl: 'https://maps.app.goo.gl/kyUhb57N61oiy3V79?g_st=iw',
  );

  static const _thalikettu = _Event(
    id: 'thalikettu',
    title: 'Thalikettu',
    date: 'November 1, 2026',
    time: '9:00 AM – 9:30 AM',
    location: 'Peruvaram Mahadeva Temple, North Paravur',
    description: 'Thalikettu ceremony.',
    mapsUrl: 'https://www.google.com/maps/search/?api=1&query=Peruvaram+Mahadeva+Temple+North+Paravur',
  );

  static const _ceremony = _Event(
    id: 'ceremony',
    title: 'Wedding Ceremony',
    date: 'November 1, 2026',
    time: 'From 10:30 AM',
    location: 'Kavitha Event Hub, Kedamangalam, North Paravur',
    description: 'Wedding ceremony, with lunch to follow.',
    mapsUrl: 'https://maps.app.goo.gl/vf3Hf9FSe9ENsZRSA?g_st=iw',
  );

  static const _reception = _Event(
    id: 'reception',
    title: 'Reception',
    date: 'November 1, 2026',
    time: '6:30 PM – 9:00 PM',
    location: 'Ranganath Kalyanamandapam, North Paravur',
    description: 'Dinner and celebrations.',
    mapsUrl: 'https://maps.app.goo.gl/Fa4w1Lt3e9h9iKYT7',
  );

  /// Full event list — shown when no `?group=` link parameter is given.
  static const timelineEvents = [_sangeet, _gulabi, _thalikettu, _ceremony, _reception];

  /// Returns the event list to show for a given `?group=` URL parameter.
  /// - `sangeet` → Sangeet Night, Thalikettu, Wedding Ceremony
  /// - `gulabi` → Gulabi, Thalikettu, Wedding Ceremony
  /// - anything else / none → the full list
  static List<WeddingEvent> eventsForGroup(String? group) {
    switch (group) {
      case 'sangeet':
        return const [_sangeet, _thalikettu, _ceremony];
      case 'gulabi':
        return const [_gulabi, _thalikettu, _ceremony];
      default:
        return timelineEvents;
    }
  }
}

class _Event {
  const _Event({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.mapsUrl,
  });

  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final String mapsUrl;
}

typedef WeddingEvent = _Event;
