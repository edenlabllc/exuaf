defmodule ExUAF.Repo.Migrations.CreateAuthenticators do
  use Ecto.Migration

  def change do
    create table(:authenticators, primary_key: false) do
      add(:id, :uuid, primary_key: true, default: fragment("gen_random_uuid()"))
      add(:key_id, :string, null: false)
      add(:device_id, :string, null: true)
      add(:aaid, :string, null: false)
      add(:status, :string, null: true, size: 20)
      add(:username, :string, null: false)

      add :inserted_at, :naive_datetime, default: fragment("now()")
      add :updated_at, :naive_datetime, default: fragment("now()")
    end
  end
end