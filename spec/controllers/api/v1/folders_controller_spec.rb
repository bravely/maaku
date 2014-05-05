require 'spec_helper'

describe Api::V1::FoldersController do
  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe 'GET :index' do
    let!(:folder_two) { create(:folder, name: 'beta') }
    let!(:folder_one) { create(:folder, name: 'alpha') }
    before do
      get :index
    end
    it { should respond_with :ok }
    it { expect(response.content_type).to eq 'application/json' }
    it { expect(json).to have_key 'folders' }
    it { expect(json['folders'].length).to eq 2 }
    it { expect(json['folders'].first).to_not have_key 'bookmarks' }
    it 'orders the folders by updated_at descending' do
      expect(json['folders']).to eq ActiveModel::ArraySerializer.new([folder_one, folder_two], each_serializer: ShallowFolderSerializer).to_array
    end
  end

  describe 'GET :show' do
    with! :folder
    let(:bookmark_one) { create(:bookmark, folder: folder) }
    before do
      get :show, id: folder.id
    end
    it { should respond_with :ok }
    it { expect(response.content_type).to eq 'application/json' }
    it { expect(json).to have_key 'folder' }
    it { expect(json['folder']['name']).to eq folder.name }
    it { expect(json['folder']).to_not have_key 'bookmarks' }
  end

  describe 'POST :create' do
    let(:folder) { attributes_for(:folder, name: 'Create Folder Test') }
    before do
      post :create, folder: folder
    end
    it { should respond_with :created }
    it { expect(response.content_type).to eq 'application/json' }
    it { expect(json['folder']['name']).to eq folder[:name] }
    it 'creates the folder' do
      expect(Folder.find(json['folder']['id']).name).to eq folder[:name]
    end
  end

  describe 'PUT :update' do
    with! :folder
    let(:new_name) { 'Update Folder Test' }
    before do
      put :update, id: folder.id, folder: { name: new_name }
    end
    it { should respond_with :ok }
    it { expect(response.content_type).to eq 'application/json' }
    it { expect(json['folder']['name']).to eq new_name }
    it 'applies the :update changes' do
      expect(Folder.find(json['folder']['id']).name).to eq new_name
    end
  end

  describe 'DELETE :destroy' do
    with! :folder
    before do
      delete :destroy, id: folder
    end
    it { should respond_with :no_content }
    it { expect(response.content_type).to eq 'application/json' }
    it { expect(Folder.where(id: folder.id)).to_not exist }
    it { expect(json['folder']['name']).to eq folder.name }
  end
end
