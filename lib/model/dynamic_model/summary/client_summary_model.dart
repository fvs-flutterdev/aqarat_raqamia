class ClientSummaryModel {
  Applicant? applicant;

  ClientSummaryModel({this.applicant});

  ClientSummaryModel.fromJson(Map<String, dynamic> json) {
    applicant = json['applicant'] != null
        ? new Applicant.fromJson(json['applicant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applicant != null) {
      data['applicant'] = this.applicant!.toJson();
    }
    return data;
  }
}

class Applicant {
  int? pendingRequests;
  int? acceptedRequests;
  int? finishedRequests;

  Applicant(
      {this.pendingRequests, this.acceptedRequests, this.finishedRequests});

  Applicant.fromJson(Map<String, dynamic> json) {
    pendingRequests = json['pending_requests'];
    acceptedRequests = json['accepted_requests'];
    finishedRequests = json['finished_requests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending_requests'] = this.pendingRequests;
    data['accepted_requests'] = this.acceptedRequests;
    data['finished_requests'] = this.finishedRequests;
    return data;
  }
}