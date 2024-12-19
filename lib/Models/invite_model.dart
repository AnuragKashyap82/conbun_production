class ReferralData {
  final String referralCode;
  final List<InviteModel> invites;

  ReferralData({
    required this.referralCode,
    required this.invites,
  });

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      referralCode: json['referral_code'] as String,
      invites: (json['yourInvites'] as List)
          .map((inviteJson) => InviteModel.fromJson(inviteJson))
          .toList(),
    );
  }
}
class InviteModel {
  final String id;
  final String amount;
  final String name;
  final String? profileImage; // Nullable to handle null values

  InviteModel({
    required this.id,
    required this.amount,
    required this.name,
    this.profileImage,
  });

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      id: json['id'] as String,
      amount: json['amount'] as String,
      name: json['name'] as String,
      profileImage: json['profile_image'] as String?,
    );
  }
}
