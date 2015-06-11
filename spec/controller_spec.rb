require 'fixtures/application'
require 'fixtures/controllers'
require 'rspec/rails'
require 'spec_helper'

describe FoldersController, type: :controller do
  describe '#index' do
    get :index
  end
end
