defmodule Myapp.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %Myapp.Account.User{
          name: "John Smith",
          email: "jsmith@mail.com",
          password: "password"
        }
      end
    end
  end
end
