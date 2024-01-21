import 'package:flutter/material.dart';
import 'package:library_ece/core/app_export.dart';
import 'package:library_ece/widgets/app_bar/appbar_subtitle.dart';
import 'package:library_ece/widgets/app_bar/custom_app_bar.dart';

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

class FaqsPageScreen extends StatefulWidget {
  FaqsPageScreen({Key? key}) : super(key: key);

  @override
  State<FaqsPageScreen> createState() => _FaqsPageScreenState();
}

class _FaqsPageScreenState extends State<FaqsPageScreen> {
  final List<Item> faqs = <Item>[
    Item(
        id: 1,
        expandedText:
            "Η βιβλιοθήκη είναι ανοικτή τις ημέρες που είναι ανοικτή η σχολή με ωράριο 09:00 - 18:00. Σε περίοδο διακοπών, η Βιβλιοθήκη λειτουργεί τις ημέρες που είναι ανοιχτές και οι υπόλοιπες Διοικητικές Υπηρεσίες της Σχολής με ωράριο 09:00-15:00. Σε περίπτωση κλειστής σχολής (λόγω κατάληψης, απεργίας ή διακοπών) η βιβλιοθήκη παραμένει κλειστή. Σε κάθε περίπτωση θα αναρτάται στην αρχική σελίδα στο site της Βιβλιοθήκης έγκαιρα, σχετική ενημέρωση για την εξυπηρέτηση του κοινού.",
        headerText:
            "Ποιές μέρες η βιβλιοθήκη είναι κλειστή, πέραν του μόνιμου ωραρίου; Πότε είναι ανοικτή η βιβλιοθήκη;"),
    Item(
        id: 2,
        expandedText:
            "Η πολιτική που ακολουθούμε στο συγκεκριμένο ζήτημα αφορά την ομαλή λειτουργία της βιβλιοθήκης και την τήρηση των τυπικών διαδικασιών. Η βιβλιοθήκη παρέχει φωτοτυπικό για σημειώσεις για την εξυπηρέτηση των φοιτητών.Υπάρχει επίσης η δυνατότητα εκτύπωσης μέσω USB ή email/cloud. Δεν αναλαμβάνουμε, ωστόστο, scans αρχείων, εκτός αν πρόκειται για σημειώσεις που θα ανέβουν στο forum της Σχολής.",
        headerText:
            "Μπορώ να τυπώσω από USB stick ή από το προσωπικό μου e-mail / cloud;"),
    Item(
        id: 3,
        expandedText:
            "Η απόφασή μας στο συγκεκριμένο ζήτημα αφορά την ίση και δίκαιη συμπεριφορά μας ως βιβλιοθήκη απέναντι στο σύνολο των φοιτητών, και δεν έχει «εκδικητικό» χαρακτήρα. Το βιβλίο που ένας φοιτητής καθυστέρησε να επιστρέψει, ίσως ήταν απαραίτητο για κάποιον άλλο φοιτητή, ειδικά σε περίοδο εξεταστικής. Έτσι εξασφαλίζεται η διμερής συνέπεια ανάμεσα σε βιβλιοθήκη και δανειζόμενο, καθώς και η τήρηση των προβλεπόμενων ημερομηνιών / κανόνων, πράγμα αυτονόητο.",
        headerText:
            "Γιατί να τιμωρηθώ επειδή καθυστέρησα να επιστρέψω το βιβλίο που δανείστηκα;"),
    Item(
        id: 4,
        expandedText:
            "Δικαίωμα υποβολής βιογραφικού για εργασία στη βιβλιοθήκη έχει κάθε φοιτητής της Σχολής ΗΜΜΥ, ωστόσο συνήθως προτιμώνται άτομα από μικρότερα έτη ώστε να διατηρείται ένας κορμός στη βιβλιοθήκη. Οι προσλήψεις γίνονται μία φορά περίπου το χρόνο. Σχετική ενημέρωση ανεβαίνει και στο site μας, όσο και στην επίσημη ιστοσελίδα της Σχολής ΗΜΜΥ.",
        headerText:
            "Μπορώ να κάνω αίτηση για να εργαστώ κι εγώ στη βιβλιοθήκη;"),
    Item(
        id: 5,
        expandedText:
            "Η απόφαση αυτή έχει παρθεί για την διασφάλιση των προσωπικών σας αντικειμένων, την αποτροπή κλοπών και την αποφυγή «μπερδέματος» (π.χ. κάποιος πήρε την ίδια μαύρη polo συμφοιτητή του). Επίσης δεν υπάρχει επαρκής χώρος στο αναγνωστήριο.",
        headerText:
            "Γιατί δεν μπορώ να πάρω την τσάντα μου μαζί μου στο αναγνωστήριο;"),
    Item(
        id: 6,
        expandedText:
            "Δεν επιτρέπονται οι καφέδες δεδομένου ότι έχουν συμβεί κατά καιρούς «ατυχήματα» με συνέπεια: την ρύπανση του χώρου, καταστροφή βιβλίων, πιθανά προβλήματα με τις πρίζες τροφοδοσίας ρεύματος και βλάβη σε laptop του ιδίου ή συμφοιτητή του. Μπορείτε να έχετε μαζί σας μόνο νερό σε μπουκαλάκι ή θερμός.",
        headerText:
            "Γιατί δεν μπορώ να πάρω τον καφέ μαζί μου στο αναγνωστήριο;")
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
                      canTapOnHeader: true,
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
        leading: GestureDetector(
          onTap: () {
            onTapArrowLeft(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Icon(
              Icons.arrow_back,
              color: appTheme.blueGray100,
              size: 28.adaptSize,
            ),
          ),
        ),
        title:
            AppbarSubtitle(text: "FAQs", margin: EdgeInsets.only(left: 14.h)),
        styleType: Style.bgFill);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
