// ignore: file_names
//title,date,source_url,location,description

// ignore_for_file: non_constant_identifier_names, file_names, duplicate_ignore

//format (m['notes'][0][0]);
class Story {
  final String title;
  // final String mediaType;
  final String description;
  final String event_date;
  final String targeted_person;
  final String date_submitted;
  final String status;
  final String featured_image;
  final dynamic author;
  final dynamic locationName;
  final dynamic lat;
  final dynamic lng;
  final dynamic gallery;
  final dynamic anonymous;
  final dynamic link;
  // final dynamic video;
  // final dynamic audio;

  //final Map<String media type, String file> content

  Story(
      this.title,
      this.description,
      this.date_submitted,
      this.event_date,
      this.gallery,
      this.targeted_person,
      this.status,
      this.featured_image,
      this.author,
      this.locationName,
      this.lat,
      this.lng,
      this.anonymous,
      this.link);

  Story.fromJson(Map<String, dynamic> json)
      : title = json['title']['rendered'],
        description = json['content']['rendered'],
        date_submitted = json['date_gmt'],
        event_date = json['acf']['event_date'],
        gallery = json['acf']['gallery'],
        anonymous = json['acf']['anonymous'],
        targeted_person = json['acf']['targeted_person'],
        link = json['link'],
        status = json['status'],
        featured_image = json['better_featured_image']['source_url'],
        author = json['author'],
        locationName = json['acf']['map_location']['name'],
        lat = json['acf']['map_location']['lat'],
        lng = json['acf']['map_location']['lng'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date_submitted': date_submitted,
        'event_date': event_date,
        'gallery': gallery,
        'anonymous': anonymous,
        'targeted_person': targeted_person,
        'link': link,
        'featured_image': featured_image,
        'author': author,
        'locationName': locationName,
        'lat': lat,
        'lng': lng,
      };
}
