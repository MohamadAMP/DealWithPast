// ignore: file_names
//title,date,source_url,location,description

// ignore_for_file: non_constant_identifier_names, file_names, duplicate_ignore

//format (m['notes'][0][0]);
class Story {
  final String title;
  // final String mediaType;
  final String description;
  final String event_date;
  // final String source_url;
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
      // this.mediaType,
      // this.source_url,
      this.description,
      this.date_submitted,
      this.event_date,
      this.gallery,
      // this.video,
      // this.audio,
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
        // mediaType = json['acf']['audio']['type'],
        // source_url = json['acf']['audio']['url'],
        description = json['content']['rendered'],
        date_submitted = json['date_gmt'],
        event_date = json['date'],
        // event_date = json['acf']['event_date'],
        gallery = json['acf']['gallery'],
        anonymous = json['acf']['anonymous'],
        // video = json['acf']['video'],
        // audio = json['acf']['audio'],
        link = json['link'],
        status = json['status'],
        featured_image = json['better_featured_image']['source_url'],
        author = json['author'],
        locationName = json['acf']['map_location']['city'],
        lat = json['acf']['map_location']['lat'],
        lng = json['acf']['map_location']['lng'];

  Map<String, dynamic> toJson() => {
        'title': title,
        // 'mediaType': mediaType,
        'description': description,
        'date': date_submitted,
        'event_date': event_date,
        // 'source_url': source_url,
        'status': status,
        'author': author,
      };
}
