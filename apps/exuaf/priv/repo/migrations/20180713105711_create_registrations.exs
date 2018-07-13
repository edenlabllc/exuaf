defmodule ExUAF.Repo.Migrations.CreateRegistrationRecords do
  use Ecto.Migration

  def change do
    create table(:registrations, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:authenticator, :uuid)
      add(:public_key, :string, null: false)
      add(:sign_counter, :string, null: false)
      add(:authenticator_version, :string, null: false)
      add(:tc_display_png_characteristics, :string, null: false)
      add(:username, :string, null: false)
      add(:user_id, :string, null: false)
      add(:device_id, :string, null: false)
      add(:time_stamp, :string, null: false)
      add(:status, :string, null: false)
      add(:attest_cert, :string, null: false)
      add(:attest_data_to_sign, :string, null: false)
      add(:attest_signature, :string, null: false)
      add(:attest_verified_status, :string, null: false)

      timestamps()
    end
  end
end
