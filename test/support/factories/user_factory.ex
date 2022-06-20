defmodule Myapp.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Myapp.Account.User{
          name: "John Smith",
          email: sequence(:email, &"gandalf#{&1}@mail.com"),
          # email: sequence(:email, fn n -> "mail#{n}@mail.com" end),
          password: "password"
        }
      end
    end
  end
end
