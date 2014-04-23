require 'spec_helper'

describe '/api/bookmarks routes' do
  it { expect(get: '/api/bookmarks').to route_to('api/v1/bookmarks#index', format: 'json') }
  it { expect(post: '/api/bookmarks').to route_to('api/v1/bookmarks#create', format: 'json') }
  it { expect(put: '/api/bookmarks/123').to route_to('api/v1/bookmarks#update', format: 'json', id: '123') }
  it { expect(delete: '/api/bookmarks/321').to route_to('api/v1/bookmarks#destroy', format: 'json', id: '321') }
end
