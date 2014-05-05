require 'spec_helper'

describe '/api/folders routes' do
  it { expect(get: '/api/folders').to route_to('api/v1/folders#index', format: 'json') }
  it { expect(post: '/api/folders').to route_to('api/v1/folders#create', format: 'json') }
  it { expect(get: '/api/folders/123').to route_to('api/v1/folders#show', format: 'json', id: '123') }
  it { expect(put: '/api/folders/123').to route_to('api/v1/folders#update', format: 'json', id: '123') }
  it { expect(delete: '/api/folders/123').to route_to('api/v1/folders#destroy', format: 'json', id: '123') }
end
