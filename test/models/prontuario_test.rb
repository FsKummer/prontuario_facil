require "test_helper"

class ProntuarioTest < ActiveSupport::TestCase
  test "Should not create prontuario without an user_id" do
    prontuario = Prontuario.new
    assert_not prontuario.save, "Saved without a user"
  end

  test "Should not create prontuario without a name" do
    prontuario = Prontuario.new
    assert_not prontuario.save, "Saved without a name"
  end

  test "Should create a prontuario correctly when provided an user and a name" do
    user = User.first
    prontuario = Prontuario.new(user: user, nome: "Prontuario pacientes sanatório NukaCola")
    assert prontuario.save
  end
end
