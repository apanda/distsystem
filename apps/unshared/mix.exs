defmodule Unshared.Mixfile do
  use Mix.Project

  def project do
    [ app: :unshared,
      version: "0.0.1",
      escript_main_module: Unshared, 
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 0.12.5-dev",
      deps: deps ]
  end

  ## Configuration for the OTP application
  def application do
    [
     applications: [:observable]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  #
  # You can depend on another app in the same umbrella with:
  # { :other, in_umbrella: true }
  defp deps do
    [ {:observable, in_umbrella: true}]
  end
end
