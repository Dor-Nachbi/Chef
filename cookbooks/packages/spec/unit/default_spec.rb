require_relative '../spec_helper'

describe 'packages::default' do
  context 'packages attribute is an array' do
    context 'default action is install' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.override['packages-cookbook'] = ['git']
        end.converge(described_recipe)
      end

      it 'installs git' do
        expect(chef_run).to install_package('git')
      end
    end

    context 'default action is install multiple' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.override['packages-cookbook'] = %w( bash openssl )
        end.converge(described_recipe)
      end

      it 'installs bash and openssl' do
        expect(chef_run).to install_package(%w( bash openssl ))
      end
    end

    context 'default action is install multiple separately' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.12') do |node|
          node.override['packages-cookbook'] = %w( bash openssl )
        end.converge(described_recipe)
      end

      it 'installs bash' do
        expect(chef_run).to install_package('bash')
      end
      it 'installs openssl' do
        expect(chef_run).to install_package('openssl')
      end
    end

    context 'default action is upgrade' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.override['packages-cookbook'] = ['git']
          node.override['packages-cookbook_default_action'] = 'upgrade'
        end.converge(described_recipe)
      end

      it 'upgrades git' do
        expect(chef_run).to upgrade_package('git')
      end
    end

    context 'default action is upgrade multiple' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.override['packages-cookbook'] = %w( bash openssl)
          node.override['packages-cookbook_default_action'] = 'upgrade'
        end.converge(described_recipe)
      end

      it 'upgrades bash and openssl' do
        expect(chef_run).to upgrade_package(%w( bash openssl ))
      end
    end
  end

  context 'packages attribute is a hash' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04') do |node|
        node.override['packages-cookbook'] = { 'bash' => 'install', 'openssl' => 'upgrade', 'xorg-common' => 'remove' }
      end.converge(described_recipe)
    end

    it 'installs bash' do
      expect(chef_run).to install_package(%w( bash openssl xorg-common ))
      expect(chef_run).to_not install_package('openssl')
      expect(chef_run).to_not install_package('xorg-common')
    end

    it 'upgrades openssl' do
      expect(chef_run).to upgrade_package(%w( bash openssl xorg-common ))
      expect(chef_run).to_not upgrade_package('bash')
      expect(chef_run).to_not upgrade_package('xorg-common')
    end

    it 'removes xorg-common' do
      expect(chef_run).to remove_package(%w( bash openssl xorg-common ))
      expect(chef_run).to_not remove_package('bash')
      expect(chef_run).to_not remove_package('openssl')
    end
  end
end
