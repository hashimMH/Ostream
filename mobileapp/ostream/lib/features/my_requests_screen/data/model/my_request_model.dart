class MyRequestsModel {
  final String title;
  final String status;
  final String lastUpdate;
  final String description;
  final List<Map<String, String>> responses;

  MyRequestsModel({
    required this.title,
    required this.status,
    required this.lastUpdate,
    required this.description,
    required this.responses,
  });
}



final List<MyRequestsModel> requests = [
  MyRequestsModel(
    title: "Public Transportation Service Station",
    status: "Waiting for Review",
    lastUpdate: "2024-11-16",
    description: "A proposed service station for public transportation vehicles, including buses and taxis, aimed at improving commute efficiency.",
    responses: [
      {
        "author": "Transportation Dept.",
        "date": "2024-11-15",
        "response": "We are reviewing the proposal and ensuring it meets city requirements."
      },
      {
        "author": "John Doe",
        "date": "2024-11-14",
        "response": "This project has great potential to reduce transit delays."
      },
    ],
  ),
  MyRequestsModel(
    title: "Community Park in Al Reem Island",
    status: "In Review",
    lastUpdate: "2024-11-14",
    description: "A project to develop a community park with green spaces, playgrounds, and walking tracks for residents in Al Reem Island.",
    responses: [
      {
        "author": "City Planner",
        "date": "2024-11-13",
        "response": "We are reviewing the environmental impact assessment."
      },
      {
        "author": "Resident Feedback",
        "date": "2024-11-12",
        "response": "The park will significantly improve community life."
      },
    ],
  ),
  MyRequestsModel(
    title: "Healthcare Center in Al Mussafah",
    status: "Accepted",
    lastUpdate: "2024-11-12",
    description: "A healthcare center designed to provide primary care and emergency services to residents in Al Mussafah.",
    responses: [
      {
        "author": "Health Ministry",
        "date": "2024-11-11",
        "response": "The project has been approved, and site preparations will begin soon."
      },
      {
        "author": "Project Coordinator",
        "date": "2024-11-10",
        "response": "Contractors are being finalized for the construction phase."
      },
    ],
  ),
  MyRequestsModel(
    title: "Smart Street Lighting in Downtown Abu Dhabi",
    status: "In Progress",
    lastUpdate: "2024-11-10",
    description: "Implementation of smart street lighting to enhance energy efficiency and improve safety in Downtown Abu Dhabi.",
    responses: [
      {
        "author": "John Doe",
        "date": "2024-11-09",
        "response": "The project implementation is going well and on schedule."
      },
      {
        "author": "Jane Smith",
        "date": "2024-11-08",
        "response": "We encountered a minor delay due to unexpected weather conditions."
      },
      {
        "author": "Project Lead",
        "date": "2024-11-07",
        "response": "Materials have been procured, and work has started at the main site."
      },
    ],
  ),
  MyRequestsModel(
    title: "New Public Library in Khalifa City",
    status: "Rejected",
    lastUpdate: "2024-11-09",
    description: "A proposal for a modern public library in Khalifa City, featuring a digital archive and community spaces.",
    responses: [
      {
        "author": "City Council",
        "date": "2024-11-08",
        "response": "The project was rejected due to budget constraints."
      },
      {
        "author": "Resident Feedback",
        "date": "2024-11-07",
        "response": "We hope the city revisits this idea in the future."
      },
    ],
  ),
  MyRequestsModel(
    title: "Beachfront Promenade in Al Bateen",
    status: "Waiting for Review",
    lastUpdate: "2024-11-08",
    description: "A plan to create a scenic beachfront promenade with leisure and dining options in Al Bateen.",
    responses: [
      {
        "author": "Tourism Board",
        "date": "2024-11-07",
        "response": "We are evaluating the feasibility of this project."
      },
      {
        "author": "Jane Smith",
        "date": "2024-11-06",
        "response": "This promenade will attract more visitors to the area."
      },
    ],
  ),
  MyRequestsModel(
    title: "Recycling Facility in Al Wathba",
    status: "In Review",
    lastUpdate: "2024-11-07",
    description: "A proposed recycling facility to manage waste more efficiently and promote sustainable practices in Al Wathba.",
    responses: [
      {
        "author": "Environment Agency",
        "date": "2024-11-06",
        "response": "We are assessing the environmental benefits of the project."
      },
      {
        "author": "Resident Feedback",
        "date": "2024-11-05",
        "response": "This is a much-needed project for waste management."
      },
    ],
  ),
  MyRequestsModel(
    title: "New Water Treatment Plant in Al Shamkha",
    status: "In Progress",
    lastUpdate: "2024-11-05",
    description: "Construction of a water treatment plant to enhance water supply and improve quality in Al Shamkha.",
    responses: [
      {
        "author": "John Doe",
        "date": "2024-11-04",
        "response": "The foundation work for the plant has been completed."
      },
      {
        "author": "Jane Smith",
        "date": "2024-11-03",
        "response": "We are awaiting the arrival of specialized equipment for the next phase."
      },
    ],
  ),
];
