defmodule Myapp.Factory do
  use ExMachina.Ecto, repo: Myapp.Repo

  use Myapp.UserFactory
end
