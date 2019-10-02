# -*- encoding: utf-8 -*-
# stub: mtg_sdk 3.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mtg_sdk".freeze
  s.version = "3.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrew Backes".freeze]
  s.date = "2017-10-08"
  s.description = "Magic: The Gathering SDK is a wrapper around the MTG API located at magicthegathering.io".freeze
  s.email = ["backes.andrew@gmail.com".freeze]
  s.homepage = "https://magicthegathering.io".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Magic: The Gathering SDK for magicthegathering.io".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 11.2"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.9"])
      s.add_development_dependency(%q<vcr>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 2.1"])
      s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.12"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.6"])
      s.add_runtime_dependency(%q<roar>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<json>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<multi_json>.freeze, ["~> 1.12"])
      s.add_runtime_dependency(%q<multi_xml>.freeze, ["~> 0.5"])
      s.add_runtime_dependency(%q<faraday_middleware>.freeze, ["~> 0.10"])
      s.add_runtime_dependency(%q<virtus>.freeze, ["~> 1.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
      s.add_dependency(%q<rake>.freeze, ["~> 11.2"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.9"])
      s.add_dependency(%q<vcr>.freeze, ["~> 3.0"])
      s.add_dependency(%q<webmock>.freeze, ["~> 2.1"])
      s.add_dependency(%q<simplecov>.freeze, ["~> 0.12"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.8"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.6"])
      s.add_dependency(%q<roar>.freeze, ["~> 1.0"])
      s.add_dependency(%q<json>.freeze, ["~> 2.0"])
      s.add_dependency(%q<multi_json>.freeze, ["~> 1.12"])
      s.add_dependency(%q<multi_xml>.freeze, ["~> 0.5"])
      s.add_dependency(%q<faraday_middleware>.freeze, ["~> 0.10"])
      s.add_dependency(%q<virtus>.freeze, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, ["~> 11.2"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.9"])
    s.add_dependency(%q<vcr>.freeze, ["~> 3.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 2.1"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.12"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.6"])
    s.add_dependency(%q<roar>.freeze, ["~> 1.0"])
    s.add_dependency(%q<json>.freeze, ["~> 2.0"])
    s.add_dependency(%q<multi_json>.freeze, ["~> 1.12"])
    s.add_dependency(%q<multi_xml>.freeze, ["~> 0.5"])
    s.add_dependency(%q<faraday_middleware>.freeze, ["~> 0.10"])
    s.add_dependency(%q<virtus>.freeze, ["~> 1.0"])
  end
end
