require 'spec_helper'

describe User do
  describe '#username' do
    it { should validate_presence_of(:username) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:username).with_options(null: false) }
  end

  describe '#folders' do
    it { should have_many(:folders) }
  end
end
