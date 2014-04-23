require 'spec_helper'

describe Bookmark do

  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:name).with_options(null: false) }
  end

  describe '#url' do
    it { should validate_presence_of(:url) }
    it { should have_db_column(:url).of_type(:string) }
    it { should have_db_column(:url).with_options(null: false) }
    it { should allow_value('http://www.google.com').for(:url) }
    it { should allow_value('https://lol.foo').for(:url) }
    it { should allow_value('https://example.com#testjs/route').for(:url) }
    it { should_not allow_value('wut.lol').for(:url) }
  end

  describe '#all' do
    context 'with multiple bookmarks' do
      let!(:first_bookmark) { create(:bookmark, name: 'First', updated_at: 2.days.ago) }
      let!(:second_bookmark) { create(:bookmark, name: 'A second', updated_at: 1.day.ago) }
      subject { Bookmark.all }
      it { should eq [second_bookmark, first_bookmark] }
    end
  end
end
