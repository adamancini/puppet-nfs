
require 'spec_helper'
describe 'nfs::server::ubuntu', :type => :class do
  it do
    should contain_class('nfs::client::ubuntu')
    should contain_class('nfs::server::ubuntu::service')
    should contain_package('nfs-kernel-server')
    should contain_service('nfs-kernel-server').with( 'ensure' => 'running'  )
  end
  context ":nfs_v4 => true" do
    let(:params) {{ :nfs_v4 => true }}
    it do
      should contain_service('idmapd').with( 'ensure' => 'running'  )
    end

  context "mountd params set port" do
    let(:params) {{ :mountd_port => '4711' }}
    it do
      should contain_file_line('rpc-mount-options-port') #.with( 'ensure' => 'present' )
    end
  end

  context "mountd params set threads" do
    let(:params) {{ :mountd_threads => '11' }}
    it do
      should contain_file_line('rpc-mount-options-threads') #.with( 'ensure' => 'present' )
    end
  end

end
