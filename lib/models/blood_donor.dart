class BloodDonor {
  final String? donorId, name, nic, status;
  final String? address, phone, dob, gender;
  final String? bloodGroup, donationCount, lastDonatedDate;
  final List<String>? donationHistory;

  BloodDonor(
      {this.donorId,
      this.name,
      this.status,
      this.nic,
      this.address,
      this.phone,
      this.dob,
      this.gender,
      this.bloodGroup,
      this.donationCount,
      this.lastDonatedDate,
      this.donationHistory});
}
