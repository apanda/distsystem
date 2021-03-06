defmodule Observable.Mixfile do
  use Mix.Project

  def project do
    [ app: :observable,
      version: "0.0.1",
      elixir: "~> 0.12.5-dev",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Observable, "observer" },
     applications: [:logger ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [ {:logger, in_umbrella: true} ]
  end
end
