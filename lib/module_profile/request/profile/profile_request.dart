class ProfileRequest {
  String userName;

  ProfileRequest({
    this.userName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = this.userName;
    return data;
  }
}
