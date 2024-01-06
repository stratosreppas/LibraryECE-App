import 'package:flutter/material.dart';
import 'package:stratos_s_application3/core/app_export.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_leading_image.dart';
import 'package:stratos_s_application3/widgets/app_bar/appbar_subtitle.dart';
import 'package:stratos_s_application3/widgets/app_bar/custom_app_bar.dart';

class Item {
  Item({
    required this.id,
    required this.expandedText,
    required this.headerText,
  });
  int id;
  final expandedText;
  final String headerText;
}

class ArtemisPageScreen extends StatefulWidget {
  ArtemisPageScreen({Key? key}) : super(key: key);

  @override
  State<ArtemisPageScreen> createState() => _ArtemisPageScreenState();
}

class _ArtemisPageScreenState extends State<ArtemisPageScreen> {
  final List<Item> faqs = <Item>[
    Item(
        id: 1,
        expandedText:
            "Το σύστημα \"Άρτεμις\" είναι ένα διαπανεπιστημιακό δίκτυο ψηφιακής βιβλιοθήκης για την ηλεκτρονική τεκμηρίωση της σύγχρονης ελληνικής γκρίζας (δηλαδή της μη δημοσιευμένης) βιβλιογραφίας. Δηλαδή στο σύστημα αποθηκεύονται διπλωματικές, διδακτορικά, μεταπτυχιακές καθώς και άλλου είδος εργασίες. Αυτές οι εργασίες μπορούν να αναζητηθούν στη διεύθυνση artemis.cslab.ntua.gr.",
        headerText: "Γενικές Πληροφορίες για το Άρτεμις"),
    Item(
        id: 2,
        expandedText:
            "Ο φοιτητής, βάσει αποφάσεως της σχολής έχει τρεις υποχρεώσεις: \n1) Πρέπει να συντάξει την εργασία του βάση του Οδηγού Συγγραφής. \n2) Η διπλωματική εργασία γράφεται στην ελληνική γλώσσα. Η τριμελής εξεταστική επιτροπή κρίνει την αυτοτέλεια, πληρότητα και επάρκεια του κειμένου και εγκρίνει και την ανάρτησή του στο σύστημα ΑΡΤΕΜΙΣ. Μπορεί να παραδοθεί παράλληλα και αγγλικό κείμενο που να περιγράφει την διπλωματική εργασία, το οποίο περνάει επίσης από την έγκριση της τριμελούς εξεταστικής επιτροπής και μπορεί να αναρτηθεί και αυτό στο ΑΡΤΕΜΙΣ. \n3) Οφείλει να συμπληρώσει την κατάλληλη φόρμα και να στείλει την εργασία του με τη μορφή pdf στην ηλεκτρονική πλατφόρμα Artemis. \nΜετά την υποβολή της αίτησης από το φοιτητή και την επεξεργασία της από τη βιβλιοθήκη (συνήθως εντός 1-2 εργάσιμων ημερών), ο φοιτητής θα λάβει από την βιβλιοθήκη ένα email το οποίο θα τον ενημερώνει για την ορθότητα του εγγράφου του ή για τις διορθώσεις που πρέπει να κάνει στην αίτηση του. \nΕάν η φόρμα έχει συμπληρωθεί πλήρως και επιτυχώς και το έγγραφό του ακολουθεί τον οδηγό συγγραφής, ο φοιτητής θα λάβει mail πιστοποίησης επιτυχούς εισαγωγής της εργασίας του στο ΑΡΤΕΜΙΣ και μη οφειλής βιβλίων στη βιβλιοθήκη ΣΗΜΜΥ. Από τη στιγμή που θα λάβει το email για την επιτυχή υποβολή του εγγράφου του στο σύστημα \"Άρτεμις\" δεν μπορεί να γίνει κάποια αλλαγή στο έγγραφο, παρά μόνο σε εξαιρετικές περιπτώσεις και μετά από συνεννόηση με το cslab και τον υπεύθυνο καθηγητή.",
        headerText: "Υποχρέωση του Φοιτητή"),
    Item(
        id: 3,
        expandedText:
            "Για τη διευκόλυνσή σας επισημαίνουμε επιγραμματικά κάποια σημεία που χρειάζονται προσοχή: \n- Το αγγλικό κείμενο είναι προαιρετικό και εφόσον υπάρχει, πρέπει να εγκριθεί όπως και το ελληνικό από την τριμελή επιτροπή. Εργασίες μόνο στα Αγγλικά, που δεν συνδέονται από εκτενή ελληνική περίληψη, θα απορρίπτονται άμεσα. \n- Το εξώφυλλο πρέπει να περιλαμβάνει μόνο την επωνυμία του ιδρύματος, τη σχολή και τον τομέα σπουδών, τον τίτλο της εργασίας, το ονοματεπώνυμο του κάθε συγγραφέα, το πρώτο γράμμα του πατρώνυμου, το ονοματεπώνυμο και την ιδιότητα του επιβλέποντος και την ημερομηνία αξιολόγησης της εργασίας. \n- Θα πρέπει να υπάρχει σχετικό κείμενο εντός του αρχείου της εργασίας που να αφορά την προστασία των πνευματικών δικαιωμάτων του συγγραφέα (copyright) \n-Θα πρέπει το αρχείο της εργασίας να περιλαμβάνει περίληψη και λέξεις-κλειδιά, τόσο στα ελληνικά όσο και στα αγγλικά, καθώς και τη βιβλιογραφία που χρησιμοποιήθηκε στο τέλος.",
        headerText: "Παρατηρήσεις - συχνά λάθη"),
    Item(
        id: 4,
        expandedText:
            "Υπεύθυνη για τον έλεγχο της εισαγωγής της εργασίας στο σύστημα \"Άρτεμις\" είναι η Βιβλιοθήκη της Σχολής, η οποία πριν την εισαγωγή του έγγραφου θα ελέγχει την ορθότητα των στοιχείων καθώς και του αρχείου του και μετά θα ενημερώνει με e-mail για την επιτυχή περάτωση της διαδκασίας τόσο τον φοιτητή όσο και την γραμματεία τής Σχολής. Η διαδικασία ολοκληρώνεται συνήθως εντός δύο εργασίμων από την αίτηση της εισαγωγής.",
        headerText: "Υποχρέωση της Βιβλιοθήκης"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Padding(
              padding: EdgeInsets.only(
                  top: 30.adaptSize,
                  left: 15.adaptSize,
                  right: 15.adaptSize,
                  bottom: 30.adaptSize),
              child: ListView(children: [
                ExpansionPanelList.radio(
                  elevation: 4,
                  animationDuration: Duration(milliseconds: 750),
                  expandIconColor: appTheme.blueGray100,
                  dividerColor: appTheme.blueGray100,
                  expandedHeaderPadding: EdgeInsets.only(top: 4.adaptSize),
                  children: faqs.map<ExpansionPanelRadio>((Item item) {
                    return ExpansionPanelRadio(
                      value: item.id,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.headerText,
                              style: TextStyle(color: appTheme.blueGray100)),
                        );
                      },
                      backgroundColor: theme.colorScheme.primary,
                      body: ListTile(
                        title: Text(
                          item.expandedText,
                          style: TextStyle(color: appTheme.blueGray100),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            )));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 30.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 6.h, top: 9.v, bottom: 9.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "Άρτεμις", margin: EdgeInsets.only(left: 14.h)),
        styleType: Style.bgFill);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
