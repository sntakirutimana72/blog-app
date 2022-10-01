require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do

  path '/api/v1/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :integer, description: 'Author Id'

    get('list posts') do
      consumes 'application/json'

      response(200, '') do
        schema '$ref' => '#/components/schemas/posts'

        let(:user_id) { 12 }

        run_test!
      end

      response(404, 'No posts found') { run_test! }
    end
  end
end
