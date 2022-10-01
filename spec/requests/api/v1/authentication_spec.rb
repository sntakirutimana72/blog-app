require 'swagger_helper'

RSpec.describe 'api/v1/authentication', type: :request do

  path '/api/v1/auth/login' do

    post('authenticate') do

      consumes 'application/json'
      produces 'application/json'

      parameter name: :auth, in: :body, schema: { '$ref' => '#/components/schemas/auth' }

      response(200, '') do
        schema '$ref' => '#/components/schemas/auth_success'

        run_test!
      end

      response(401, 'unauthorized') { run_test! }
    end
  end
end
