require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager")

require_relative './models/link'
require_relative './models/tag'

DataMapper.finalize

DataMapper.auto_upgrade!
