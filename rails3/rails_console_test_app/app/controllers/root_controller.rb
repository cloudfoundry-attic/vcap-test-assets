class RootController < ApplicationController
  def index
    render :text => "running version #{RUBY_VERSION}"
  end
end
