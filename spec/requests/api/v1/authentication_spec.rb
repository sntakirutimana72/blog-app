require 'swagger_helper'

RSpec.describe 'api/v1/authentication', type: :request do

  path '/api/v1/auth/login' do

    post('create authentication') do

      consumes 'application/json'
      produces 'application/json'

      parameter name: :auth, in: :body, schema: { '$ref' => '#/components/schemas/auth' }

      response(200, '') do
        schema '$ref' => '#/components/schemas/auth_success'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'unauthorized') { run_test! }
    end
  end
end
