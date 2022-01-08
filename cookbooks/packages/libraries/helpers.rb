#
# Copyright 2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# There isn't an easy way to duck-type whether the package provider on
# an arbitrary platform supports multipackage. While we know it's
# available in Chef 12.1.0+, it is better to ask for the feature,
# rather than ask for the Chef version.
def multipackage_supported?
  resource = Chef::Resource::Package.new('', node)
  provider = resource.provider_for_action(:install)
  if provider.respond_to?('use_multipackage_api?') && provider.use_multipackage_api?
    Chef::Log.debug("This version of #{provider.class} supports 'multipackage'")
    return true
  else
    Chef::Log.debug("This version of #{provider.class} does not support 'multipackage'")
    return false
  end
end
