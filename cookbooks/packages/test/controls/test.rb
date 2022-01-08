# # encoding: utf-8
# # author: Matt Ray

control 'Validate packages cookbook' do
  impact 1.0
  title 'Test packages cookbook'
  desc 'Test packages cookbook'

  %w( grep nano scrub ).each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
