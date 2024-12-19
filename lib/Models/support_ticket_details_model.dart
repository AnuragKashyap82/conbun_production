class SupportTicketDetailsModel {
  final String? ticketid;
  final String? adminreplying;
  final String? userid;
  final String? relType;
  final String? contactid;
  final String? mergedTicketId;
  final String? email;
  final String? name;
  final String? department;
  final String? priority;
  final String? status;
  final String? service;
  final String? ticketkey;
  final String? subject;
  final String? message;
  final String? admin;
  final String? date;
  final String? projectId;
  final String? lastreply;
  final String? clientread;
  final String? adminread;
  final String? assigned;
  final String? staffIdReplying;
  final String? cc;
  final String? departmentid;
  final String? imapUsername;
  final String? emailFromHeader;
  final String? host;
  final String? password;
  final String? encryption;
  final String? folder;
  final String? deleteAfterImport;
  final String? calendarId;
  final String? hideFromClient;
  final String? ticketstatusid;
  final String? isdefault;
  final String? statuscolor;
  final String? statusorder;
  final String? serviceid;
  final String? company;
  final String? vat;
  final String? phonenumber;
  final String? country;
  final String? city;
  final String? zip;
  final String? state;
  final String? address;
  final String? website;
  final String? datecreated;
  final String? active;
  final String? leadid;
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
  final String? staffid;
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
  final String? priorityid;
  final String? fromName;
  final String? ticketEmail;
  final String? departmentName;
  final String? priorityName;
  final String? serviceName;
  final String? statusName;
  final String? userFirstname;
  final String? userLastname;
  final String? staffFirstname;
  final String? staffLastname;
  final List<TicketReply> ticketReplies;

  SupportTicketDetailsModel({
    this.ticketid,
    this.adminreplying,
    this.userid,
    this.relType,
    this.contactid,
    this.mergedTicketId,
    this.email,
    this.name,
    this.department,
    this.priority,
    this.status,
    this.service,
    this.ticketkey,
    this.subject,
    this.message,
    this.admin,
    this.date,
    this.projectId,
    this.lastreply,
    this.clientread,
    this.adminread,
    this.assigned,
    this.staffIdReplying,
    this.cc,
    this.departmentid,
    this.imapUsername,
    this.emailFromHeader,
    this.host,
    this.password,
    this.encryption,
    this.folder,
    this.deleteAfterImport,
    this.calendarId,
    this.hideFromClient,
    this.ticketstatusid,
    this.isdefault,
    this.statuscolor,
    this.statusorder,
    this.serviceid,
    this.company,
    this.vat,
    this.phonenumber,
    this.country,
    this.city,
    this.zip,
    this.state,
    this.address,
    this.website,
    this.datecreated,
    this.active,
    this.leadid,
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
    this.staffid,
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
    this.priorityid,
    this.fromName,
    this.ticketEmail,
    this.departmentName,
    this.priorityName,
    this.serviceName,
    this.statusName,
    this.userFirstname,
    this.userLastname,
    this.staffFirstname,
    this.staffLastname,
    required this.ticketReplies,
  });

  factory SupportTicketDetailsModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketDetailsModel(
      ticketid: json['ticketid'],
      adminreplying: json['adminreplying'],
      userid: json['userid'],
      relType: json['rel_type'],
      contactid: json['contactid'],
      mergedTicketId: json['merged_ticket_id'],
      email: json['email'],
      name: json['name'],
      department: json['department'],
      priority: json['priority'],
      status: json['status'],
      service: json['service'],
      ticketkey: json['ticketkey'],
      subject: json['subject'],
      message: json['message'],
      admin: json['admin'],
      date: json['date'],
      projectId: json['project_id'],
      lastreply: json['lastreply'],
      clientread: json['clientread'],
      adminread: json['adminread'],
      assigned: json['assigned'],
      staffIdReplying: json['staff_id_replying'],
      cc: json['cc'],
      departmentid: json['departmentid'],
      imapUsername: json['imap_username'],
      emailFromHeader: json['email_from_header'],
      host: json['host'],
      password: json['password'],
      encryption: json['encryption'],
      folder: json['folder'],
      deleteAfterImport: json['delete_after_import'],
      calendarId: json['calendar_id'],
      hideFromClient: json['hidefromclient'],
      ticketstatusid: json['ticketstatusid'],
      isdefault: json['isdefault'],
      statuscolor: json['statuscolor'],
      statusorder: json['statusorder'],
      serviceid: json['serviceid'],
      company: json['company'],
      vat: json['vat'],
      phonenumber: json['phonenumber'],
      country: json['country'],
      city: json['city'],
      zip: json['zip'],
      state: json['state'],
      address: json['address'],
      website: json['website'],
      datecreated: json['datecreated'],
      active: json['active'],
      leadid: json['leadid'],
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
      newPassKey: json['newpasskey'],
      newPassKeyRequested: json['newpasskeyrequested'],
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
      creditNoteEmails: json['creditnote_emails'],
      contractEmails: json['contract_emails'],
      taskEmails: json['task_emails'],
      projectEmails: json['project_emails'],
      ticketEmails: json['ticket_emails'],
      staffid: json['staffid'],
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
      priorityid: json['priorityid'],
      fromName: json['from_name'],
      ticketEmail: json['ticket_email'],
      departmentName: json['department_name'],
      priorityName: json['priority_name'],
      serviceName: json['service_name'],
      statusName: json['status_name'],
      userFirstname: json['user_firstname'],
      userLastname: json['user_lastname'],
      staffFirstname: json['staff_firstname'],
      staffLastname: json['staff_lastname'],
      ticketReplies: (json['ticket_replies'] as List<dynamic>?)
          !.map((e) => TicketReply.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  factory SupportTicketDetailsModel.empty() {
    return SupportTicketDetailsModel(
      ticketid: null,
      adminreplying: null,
      userid: null,
      relType: null,
      contactid: null,
      mergedTicketId: null,
      email: null,
      name: null,
      department: null,
      priority: null,
      status: null,
      service: null,
      ticketkey: null,
      subject: null,
      message: null,
      admin: null,
      date: null,
      projectId: null,
      lastreply: null,
      clientread: null,
      adminread: null,
      assigned: null,
      staffIdReplying: null,
      cc: null,
      departmentid: null,
      imapUsername: null,
      emailFromHeader: null,
      host: null,
      password: null,
      encryption: null,
      folder: null,
      deleteAfterImport: null,
      calendarId: null,
      hideFromClient: null,
      ticketstatusid: null,
      isdefault: null,
      statuscolor: null,
      statusorder: null,
      serviceid: null,
      company: null,
      vat: null,
      phonenumber: null,
      country: null,
      city: null,
      zip: null,
      state: null,
      address: null,
      website: null,
      datecreated: null,
      active: null,
      leadid: null,
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
      staffid: null,
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
      priorityid: null,
      fromName: null,
      ticketEmail: null,
      departmentName: null,
      priorityName: null,
      serviceName: null,
      statusName: null,
      userFirstname: null,
      userLastname: null,
      staffFirstname: null,
      staffLastname: null,
      ticketReplies: [],
    );
  }
}

class TicketReply {
  final String id;
  final String? fromName;
  final String? replyEmail;
  final String admin;
  final String userid;
  final String message;
  final String date;
  final String contactId;
  final String submitter;
  final List<Attachment> attachments;

  TicketReply({
    required this.id,
    this.fromName,
    this.replyEmail,
    required this.admin,
    required this.userid,
    required this.message,
    required this.date,
    required this.contactId,
    required this.submitter,
    required this.attachments,
  });

  factory TicketReply.fromJson(Map<String, dynamic> json) {
    return TicketReply(
      id: json['id'],
      fromName: json['from_name'],
      replyEmail: json['reply_email'],
      admin: json['admin'],
      userid: json['userid'],
      message: json['message'],
      date: json['date'],
      contactId: json['contactid'],
      submitter: json['submitter'],
      attachments: (json['attachments'] as List<dynamic>)
          .map((attachment) => Attachment.fromJson(attachment))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from_name': fromName,
      'reply_email': replyEmail,
      'admin': admin,
      'userid': userid,
      'message': message,
      'date': date,
      'contactid': contactId,
      'submitter': submitter,
      'attachments': attachments.map((attachment) => attachment.toJson()).toList(),
    };
  }
}

class Attachment {
  final String id;
  final String ticketId;
  final String replyId;
  final String fileName;
  final String fileType;
  final String dateAdded;
  final String full_file_name;

  Attachment({
    required this.id,
    required this.ticketId,
    required this.replyId,
    required this.fileName,
    required this.fileType,
    required this.dateAdded,
    required this.full_file_name,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      ticketId: json['ticketid'],
      replyId: json['replyid'],
      fileName: json['file_name'],
      fileType: json['filetype'],
      dateAdded: json['dateadded'],
      full_file_name: json['full_file_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketid': ticketId,
      'replyid': replyId,
      'file_name': fileName,
      'filetype': fileType,
      'dateadded': dateAdded,
      'full_file_name': full_file_name,
    };
  }
}
