class HomeSuggestionModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String creationDate;

  HomeSuggestionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.creationDate,
  });
}

final List<HomeSuggestionModel> suggestions = [
  HomeSuggestionModel(
    id: "1",
    title: "Public Transportation Service Station",
    description: "A new service station for public transportation to enhance accessibility and convenience for residents and visitors in Al Zahiyah, Abu Dhabi.",
    location: "Al Zahiyah, Abu Dhabi",
    creationDate: "2024-11-16",
  ),
  HomeSuggestionModel(
    id: "2",
    title: "Community Park in Al Reem Island",
    description: "Developing a green public park for recreational activities, outdoor sports, and family-friendly spaces in Al Reem Island to promote community engagement.",
    location: "Al Reem Island, Abu Dhabi",
    creationDate: "2024-11-14",
  ),
  HomeSuggestionModel(
    id: "3",
    title: "Healthcare Center in Al Mussafah",
    description: "Establishing a state-of-the-art healthcare facility in Al Mussafah to cater to the growing population and improve medical services in the area.",
    location: "Al Mussafah, Abu Dhabi",
    creationDate: "2024-11-12",
  ),
  HomeSuggestionModel(
    id: "4",
    title: "Smart Street Lighting in Downtown Abu Dhabi",
    description: "Implementing smart street lighting systems in Downtown Abu Dhabi to improve energy efficiency, safety, and the city's environmental sustainability.",
    location: "Downtown Abu Dhabi",
    creationDate: "2024-11-10",
  ),
  HomeSuggestionModel(
    id: "5",
    title: "New Public Library in Khalifa City",
    description: "A new public library that will offer resources for learning, a community space, and events to foster a culture of reading and education in Khalifa City.",
    location: "Khalifa City, Abu Dhabi",
    creationDate: "2024-11-09",
  ),
  HomeSuggestionModel(
    id: "6",
    title: "Beachfront Promenade in Al Bateen",
    description: "A new promenade along the beachfront in Al Bateen to enhance tourism, provide leisure facilities, and offer a scenic walking and cycling path.",
    location: "Al Bateen, Abu Dhabi",
    creationDate: "2024-11-08",
  ),
  HomeSuggestionModel(
    id: "7",
    title: "Recycling Facility in Al Wathba",
    description: "Setting up a dedicated recycling center in Al Wathba to encourage sustainable waste management and reduce environmental impact in the region.",
    location: "Al Wathba, Abu Dhabi",
    creationDate: "2024-11-07",
  ),
  HomeSuggestionModel(
    id: "8",
    title: "New Water Treatment Plant in Al Shamkha",
    description: "Constructing a new water treatment plant in Al Shamkha to ensure a reliable and sustainable water supply for residential and industrial needs.",
    location: "Al Shamkha, Abu Dhabi",
    creationDate: "2024-11-05",
  ),
];

