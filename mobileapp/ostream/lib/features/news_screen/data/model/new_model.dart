class NewsModel {
  String? status;
  int? totalResults;
  List<Results>? results;

  NewsModel({this.status, this.totalResults, this.results});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? articleId;
  String? title;
  String? link;
  String? videoUrl;
  String? description;
  String? content;
  String? pubDate;
  String? pubDateTZ;
  String? imageUrl;
  String? sourceId;
  int? sourcePriority;
  String? sourceName;
  String? sourceUrl;
  String? sourceIcon;
  String? language;
  bool? duplicate;

  Results(
      {this.articleId,
        this.title,
        this.link,
        this.videoUrl,
        this.description,
        this.content,
        this.pubDate,
        this.pubDateTZ,
        this.imageUrl,
        this.sourceId,
        this.sourcePriority,
        this.sourceName,
        this.sourceUrl,
        this.sourceIcon,
        this.language,
        this.duplicate});

  Results.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    link = json['link'];
    videoUrl = json['video_url'];
    description = json['description'];
    content = json['content'];
    pubDate = json['pubDate'];
    pubDateTZ = json['pubDateTZ'];
    imageUrl = json['image_url'];
    sourceId = json['source_id'];
    sourcePriority = json['source_priority'];
    sourceName = json['source_name'];
    sourceUrl = json['source_url'];
    sourceIcon = json['source_icon'];
    language = json['language'];
    duplicate = json['duplicate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['article_id'] = articleId;
    data['title'] = title;
    data['link'] = link;
    data['video_url'] = videoUrl;
    data['description'] = description;
    data['content'] = content;
    data['pubDate'] = pubDate;
    data['pubDateTZ'] = pubDateTZ;
    data['image_url'] = imageUrl;
    data['source_id'] = sourceId;
    data['source_priority'] = sourcePriority;
    data['source_name'] = sourceName;
    data['source_url'] = sourceUrl;
    data['source_icon'] = sourceIcon;
    data['language'] = language;
    data['duplicate'] = duplicate;
    return data;
  }
}
