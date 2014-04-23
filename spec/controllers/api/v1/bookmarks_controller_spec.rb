require 'spec_helper'

describe Api::V1::BookmarksController do
  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe 'GET :index' do
    let!(:second_bookmark) { create(:bookmark, name: 'A second', updated_at: 1.day.ago) }
    let!(:first_bookmark) { create(:bookmark, name: 'First', updated_at: 2.days.ago) }
    before do
      get :index
    end
    it { should respond_with :ok }
    it { expect(response.content_type).to eq 'application/json' }
    it { expect(json).to have_key('bookmarks') }
    it { expect(json['bookmarks'].length).to eq 2 }
    it 'orders bookmarks by datetime descending' do
      expect(json['bookmarks']).to eq ActiveModel::ArraySerializer.new(Bookmark.all).to_array
    end
  end

  describe 'POST :create' do
    context 'with valid params' do
      let(:test_bookmark_values) { FactoryGirl.attributes_for(:bookmark, name: 'create_bookmark_test') }
      before do
        post :create, bookmark: test_bookmark_values
      end
      it { should respond_with :created }
      it { expect(response.content_type).to eq 'application/json' }
      it { expect(json).to have_key('bookmark') }
      it { expect(json['bookmark']['name']).to eq test_bookmark_values[:name] }
      it 'creates the bookmark' do
        expect(Bookmark.find_by(name: test_bookmark_values[:name]).name).to eq test_bookmark_values[:name]
      end
    end
  end

  describe 'PUT :update' do
    context 'with valid params' do
      with :bookmark
      let(:new_name) { 'New name' }
      before do
        put :update, id: bookmark.id, bookmark: { name: new_name }
      end
      it { should respond_with :ok }
      it { expect(response.content_type).to eq 'application/json' }
      it { expect(json).to have_key('bookmark') }
      it { expect(Bookmark.find(bookmark.id).name).to eq new_name }
    end
  end

  describe 'DELETE :destroy' do
    context 'with valid params' do
      let!(:bookmark) { create(:bookmark) }
      before do
        delete :destroy, id: bookmark.id
      end
      it { should respond_with :no_content }
      it { expect(response.content_type).to eq 'application/json' }
      it { expect(Bookmark.where(id: bookmark.id)).to_not exist }
      it { expect(json['bookmark']['name']).to eq bookmark.name }
    end
  end
end
