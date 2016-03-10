#https://robots.thoughtbot.com/tdd-your-dockerfiles-with-rspec-and-serverspec
require 'docker'
require 'serverspec'
require 'spec_helper'

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.') do |v|
      if (log = JSON.parse(v)) && log.has_key?("stream")
        $stdout.puts log["stream"]
      end
    end

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  describe "Packages installed" do
      packages = ['openssh-server', 'curl', 'lsb-release']
      packages.each do |package|
        describe package("#{package}") do
            it { should be_installed }
        end
     end
  end

  describe command('python --version') do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should contain('Python 2.7') }
  end

  describe command('${ruby} --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain('ruby 2.1') }
  end

  describe command('${gem} --version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain('2.') }
  end

end
