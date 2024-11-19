class NotificationModel {
  final String title;
  final String message;
  final String date;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    required this.isRead,
  });
}


final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    title: "Smart Street Lighting in Downtown Abu Dhabi",
    message: "The smart street lighting project in Downtown Abu Dhabi is now in progress. This project aims to enhance street visibility and energy efficiency.",
    date: "2024-11-16",
    isRead: false,
  ),
  NotificationModel(
    title: "Public Park Renovation in Al Khalidiya",
    message: "The renovation of the public park in Al Khalidiya has been approved. Construction will begin soon to provide a new recreational space.",
    date: "2024-11-14",
    isRead: true,
  ),
  NotificationModel(
    title: "New Metro Line Construction in Al Raha",
    message: "The construction of the new metro line in Al Raha has been officially approved. The project is set to provide better connectivity across the city.",
    date: "2024-11-12",
    isRead: false,
  ),
  NotificationModel(
    title: "Waste Management System Upgrade in Mussafah",
    message: "The upgrade of the waste management system in Mussafah has begun. This project is aimed at improving waste collection and recycling processes.",
    date: "2024-11-10",
    isRead: true,
  ),
];

