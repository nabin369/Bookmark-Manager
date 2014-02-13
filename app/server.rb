require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

require './app/models/link' # this needs to be done after datamapper is initialized
require './app/models/tag'
require './app/models/user'

require_relative 'helpers/application'
require_relative 'data_mapper'

require_relative 'controllers/session'
require_relative 'controllers/user'
require_relative 'controllers/link'
require_relative 'controllers/tag'
require_relative 'controllers/main'

use Rack::Flash

set :partial_template_engine, :erb

enable :sessions
set :session_secret, 'super secret'


