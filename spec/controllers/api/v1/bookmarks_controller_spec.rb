require 'spec_helper'

describe Api::V1::BookmarksController do
  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe 'GET :index' do
    with :folder
    let!(:second_bookmark) { create(:bookmark, name: 'Second', updated_at: 2.day.ago, folder: folder) }
    let!(:first_bookmark) { create(:bookmark, name: 'First', updated_at: 1.days.ago, folder: folder) }
    before do
      get :index, folder_id: folder.id
    end
    it { should respond_with :ok }
    it { expect(response.content_type).to eq 'application/json' }
    it { expect(json).to have_key('bookmarks') }
    it { expect(json['bookmarks'].length).to eq 2 }
    it 'orders bookmarks by updated_at descending' do
      expect(json['bookmarks']).to eq ActiveModel::ArraySerializer.new([first_bookmark, second_bookmark]).to_array
    end
  end

  describe 'POST :create' do
    context 'with valid params' do
      with :folder
      let(:test_bookmark_values) { attributes_for(:bookmark, name: 'create_bookmark_test', folder: folder) }
      before do
        post :create, folder_id: folder.id, bookmark: test_bookmark_values
      end
      it { should respond_with :created }
      it { expect(response.content_type).to eq 'application/json' }
      it { expect(json).to have_key('bookmark') }
      it { expect(json['bookmark']['name']).to eq test_bookmark_values[:name] }
      it 'creates the bookmark' do
        expect(Bookmark.find(json['bookmark']['id']).name).to eq test_bookmark_values[:name]
      end
    end
  end

  describe 'PUT :update' do
    context 'with valid params' do
      with :folder
      let(:bookmark) { create(:bookmark, folder: folder) }
      let(:new_name) { 'New name' }
      before do
        put :update, folder_id: folder, id: bookmark.id, bookmark: { name: new_name }
      end
      it { should respond_with :ok }
      it { expect(response.content_type).to eq 'application/json' }
      it { expect(json).to have_key('bookmark') }
      it { expect(Bookmark.find(bookmark.id).name).to eq new_name }
    end
  end

  describe 'DELETE :destroy' do
    context 'with valid params' do
      with :folder
      let!(:bookmark) { create(:bookmark, folder: folder) }
      before do
        delete :destroy, folder_id: folder.id, id: bookmark.id
      end
      it { should respond_with :no_content }
      it { expect(response.content_type).to eq 'application/json' }
      it { expect(Bookmark.where(id: bookmark.id)).to_not exist }
      it { expect(json['bookmark']['name']).to eq bookmark.name }
    end
  end
end
