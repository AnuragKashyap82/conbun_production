import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.1),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: colorViolet,
              size: 16,
            )),
        title: Text(
          "Term & Condition",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorViolet,
              fontFamily: "SemiBold"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                """Privacy Policy
Introduction
Welcome to [Your Company Name]. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about this privacy notice or our practices with regard to your personal information, please contact us at [Your Contact Information].

Information We Collect
We collect personal information that you voluntarily provide to us when you register on the website, express an interest in obtaining information about us or our products and services, when you participate in activities on the website, or otherwise when you contact us.

The personal information we collect can include the following:

Name and Contact Data: We collect your first and last name, email address, postal address, phone number, and other similar contact data.
Credentials: We collect passwords, password hints, and similar security information used for authentication and account access.
Payment Data: We collect data necessary to process your payment if you make purchases, such as your payment instrument number (e.g., a credit card number), and the security code associated with your payment instrument.
How We Use Your Information
We use personal information collected via our website for a variety of business purposes described below. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations.

We use the information we collect or receive:

To facilitate account creation and logon process.
To send administrative information to you.
To fulfill and manage your orders.
To deliver and facilitate delivery of services to the user.
To respond to user inquiries/offer support to users.
To send you marketing and promotional communications.
Sharing Your Information
We may process or share your data that we hold based on the following legal basis:

Consent: We may process your data if you have given us specific consent to use your personal information for a specific purpose.
Legitimate Interests: We may process your data when it is reasonably necessary to achieve our legitimate business interests.
Performance of a Contract: Where we have entered into a contract with you, we may process your personal information to fulfill the terms of our contract.
Legal Obligations: We may disclose your information where we are legally required to do so in order to comply with applicable law, governmental requests, a judicial proceeding, court order, or legal process, such as in response to a court order or a subpoena (including in response to public authorities to meet national security or law enforcement requirements).
Vital Interests: We may disclose your information where we believe it is necessary to investigate, prevent, or take action regarding potential violations of our policies, suspected fraud, situations involving potential threats to the safety of any person and illegal activities, or as evidence in litigation in which we are involved.
Cookies and Tracking Technologies
We may use cookies and similar tracking technologies (like web beacons and pixels) to access or store information. Specific information about how we use such technologies and how you can refuse certain cookies is set out in our Cookie Notice.

Data Security
We have implemented appropriate technical and organizational security measures designed to protect the security of any personal information we process. However, please also remember that we cannot guarantee that the internet itself is 100% secure. Although we will do our best to protect your personal information, transmission of personal information to and from our website is at your own risk. You should only access the services within a secure environment.

Your Privacy Rights
In some regions (like the European Economic Area), you have certain rights under applicable data protection laws. These may include the right (i) to request access and obtain a copy of your personal information, (ii) to request rectification or erasure; (iii) to restrict the processing of your personal information; and (iv) if applicable, to data portability. In certain circumstances, you may also have the right to object to the processing of your personal information.

Updates to This Policy
We may update this privacy notice from time to time in order to reflect, for example, changes to our practices or for other operational, legal, or regulatory reasons. We will notify you of any changes by posting the new privacy policy on this page. You are advised to review this privacy""",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colorBlack,
                    fontFamily: "Regular"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
