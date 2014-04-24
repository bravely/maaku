require 'spec_helper'

describe Folder do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:name).with_options(null: false) }
  end

  describe '#bookmarks' do
    it { should have_many(:bookmarks) }
  end
end
