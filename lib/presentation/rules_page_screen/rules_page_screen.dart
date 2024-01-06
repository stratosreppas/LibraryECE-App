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

class RulesPageScreen extends StatefulWidget {
  RulesPageScreen({Key? key}) : super(key: key);

  @override
  State<RulesPageScreen> createState() => _RulesPageScreenState();
}

class _RulesPageScreenState extends State<RulesPageScreen> {
  final List<Item> faqs = <Item>[
    Item(
        id: 1,
        expandedText:
            "Οι επισκέπτες μπορούν να δανείζονται μέχρι 3 βιβλία για 1 εβδομάδα. Αν ο επισκέπτης δανείζεται για πρώτη φορά θα πρέπει να έχει μαζί του την αστυνομική και την ακαδημαϊκή του ταυτότητα για να γίνει η εγγραφή στη βάση δεδομένων της βιβλιοθήκης. Μετά την εγγραφή του, ο επισκέπτης σε κάθε δανεισμό θα πρέπει να επιδεικνύει κάποιο επίσημο έγγραφο με φωτογραφία (αστυνομική ταυτότητα,ακαδημαϊκή ταυτότητα, δίπλωμα οδήγησης).",
        headerText: "Δανεισμός Βιβλίων"),
    Item(
        id: 2,
        expandedText:
            "Οι επισκέπτες έχουν δικαίωμα ανανέωσης του δανεισμού για 1 εβδομάδα από την ημέρα ανανέωσης. Η ανανέωση μπορεί να γίνει μέχρι και την ημέρα επιστροφής του βιβλίου. Δεν μπορεί να γίνει ανανέωση σε καθυστερημένο βιβλίο. Οι ανανεώσεις γίνονται είτε στην Βιβλιοθήκη είτε μέσω τηλεφώνου/e-mail.",
        headerText: "Ανανεώσεις Δανεισμών"),
    Item(
        id: 3,
        expandedText:
            "Στην είσοδο της Βιβλιοθήκης οι χρήστες του αναγνωστηρίου είναι υποχρεωµένοι να αφήνουν τις τσάντες τους σε φοριαµό αφού προµηθευτούν κλειδί από τον βιβλιοθηκάριο βάρδιας, αφήνοντας του ένα στοιχείο ταυτότητας (Φοιτητικό Πάσο, Αστυνοµική Ταυτότητα, Κάρτα κεντρικής βιβλιοθήκης, άδεια οδήγησης κ.ο.κ). Απαγορεύεται αυστηρά η είσοδος στο χώρο του αναγνωστηρίου µε οποιουδήποτε είδους τσάντες. Το κάπνισµα, τα ποτά (εκτός από µπουκάλι µε νερό) και τα φαγητά δεν επιτρέπονται στον χώρο του αναγνωστηρίου. Απαραίτητος επίσης είναι και ο σεβασµός στο υλικό της Βιβλιοθήκης (βιβλία, περιοδικά, υπολογιστές, φωτοτυπικό, έπιπλα κ.λπ.). ",
        headerText: "Αναγνωστήριο"),
    Item(
        id: 4,
        expandedText:
            "Οι χρήστες µπορούν να χρησιµοποιούν το φωτοτυπικό µηχάνηµα που διαθέτει η Βιβλιοθήκη, το οποίο θα χειρίζονται οι ίδιοι κατόπιν οδηγιών χειρισµού από το βιβλιοθηκάριο βάρδιας. Το κόστος φωτοτύπησης καθορίζεται στα 5 λεπτά ανά φύλλο φωτοτυπίας. Τονίζεται ότι ο βιβλιοθηκάριος δεν είναι υποχρεωµένος να προβαίνει σε φωτοτύπηση του υλικού της Βιβλιοθήκης.",
        headerText: "Φωτοτυπίες"),
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
