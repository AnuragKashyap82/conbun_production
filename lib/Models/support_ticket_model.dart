  class SupportTicketModel {
  final String ticketId;
  final String adminReplying;
  final String userId;
  final String relType;
  final String contactId;
  final String? mergedTicketId;
  final String? email;
  final String name;
  final String department;
  final String priority;
  final String status;
  final String? service;
  final String ticketKey;
  final String subject;
  final String message;
  final String? admin;
  final String date;
  final String projectId;
  final String? lastReply;
  final String clientRead;
  final String adminRead;
  final String assigned;
  final String? staffIdReplying;
  final String? cc;
  final String departmentId;
  final String imapUsername;
  final String emailFromHeader;
  final String host;
  final String? password;
  final String encryption;
  final String folder;
  final String deleteAfterImport;
  final String? calendarId;
  final String hideFromClient;
  final String ticketStatusId;
  final String isDefault;
  final String statusColor;
  final String statusOrder;
  final String? serviceId;
  final String? company;
  final String? vat;
  final String? phoneNumber;
  final String? country;
  final String? city;
  final String? zip;
  final String? state;
  final String? address;
  final String? website;
  final String? dateCreated;
  final String? active;
  final String? leadId;
  final String? billingStreet;
  final String? billingCity;
  final String? billingState;
  final String? billingZip;
  final String? billingCountry;
  final String? shippingStreet;
  final String? shippingCity;
  final String? shippingState;
  final String? shippingZip;
  final String? shippingCountry;
  final String? longitude;
  final String? latitude;
  final String? defaultLanguage;
  final String? defaultCurrency;
  final String? showPrimaryContact;
  final String? stripeId;
  final String? registrationConfirmed;
  final String? addedFrom;
  final String? id;
  final String? isPrimary;
  final String? firstname;
  final String? lastname;
  final String? title;
  final String? newPassKey;
  final String? newPassKeyRequested;
  final String? emailVerifiedAt;
  final String? emailVerificationKey;
  final String? emailVerificationSentAt;
  final String? lastIp;
  final String? lastLogin;
  final String? lastPasswordChange;
  final String? profileImage;
  final String? direction;
  final String? invoiceEmails;
  final String? estimateEmails;
  final String? creditNoteEmails;
  final String? contractEmails;
  final String? taskEmails;
  final String? projectEmails;
  final String? ticketEmails;
  final String? staffId;
  final String? facebook;
  final String? linkedin;
  final String? skype;
  final String? lastActivity;
  final String? role;
  final String? mediaPathSlug;
  final String? isNotStaff;
  final String? hourlyRate;
  final String? twoFactorAuthEnabled;
  final String? twoFactorAuthCode;
  final String? twoFactorAuthCodeRequested;
  final String? emailSignature;
  final String? googleAuthSecret;
  final String priorityId;
  final String? fromName;
  final String? ticketEmail;
  final String departmentName;
  final String priorityName;
  final String? serviceName;
  final String statusName;
  final String? userFirstname;
  final String? userLastname;
  final String? staffFirstname;
  final String? staffLastname;

  SupportTicketModel({
    required this.ticketId,
    required this.adminReplying,
    required this.userId,
    required this.relType,
    required this.contactId,
    this.mergedTicketId,
    this.email,
    required this.name,
    required this.department,
    required this.priority,
    required this.status,
    this.service,
    required this.ticketKey,
    required this.subject,
    required this.message,
    this.admin,
    required this.date,
    required this.projectId,
    this.lastReply,
    required this.clientRead,
    required this.adminRead,
    required this.assigned,
    this.staffIdReplying,
    this.cc,
    required this.departmentId,
    required this.imapUsername,
    required this.emailFromHeader,
    required this.host,
    this.password,
    required this.encryption,
    required this.folder,
    required this.deleteAfterImport,
    this.calendarId,
    required this.hideFromClient,
    required this.ticketStatusId,
    required this.isDefault,
    required this.statusColor,
    required this.statusOrder,
    this.serviceId,
    this.company,
    this.vat,
    this.phoneNumber,
    this.country,
    this.city,
    this.zip,
    this.state,
    this.address,
    this.website,
    this.dateCreated,
    this.active,
    this.leadId,
    this.billingStreet,
    this.billingCity,
    this.billingState,
    this.billingZip,
    this.billingCountry,
    this.shippingStreet,
    this.shippingCity,
    this.shippingState,
    this.shippingZip,
    this.shippingCountry,
    this.longitude,
    this.latitude,
    this.defaultLanguage,
    this.defaultCurrency,
    this.showPrimaryContact,
    this.stripeId,
    this.registrationConfirmed,
    this.addedFrom,
    this.id,
    this.isPrimary,
    this.firstname,
    this.lastname,
    this.title,
    this.newPassKey,
    this.newPassKeyRequested,
    this.emailVerifiedAt,
    this.emailVerificationKey,
    this.emailVerificationSentAt,
    this.lastIp,
    this.lastLogin,
    this.lastPasswordChange,
    this.profileImage,
    this.direction,
    this.invoiceEmails,
    this.estimateEmails,
    this.creditNoteEmails,
    this.contractEmails,
    this.taskEmails,
    this.projectEmails,
    this.ticketEmails,
    this.staffId,
    this.facebook,
    this.linkedin,
    this.skype,
    this.lastActivity,
    this.role,
    this.mediaPathSlug,
    this.isNotStaff,
    this.hourlyRate,
    this.twoFactorAuthEnabled,
    this.twoFactorAuthCode,
    this.twoFactorAuthCodeRequested,
    this.emailSignature,
    this.googleAuthSecret,
    required this.priorityId,
    this.fromName,
    this.ticketEmail,
    required this.departmentName,
    required this.priorityName,
    this.serviceName,
    required this.statusName,
    this.userFirstname,
    this.userLastname,
    this.staffFirstname,
    this.staffLastname,
  });

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketModel(
        ticketId: json['ticketid'] ?? '',
        adminReplying: json['adminreplying'] ?? '',
        userId: json['userid'] ?? '',
        relType: json['rel_type'] ?? '',
        contactId: json['contactid'] ?? '',
      mergedTicketId: json['merged_ticket_id'],
      email: json['email'],
      name: json['name'] ?? '',
      department: json['department'] ?? '',
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
      service: json['service'],
      ticketKey: json['ticketkey'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      admin: json['admin'],
      date: json['date'] ?? '',
      projectId: json['project_id'] ?? '',
      lastReply: json['lastreply'],
      clientRead: json['clientread'] ?? '',
      adminRead: json['adminread'] ?? '',
      assigned: json['assigned'] ?? '',
      staffIdReplying: json['staff_id_replying'],
      cc: json['cc'],
      departmentId: json['departmentid'] ?? '',
      imapUsername: json['imap_username'] ?? '',
      emailFromHeader: json['email_from_header'] ?? '',
      host: json['host'] ?? '',
      password: json['password'],
      encryption: json['encryption'] ?? '',
      folder: json['folder'] ?? '',
      deleteAfterImport: json['delete_after_import'] ?? '',
      calendarId: json['calendar_id'],
      hideFromClient: json['hidefromclient'] ?? '',
      ticketStatusId: json['ticketstatusid'] ?? '',
      isDefault: json['isdefault'] ?? '',
      statusColor: json['statuscolor'] ?? '',
      statusOrder: json['statusorder'] ?? '',
      serviceId: json['serviceid'],
      company: json['company'],
      vat: json['vat'],
      phoneNumber: json['phonenumber'],
      country: json['country'],
      city: json['city'],
      zip: json['zip'],
      state: json['state'],
      address: json['address'],
      website: json['website'],
      dateCreated: json['datecreated'],
      active: json['active'],
      leadId: json['leadid'],
      billingStreet: json['billing_street'],
      billingCity: json['billing_city'],
      billingState: json['billing_state'],
      billingZip: json['billing_zip'],
      billingCountry: json['billing_country'],
      shippingStreet: json['shipping_street'],
      shippingCity: json['shipping_city'],
      shippingState: json['shipping_state'],
      shippingZip: json['shipping_zip'],
      shippingCountry: json['shipping_country'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      defaultLanguage: json['default_language'],
      defaultCurrency: json['default_currency'],
      showPrimaryContact: json['show_primary_contact'],
      stripeId: json['stripe_id'],
      registrationConfirmed: json['registration_confirmed'],
      addedFrom: json['addedfrom'],
      id: json['id'],
      isPrimary: json['is_primary'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      title: json['title'],
      newPassKey: json['new_pass_key'],
      newPassKeyRequested: json['new_pass_key_requested'],
      emailVerifiedAt: json['email_verified_at'],
      emailVerificationKey: json['email_verification_key'],
      emailVerificationSentAt: json['email_verification_sent_at'],
      lastIp: json['last_ip'],
      lastLogin: json['last_login'],
      lastPasswordChange: json['last_password_change'],
      profileImage: json['profile_image'],
      direction: json['direction'],
      invoiceEmails: json['invoice_emails'],
      estimateEmails: json['estimate_emails'],
      creditNoteEmails: json['credit_note_emails'],
      contractEmails: json['contract_emails'],
      taskEmails: json['task_emails'],
      projectEmails: json['project_emails'],
      ticketEmails: json['ticket_emails'],
      staffId: json['staffid'],
      facebook: json['facebook'],
      linkedin: json['linkedin'],
      skype: json['skype'],
      lastActivity: json['last_activity'],
      role: json['role'],
      mediaPathSlug: json['media_path_slug'],
      isNotStaff: json['is_not_staff'],
      hourlyRate: json['hourly_rate'],
      twoFactorAuthEnabled: json['two_factor_auth_enabled'],
      twoFactorAuthCode: json['two_factor_auth_code'],
      twoFactorAuthCodeRequested: json['two_factor_auth_code_requested'],
      emailSignature: json['email_signature'],
      googleAuthSecret: json['google_auth_secret'],
      priorityId: json['priorityid'] ?? '',
      fromName: json['from_name'],
      ticketEmail: json['ticket_email'],
      departmentName: json['department_name'] ?? '',
      priorityName: json['priority_name'] ?? '',
      serviceName: json['service_name'],
      statusName: json['status_name'] ?? '',
      userFirstname: json['user_firstname'],
      userLastname: json['user_lastname'],
      staffFirstname: json['staff_firstname'],
      staffLastname: json['staff_lastname'],
    );
  }
  factory SupportTicketModel.empty() {
    return SupportTicketModel(
      ticketId: '',
      adminReplying: '',
      userId: '',
      relType: '',
      contactId: '',
      mergedTicketId: null,
      email: null,
      name: '',
      department: '',
      priority: '',
      status: '',
      service: null,
      ticketKey: '',
      subject: '',
      message: '',
      admin: null,
      date: '',
      projectId: '',
      lastReply: null,
      clientRead: '',
      adminRead: '',
      assigned: '',
      staffIdReplying: null,
      cc: null,
      departmentId: '',
      imapUsername: '',
      emailFromHeader: '',
      host: '',
      password: null,
      encryption: '',
      folder: '',
      deleteAfterImport: '',
      calendarId: null,
      hideFromClient: '',
      ticketStatusId: '',
      isDefault: '',
      statusColor: '',
      statusOrder: '',
      serviceId: null,
      company: null,
      vat: null,
      phoneNumber: null,
      country: null,
      city: null,
      zip: null,
      state: null,
      address: null,
      website: null,
      dateCreated: null,
      active: null,
      leadId: null,
      billingStreet: null,
      billingCity: null,
      billingState: null,
      billingZip: null,
      billingCountry: null,
      shippingStreet: null,
      shippingCity: null,
      shippingState: null,
      shippingZip: null,
      shippingCountry: null,
      longitude: null,
      latitude: null,
      defaultLanguage: null,
      defaultCurrency: null,
      showPrimaryContact: null,
      stripeId: null,
      registrationConfirmed: null,
      addedFrom: null,
      id: null,
      isPrimary: null,
      firstname: null,
      lastname: null,
      title: null,
      newPassKey: null,
      newPassKeyRequested: null,
      emailVerifiedAt: null,
      emailVerificationKey: null,
      emailVerificationSentAt: null,
      lastIp: null,
      lastLogin: null,
      lastPasswordChange: null,
      profileImage: null,
      direction: null,
      invoiceEmails: null,
      estimateEmails: null,
      creditNoteEmails: null,
      contractEmails: null,
      taskEmails: null,
      projectEmails: null,
      ticketEmails: null,
      staffId: null,
      facebook: null,
      linkedin: null,
      skype: null,
      lastActivity: null,
      role: null,
      mediaPathSlug: null,
      isNotStaff: null,
      hourlyRate: null,
      twoFactorAuthEnabled: null,
      twoFactorAuthCode: null,
      twoFactorAuthCodeRequested: null,
      emailSignature: null,
      googleAuthSecret: null,
      priorityId: '',
      fromName: null,
      ticketEmail: null,
      departmentName: '',
      priorityName: '',
      serviceName: null,
      statusName: '',
      userFirstname: null,
      userLastname: null,
      staffFirstname: null,
      staffLastname: null,
    );
  }
}

