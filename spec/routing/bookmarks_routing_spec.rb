require 'spec_helper'

describe '/api/bookmarks routes' do
  it { expect(get: '/api/folders/456/bookmarks').to route_to('api/v1/bookmarks#index', format: 'json', folder_id: '456') }
  it { expect(post: '/api/folders/456/bookmarks').to route_to('api/v1/bookmarks#create', format: 'json', folder_id: '456') }
  it { expect(put: '/api/folders/456/bookmarks/123').to route_to('api/v1/bookmarks#update', format: 'json', folder_id: '456', id: '123') }
  it { expect(delete: '/api/folders/456/bookmarks/321').to route_to('api/v1/bookmarks#destroy', format: 'json', folder_id: '456', id: '321') }
end
