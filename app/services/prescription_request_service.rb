class PrescriptionRequestService < ApplicationService
  def initialize(patient_user)
    @patient_user = patient_user
  end

  def call
    charge_for_prescription
    message_admin
  end

  private

  attr_reader :patient_user

  def message_admin
    PostMessageService.call(
      "The patient_user #{patient_user.full_name} requested a new copy of a prescription",
      from: patient_user,
      to: User.default_admin
    )
  end

  def charge_for_prescription
    PaymentService.call(patient_user)
  end
end
