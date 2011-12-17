require 'jay_z'
require 'jay_z/railtie'

ActiveRecord::Base.extend(JayZ)
JayZ::ActiveRecord::Base = ActiveRecord::Base
JayZ::ActiveRecord::IdentityMap = ActiveRecord::IdentityMap
