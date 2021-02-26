defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Valid User",
        password: "123456",
        nickname: "valid_user",
        email: "valid.user@email.com",
        age: 18
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Valid User", email: "valid.user@email.com", id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "invalid User",
        password: "12345",
        nickname: "invalid_user",
        email: "invalid.user@email.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{age: ["must be greater than or equal to 18"],
                            password: ["should be at least 6 character(s)"]}

      assert errors_on(changeset) == expected_response
    end
  end
end
