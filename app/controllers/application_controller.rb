class ApplicationController < ActionController::Base
  before_action -> { @controller_class = self.controller_name }
end
