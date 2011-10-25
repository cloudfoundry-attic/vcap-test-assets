require 'datamapper'

class User
  include DataMapper::Resource

  property :id,           String, :key => true, :required => true, :unique => true
  property :desc,         String

end
